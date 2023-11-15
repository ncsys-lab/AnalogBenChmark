import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from sar_adc.sar_adc import sar_adc
from sar_adc.model_generators.sample_and_hold import *
import pytest
import copy
import numpy as np

import matplotlib.pyplot as plt


@pytest.mark.parametrize("voltage,",[1.6,2.7,0.5,3.29,0.1])
def test_sar_adc_basic(voltage,cmdline_opts,plot):
    def sar_sim_tick(dut, input_voltage, input_control):
        dut.input_voltage_real @= input_voltage
        dut.input_hold_digital @= input_control
        eoc = copy.deepcopy(dut.eoc)
        output_result = copy.deepcopy(dut.output_result_digital)

        dut.sim_tick()
        return eoc, output_result




    sar = sar_adc()
    dut = config_model_with_cmdline_opts(sar, cmdline_opts,duts=[])
    dut.apply( DefaultPassGroup(linetrace = True))

    dut.sim_reset()

    def run_test(voltage):
        def to_bits(v):
            return dac_ams_block.nodes['transparent'].block.get_var('input_voltage_real').type.from_real(v)

        vec = []
        for i in range(13):
            if(i < 3):
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)), 0x0)
                vec.append(3.3 * int(quantvolt) / (2**10))
            else:
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)),0x1)
                vec.append(3.3 * int(quantvolt) / (2**10))
        diff = abs(voltage - (3.3 * int(quantvolt) / (2**10)))
        delta = ((10/(2**10)))


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

