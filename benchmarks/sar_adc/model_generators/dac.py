import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib 

import sys
import copy



class DACGenerator:
    
    def generate_block(nbits=10, voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):

        dac = blocklib.AMSBlock("vco")
        
        in_voltage_digital = dac.decl_var("input_voltage_digital", kind=blocklib.VarKind.Input, type=DigitalType(nbits=nbits))
        out_voltage_real = dac.decl_var("output_voltage_real",kind=blocklib.VarKind.Output, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        
        dac.decl_relation(VarAssign(out_voltage_real, Constant(voltage)*in_voltage_digital*Constant(1/2**nbits)))
        return dac

rel_prec = 1e-2

dac_ams_block = DACGenerator.generate_block(rel_prec=rel_prec)

ival_reg = intervallib.compute_intervals_for_block(dac_ams_block,rel_prec=rel_prec)
vco_ams_block_real = copy.deepcopy(dac_ams_block)
fp_block = fxplib.to_fixed_point(ival_reg,dac_ams_block)
    
int_block = intlib.to_integer(fp_block)

rtl_block = rtllib.RTLBlock(int_block,{}, name_override = 'digital_to_analog_converter')

if __name__ == "__main__":

    rtl_block.generate_verilog_src(sys.argv[1])