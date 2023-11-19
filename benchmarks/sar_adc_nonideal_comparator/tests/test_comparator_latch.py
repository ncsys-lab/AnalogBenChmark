import pytest
from pymtl3 import *
from sar_adc_nonideal_comparator.model_generators.comparator_latch import *
import math


def test_comprator_transient(plot):



    def validate_pymtl_model(rtlblk,timestep,clk_period):
        outs = []
        ts = []
        clk_arr = []
        cycles_per_sec = round(1/timestep)
        max_cycles = 30*cycles_per_sec
        clk = 0
        for t in range(SIM_TICKS):

            values = rtlblk.pymtl_sim_tick({"p":Bits(rtlblk.block.get_var('p').type.nbits, v=rtlblk.scale_value_to_int(1.6,rtlblk.block.get_var('p').type)),
                                            "n":Bits(rtlblk.block.get_var('n').type.nbits, v=rtlblk.scale_value_to_int(2,rtlblk.block.get_var('n').type)),
                                            "sys_clk":Bits(1,v=clk)})


            if(clk == 1 and math.fmod(t * timestep, clk_period ) < clk_period / 2):   
                clk = 0
            elif(clk == 0 and math.fmod(t * timestep, clk_period ) > clk_period / 2):
                clk = 1

            clk_arr.append(clk * 3.3)
            ts.append(t*timestep)
            outi = values["out"]


            outs.append(rtlblk.scale_value_to_real(outi, rtlblk.block.get_var('out').type))

        plt.plot(ts,outs, label='out')
        plt.plot(ts,clk_arr, label='clk')
        plt.legend(loc='best')
        #plt.show()
        plt.savefig("./comparator_latch_transient.png")
        plt.clf()
    
    SIM_TICKS     = 40000
    TICK_DIVISION = 10000
    SYSTEM_CLOCK = 1e-6
        
    comparator_latch_fsm = GenerateComparatorLatch.generate_block_model()

    comparator_latch_fsm.preprocessHierarchy(rel_prec = 0.0001, override_dict = {'wait_time':intlib.IntType(nbits = 32, scale = 1.0, signed = 0), 'wait_time_lh':intlib.IntType(nbits = 32, scale = 1.0, signed = 0)})
    rtl_fsm = rtllib.RTLBlock(comparator_latch_fsm,{'o':3.3},name_override='comparator_latch')
    rtl_fsm.generate_verilog_src("./")
    rtl_fsm.generate_pymtl_wrapper("./")
    rtl_fsm.pymtl_sim_begin()

    validate_pymtl_model(rtl_fsm, SYSTEM_CLOCK/TICK_DIVISION, SYSTEM_CLOCK)