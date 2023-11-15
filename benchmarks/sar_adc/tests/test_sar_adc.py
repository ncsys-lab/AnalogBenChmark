import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from sar_adc.sar_adc import sar_adc
from sar_adc.model_generators.sample_and_hold import *
import pytest
import copy


@pytest.mark.parametrize("voltage,",[1.6,2.7,0.5,3.29,0.1])
def test_sar_adc_basic(voltage,cmdline_opts):
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
                sar_sim_tick(dut,Bits(10,v=to_bits(voltage)), 0x0)
            else:
                eoc, quantvolt = sar_sim_tick(dut,Bits(10,v=to_bits(voltage)),0x1)
        diff = abs(voltage - (3.3 * int(quantvolt) / (2**10)))
        delta = ((10/(2**10)))
        assert eoc == Bits(1,v=1) and diff < delta, "[FAILED] difference > delta {} > {}".format(diff, delta)



    run_test(voltage)

