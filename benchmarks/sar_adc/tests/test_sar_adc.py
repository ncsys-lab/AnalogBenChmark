import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from sar_adc.sar_adc import sar_adc
from sar_adc.model_generators.sample_and_hold import *

def test_sar_adc_basic(cmdline_opts):
    sar = sar_adc()


    def generate_test_vector():
        def to_bits(v):
            return dac_ams_block.nodes['transparent'].block.get_var('input_voltage_real').type.from_real(v)


        vec = []
        for i in range(13):
            if(i < 3):
                app_vec = [Bits(10,v=to_bits(2.9)), 0x0, '?', '?']
            else:
                app_vec = [Bits(10,v=to_bits(2.9)), 0x1, '?', '?']
            vec.append(app_vec)
        return vec

        
    
    test_vector = [
        ('input_voltage_real input_hold_digital eoc* output_result_digital*'),
    ] + generate_test_vector()

    run_test_vector_sim(sar, test_vector, cmdline_opts)

