import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from sar_adc_nonideal_comparator.sar_adc import sar_adc
from sar_adc_nonideal_comparator.model_generators.sample_and_hold import *
import pytest
import copy
import numpy as np

import matplotlib.pyplot as plt


@pytest.mark.parametrize("voltage,",[1.6,2.7,0.5,3.29,0.1])
def test_sar_adc_basic(voltage,cmdline_opts,plot):
    def sar_sim_tick(dut, input_voltage, input_control,sys_clk):
        dut.input_voltage_real @= input_voltage
        dut.input_hold_digital @= input_control
        dut.sys_clk @= sys_clk
        eoc = copy.deepcopy(dut.eoc)
        output_result = copy.deepcopy(dut.output_result_digital)

        dut.sim_tick()
        return eoc, output_result
    
    
    def i_to_clk(i,sys_clk_state,div=2):
        if(i == 0):
            return sys_clk_state
        if sys_clk_state == 0:
            if (i % (div//2) == 0):
                return 1
            else:
                return 0
        else:
            if (i % (div) == 0):

                return 0
            else:
                return 1





    sar = sar_adc()
    dut = config_model_with_cmdline_opts(sar, cmdline_opts,duts=[])
    dut.apply( DefaultPassGroup(linetrace = True))

    dut.sim_reset()

    def run_test(voltage):
        def to_bits(v):
            return dac_ams_block.nodes['transparent'].block.get_var('input_voltage_real').type.from_real(v)

        vec = []
        sys_clk_state = 0
        sys_clk_vec = []
        div = 200
        for i in range(18 * div):
            sys_clk_state = i_to_clk(i,sys_clk_state,div=div)
            sys_clk_vec.append(sys_clk_state)
            if(i < 3):
            
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)), 0x0,sys_clk_state)
                vec.append(3.3 * int(quantvolt) / (2**10))
            else:
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)),0x1,sys_clk_state)
                vec.append(3.3 * int(quantvolt) / (2**10))
        diff = abs(voltage - (3.3 * int(quantvolt) / (2**10)))
        delta = ((100/(2**10)))#Relative Precision of (1/0.01) * quantization error (1/2**10)


        if(plot):
            plt.plot(range(len(vec)),vec, label='digital output voltage')
            plt.plot(range(len(vec)),np.full(len(vec),voltage),label='input voltage')
            plt.title('SAR-ADC Quantized Output Voltage vs. Simulation Cycles')
            plt.xlabel('simulation clock cycles')
            plt.ylabel('voltage')
            plt.legend()
            plt.savefig('sar_adc_involtage{}.pdf'.format(voltage))
            plt.clf()
        assert eoc == Bits(1,v=1) and diff < delta, "[FAILED] difference > delta {} > {}".format(diff, delta)


    run_test(voltage)

@pytest.mark.parametrize("voltage,",[1.6,2.7,0.5,3.29,0.1])
def test_sar_adc_thrash_input(voltage,cmdline_opts,plot):
    def sar_sim_tick(dut, input_voltage, input_control,sys_clk):
        dut.input_voltage_real @= input_voltage
        dut.input_hold_digital @= input_control
        dut.sys_clk @= sys_clk
        eoc = copy.deepcopy(dut.eoc)
        output_result = copy.deepcopy(dut.output_result_digital)

        dut.sim_tick()
        return eoc, output_result


    def i_to_clk(i,sys_clk_state,div=2):
        if sys_clk_state == 0:
            if (i % (div//2) == 0):
                return 1
            else:
                return 0
        else:
            if (i % (div) == 0):

                return 0
            else:
                return 1



    sar = sar_adc()
    dut = config_model_with_cmdline_opts(sar, cmdline_opts,duts=[])
    dut.apply( DefaultPassGroup(linetrace = True))

    dut.sim_reset()

    def run_test(voltage):
        def to_bits(v):
            return dac_ams_block.nodes['transparent'].block.get_var('input_voltage_real').type.from_real(v)

        vec = []
        volt_in = []
        sys_clk_state = 0
        sys_clk_vec = []
        div = 200
        for i in range(19 * div):
            sys_clk_state = i_to_clk(i,sys_clk_state,div=div)
            sys_clk_vec.append(sys_clk_state)
            if( i < 2):
                randvolt = random.uniform(0,3.3)
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(randvolt)), 0x0, sys_clk_state)
                volt_in.append(randvolt)
            elif(i == 2):
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)), 0x0, sys_clk_state)
                volt_in.append(voltage)
                sys_clk_state = i_to_clk(i,sys_clk_state,div=div)
                sys_clk_vec.append(sys_clk_state)
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)), 0x1, sys_clk_state)
                volt_in.append(voltage)
                vec.append(3.3 * int(quantvolt) / (2**10))
            else:
                randvolt = random.uniform(0,3.3)
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(randvolt)),0x1, sys_clk_state)
                volt_in.append(randvolt)
            vec.append(3.3 * int(quantvolt) / (2**10))
        
        diff = abs(voltage - (3.3 * int(quantvolt) / (2**10)))
        delta = ((100/(2**10)))

        if(plot):
            plt.plot(range(len(vec)),vec, label='digital output voltage')
            plt.plot(range(len(vec)),np.full(len(vec),voltage),label='desired voltage measurement')
            plt.plot(range(len(vec)),volt_in,label='input voltage')
            plt.title('SAR-ADC Quantized Output Voltage vs. Simulation Cycles')
            plt.xlabel('simulation clock cycles')
            plt.ylabel('voltage')
            plt.legend()
            plt.savefig('sar_adc_involtage{}_thrash.pdf'.format(voltage))
            plt.clf()
        assert eoc == Bits(1,v=1) and diff < delta, "[FAILED] difference > delta {} > {}".format(diff, delta)



    run_test(voltage)


@pytest.mark.parametrize("voltage,",[1.6,2.7,0.5,3.29,0.1])
def test_sar_adc_simple(voltage,cmdline_opts,plot):
    def sar_sim_tick(dut, input_voltage, input_control,sys_clk):
        dut.input_voltage_real @= input_voltage
        dut.input_hold_digital @= input_control
        dut.sys_clk @= sys_clk
        eoc = copy.deepcopy(dut.eoc)
        output_result = copy.deepcopy(dut.output_result_digital)

        dut.sim_tick()
        return eoc, output_result
    
    
    def i_to_clk(i,sys_clk_state,div=2):
        if(i == 0):
            return sys_clk_state
        if sys_clk_state == 0:
            if (i % (div//2) == 0):
                return 1
            else:
                return 0
        else:
            if (i % (div) == 0):

                return 0
            else:
                return 1
            
    def to_bits(v):
        return Bits(10,v=dac_ams_block.nodes['transparent'].block.get_var('input_voltage_real').type.from_real(v))

    sar = sar_adc()
    dut = config_model_with_cmdline_opts(sar, cmdline_opts,duts=[])
    dut.apply( DefaultPassGroup(linetrace = True))

    dut.sim_reset()

    sys_clk_state = 0
    clk_div = 200

    for i in range(18 * clk_div):
        sys_clk_state = i_to_clk(i, sys_clk_state, clk_div)
        if(i < 3):
            eoc, quantvolt = sar_sim_tick(dut, to_bits(voltage), 0x0, sys_clk_state)
        else:
            eoc, quantvolt = sar_sim_tick(dut, to_bits(voltage), 0x1, sys_clk_state)

    diff = abs(voltage - (3.3 * int(quantvolt) / (2**10)))
    delta = ((100/(2**10)))#Relative Precision of (1/0.01) * quantization error (1/2**10)


    assert eoc == Bits(1,v=1) and diff < delta, "[FAILED] difference > delta {} > {}".format(diff, delta)


