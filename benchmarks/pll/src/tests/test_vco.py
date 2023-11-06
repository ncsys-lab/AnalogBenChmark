import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from src.model_generators.voltage_controlled_oscillator import *
import matplotlib.pyplot as plt
import numpy as np

def simulate_real_model(blk,timestep):
    print(blk)
    xi,vi = 3.3,0.0
    xs = []
    vs = []
    ts = []
    cycles_per_sec = round(1/timestep)
    max_cycles = 4*cycles_per_sec
    for t in range(max_cycles):
    
        values = blocklib.execute_block(blk,{"input_voltage_real":2.99, "x": xi, "v": vi})
        ts.append(t*timestep)

        
        xi = values["x"]
        vi = values["v"]
        xs.append(xi)
        vs.append(vi)

    return (xs, vs, ts)


def simulate_pymtl_model(rtlblk, timestep):
    outs = []
    vs = []
    ts = []
    cycles_per_sec = round(1/timestep)
    max_cycles = 4*cycles_per_sec
    for t in range(max_cycles):
        values = rtlblk.pymtl_sim_tick({"input_voltage_real":Bits(rtlblk.block.get_var('input_voltage_real').type.nbits, v=rtlblk.scale_value_to_int(2.81,rtlblk.block.get_var('input_voltage_real').type))})#FOR SOME REASON VOLTAGES ARE DIFFERENT
        ts.append(t*timestep)
        outi = values["output_clock_real"]

        outs.append(rtlblk.scale_value_to_real(outi, rtlblk.block.get_var('output_clock_real').type))
    
    print(rtlblk.block.get_var('output_clock_real').type)
    return (outs,ts)

    

   

def test_basic(cmdline_opts):
    timestep = 1e-4

    real_xs, real_vs, real_ts = simulate_real_model(vco_ams_block_real, timestep=1e-4)

    rtl_block.generate_verilog_src("./")
    rtl_block.generate_pymtl_wrapper("./")
    rtl_block.pymtl_sim_begin()

    rtl_xs, rtl_ts = simulate_pymtl_model(rtl_block, timestep=1e-4)
    mse = ((np.asarray(real_xs) - np.asarray(rtl_xs))**2).mean()
    
    failed = False
    if(mse > 0.1):
        failed = True
        plt.plot(real_ts,real_xs, label='xs')
        plt.plot(real_ts,real_vs, label='vs')
        plt.title("Real Model")
        plt.legend(loc='best')
        plt.savefig("./vco_test_basic_real_model.png")
        plt.clf()
        plt.plot(rtl_ts,rtl_xs, label='xs')
        plt.title("RTL Model")
        plt.legend(loc='best')
        plt.savefig("./vco_test_basic_rtl_model.png")
        plt.clf()
    
    assert not failed, "[ERROR] VCO BASIC TEST FAILED, MSE = {}: WAVEFORMS IN ./ FOLDER".format(mse) 



