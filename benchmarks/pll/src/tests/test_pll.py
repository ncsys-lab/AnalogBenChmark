import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from src.phased_locked_loop import phase_locked_loop

def test_pll(cmdline_opts):
    multiplier = phase_locked_loop()

    def generate_clk_test_vector(cycles = 5000, period = 1000):
        arr = []
        clk = 0
        for i in range(cycles):
            if i % period == 0:
                clk = 0
            elif i % (period//2) == 0:
                clk = 1
            arr.append([clk,'?'])
        return arr

    test_vector = [
        ('reference_clk_digital          output_clk_digital*'),
        [0x0, '?'],
    ] + generate_clk_test_vector()

    run_test_vector_sim(multiplier, test_vector, cmdline_opts)

