import random
from pymtl3 import *
from pymtl3.stdlib.test_utils import run_test_vector_sim, config_model_with_cmdline_opts
from pll_ideal.model_generators.voltage_controlled_oscillator import *
import matplotlib.pyplot as plt
import numpy as np

def simulate_real_model(blk,cycles,timestep = 1e-4):
    print(blk)
    xi,vi = 3.3,0.0
    xs = []
    vs = []
    ts = []
    max_cycles = cycles
    for t in range(max_cycles):
    
        values = blocklib.execute_block(blk,{"input_voltage_real":2.99, "x": xi, "v": vi})
        ts.append(t*timestep)

        
        xi = values["x"]
        vi = values["v"]
        xs.append(xi)
        vs.append(vi)

    return (xs, vs, ts)


def simulate_pymtl_model(rtlblk, cycles,timestep = 1e-4):
    outs = []
    vs = []
    ts = []
    max_cycles = cycles
    for t in range(max_cycles):
        values = rtlblk.pymtl_sim_tick({"input_voltage_real":Bits(rtlblk.block.get_var('input_voltage_real').type.nbits, v=rtlblk.scale_value_to_int(2.99,rtlblk.block.get_var('input_voltage_real').type))})#FOR SOME REASON VOLTAGES ARE DIFFERENT
        ts.append(t*timestep)
        outi = values["output_clock_real"]

        outs.append(rtlblk.scale_value_to_real(outi, rtlblk.block.get_var('output_clock_real').type))
    
    print(rtlblk.block.get_var('output_clock_real').type)
    return (outs,ts)

    

   

def test_real_translation(cmdline_opts, plot):
    timestep = 5e-5

    real_xs, real_vs, real_ts = simulate_real_model(vco_ams_block_real, 4*round(1/timestep),timestep=timestep)

    rtl_block.generate_verilog_src("./")
    rtl_block.generate_pymtl_wrapper("./")
    rtl_block.pymtl_sim_begin()

    rtl_xs, rtl_ts = simulate_pymtl_model(rtl_block, 4*round(1/timestep),timestep=timestep)
    mse = ((np.asarray(real_xs) - np.asarray(rtl_xs))**2).mean()
    
    failed = mse > 0.1 
    if(failed or plot):
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

def test_stable_precision(cmdline_opts, plot):
    timestep = 5e-5
    num_cycles = 1e6
    rtl_block.generate_verilog_src("./")
    rtl_block.generate_pymtl_wrapper("./")
    rtl_block.pymtl_sim_begin()

    rtl_xs, rtl_ts = simulate_pymtl_model(rtl_block, round(num_cycles),timestep=timestep)

    greatest = max(rtl_xs)
    failed = greatest > 3.4
    if(failed or plot):
        plt.plot(rtl_ts,rtl_xs, label='xs')
        plt.title("RTL Model")
        plt.legend(loc='best')
        plt.savefig("./vco_test_precision_rtl_model.png")
        plt.clf()
    assert not failed, "[ERROR] VCO PRECISION TEST FAILED, GREATEST ACHIEVED VALUE IN {} CYCLES = {} > 3.3: WAVEFORMS IN ./ FOLDER".format(num_cycles, greatest) 

def test_thrash(cmdline_opts, plot):
    def simulate_pymtl_model(rtlblk, cycles,timestep = 1e-4):
        outs = []
        vs = []
        ts = []
        max_cycles = cycles
        zero_arr = np.zeros(max_cycles // 5)
        one_arr  = np.ones(max_cycles // 5)
        input_arr = 2 * np.concatenate((one_arr,zero_arr,one_arr,zero_arr,one_arr))
        for t in range(max_cycles):
            values = rtlblk.pymtl_sim_tick({"input_voltage_real":Bits(rtlblk.block.get_var('input_voltage_real').type.nbits, v=rtlblk.scale_value_to_int(input_arr[t],rtlblk.block.get_var('input_voltage_real').type))})#FOR SOME REASON VOLTAGES ARE DIFFERENT
            ts.append(t*timestep)
            outi = values["output_clock_real"]

            outs.append(rtlblk.scale_value_to_real(outi, rtlblk.block.get_var('output_clock_real').type))
    
        print(rtlblk.block.get_var('output_clock_real').type)
        return (outs,ts, input_arr)

    timestep = 5e-5
    num_cycles = 5e5
    rtl_block.generate_verilog_src("./")
    rtl_block.generate_pymtl_wrapper("./")
    rtl_block.pymtl_sim_begin()

    rtl_xs, rtl_ts, rtl_in = simulate_pymtl_model(rtl_block, round(num_cycles),timestep=timestep)

    greatest = max(rtl_xs)
    failed = greatest > 3.4
    if(failed or plot):
        plt.plot(rtl_ts,rtl_xs, label='xs')
        plt.plot(rtl_ts,rtl_in, label='input_voltage_real')
        plt.title("RTL Model")
        plt.legend(loc='best')
        plt.savefig("./vco_test_thrash_rtl_model.png")
        plt.clf()
    assert not failed, "[ERROR] VCO THRASH TEST FAILED, GREATEST ACHIEVED VALUE IN {} CYCLES = {} > 3.3: WAVEFORMS IN ./ FOLDER".format(num_cycles, greatest) 

