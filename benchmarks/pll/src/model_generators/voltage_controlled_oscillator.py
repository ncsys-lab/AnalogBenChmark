import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib 
import loop_filter


class VCO_Generator:
    
    def generate_block(input_voltage = 3.3, rel_prec = 0.01, timestep = 1e-5):
        vco = blocklib.AMSBlock("vco")

        #w = vco.decl_input(Real("w"))
        #out = vco.decl_output(Real("out"))

        w = vco.decl_var("input_voltage_real", kind=blocklib.VarKind.Input, type=loop_filter.Loop_Filter_Generator.output_voltage_real_type) #total kludge to get the product lower above 0.00
        x = vco.decl_var("x", kind=blocklib.VarKind.StateVar, type=RealType(lower=0,upper=3.3,prec=rel_prec*2.0))
        v = vco.decl_var("v", kind=blocklib.VarKind.StateVar, type=RealType(lower=-10,upper=10,prec=rel_prec*2.0)) 
        out = vco.decl_var("output_clock_digital", kind=blocklib.VarKind.Output, type=DigitalType(1))

        dvdt = vco.decl_var("dvdt", kind=blocklib.VarKind.Transient,  \
                type=intervallib.real_type_from_expr(vco, Constant(1.6)-(w*w)*x, rel_prec=rel_prec))
        dxdt = vco.decl_var("dxdt", kind=blocklib.VarKind.Transient, \
                type=intervallib.real_type_from_expr(vco, x, rel_prec=rel_prec))

        expr = VarAssign(dvdt, Constant(1.6)-(w*w)*x)
        vco.decl_relation(expr)
        vco.decl_relation(VarAssign(dxdt, v))
        vco.decl_relation(VarAssign(out, x))

        vco.decl_relation(Integrate(v, dvdt, timestep=timestep))
        vco.decl_relation(Integrate(x, dxdt, timestep=timestep))
        return vco


vco_ams_block = VCO_Generator.generate_block()

if __name__ == "__main__":
    ival_reg = intervallib.compute_intervals_for_block(vco_ams_block,rel_prec=0.01)

    fp_block = fxplib.to_fixed_point(ival_reg,vco_ams_block)
    
    int_block = intlib.to_integer(fp_block)

    rtl_block = rtllib.RTLBlock(int_block,{'x':0, 'v':0}, name_override = 'voltage_controled_oscillator')

    rtl_block.generate_verilog_src('./')