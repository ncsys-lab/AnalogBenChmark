import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib 
from src.model_generators.loop_filter import Loop_Filter_Generator
import sys
import copy

class VCO_Generator:
    
    def generate_block(input_voltage = 3.3, rel_prec = 0.01, timestep = 1e-4):

        scf = 4

        vco = blocklib.AMSBlock("vco")

        #w = vco.decl_input(Real("w"))
        #out = vco.decl_output(Real("out"))
        
        gain = vco.decl_param("gain",Constant(1))
        d    = vco.decl_param("damping_resistance",Constant(0.0036))

        w = vco.decl_var("input_voltage_real", kind=blocklib.VarKind.Input, type=Loop_Filter_Generator.output_voltage_real_type) #total kludge to get the product lower above 0.00
        x = vco.decl_var("x", kind=blocklib.VarKind.StateVar, type=RealType(lower=-3.3*scf,upper=3.3*scf,prec=rel_prec))
        v = vco.decl_var("v", kind=blocklib.VarKind.StateVar, type=RealType(lower=-3.3*scf,upper=3.3*scf,prec=rel_prec)) 
        out = vco.decl_var("output_clock_real", kind=blocklib.VarKind.Output, type=x.type)

        dvdt = vco.decl_var("dvdt", kind=blocklib.VarKind.Transient,  \
                type=intervallib.real_type_from_expr(vco, -(gain * w * w * gain)*(x), rel_prec=rel_prec))
        dxdt = vco.decl_var("dxdt", kind=blocklib.VarKind.Transient, \
                type=intervallib.real_type_from_expr(vco, v, rel_prec=rel_prec))

        expr = VarAssign(dvdt, -(gain * w * w * gain)*(x))
        vco.decl_relation(expr)
        vco.decl_relation(VarAssign(dxdt, v))
        vco.decl_relation(VarAssign(out, x))

        vco.decl_relation(Integrate(v, dvdt, timestep=timestep))
        vco.decl_relation(Integrate(x, dxdt, timestep=timestep))
        return vco

rel_prec = 0.000001

vco_ams_block = VCO_Generator.generate_block(rel_prec=rel_prec)

ival_reg = intervallib.compute_intervals_for_block(vco_ams_block,rel_prec=rel_prec)
vco_ams_block_real = copy.deepcopy(vco_ams_block)
fp_block = fxplib.to_fixed_point(ival_reg,vco_ams_block)
    
int_block = intlib.to_integer(fp_block)

rtl_block = rtllib.RTLBlock(int_block,{'x':3.3, 'v':0}, name_override = 'voltage_controlled_oscillator')

if __name__ == "__main__":

    rtl_block.generate_verilog_src(sys.argv[1])