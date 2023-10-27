import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib
import charge_pump

class Loop_Filter_Generator:
    
    output_voltage_real_type = None

    def generate_block(input_voltage = 3.3, rel_prec = 0.01, timestep = 1e-3):
    
        loop_filter = blocklib.AMSBlock('loop_filter')

        C_one_param = loop_filter.decl_param('C_one', Constant(5e-13))
        C_two_param = loop_filter.decl_param('C_two', Constant(4e-14))
        R_param     = loop_filter.decl_param('R',     Constant(5e3))

        input_current_real = loop_filter.decl_var('input_current_real', blocklib.VarKind.Input, charge_pump.Charge_Pump_Generator.output_current_real_type)
        output_voltage_real = loop_filter.decl_var('output_voltage_real', blocklib.VarKind.Output, RealType(0, input_voltage, rel_prec))

        v_o = loop_filter.decl_var('v_o', blocklib.VarKind.StateVar, output_voltage_real.type)

        i_r = loop_filter.decl_var('i_r', blocklib.VarKind.StateVar, charge_pump.Charge_Pump_Generator.output_current_real_type)

        loop_filter.decl_relation(VarAssign(output_voltage_real,v_o))
        loop_filter.decl_relation(VarAssign(i_r,input_current_real))
        loop_filter.decl_relation(Integrate(v_o, Constant(1/C_one_param.value) * (i_r - v_o * Constant(1/R_param.value)),timestep=timestep))
        
        Loop_Filter_Generator.output_voltage_real_type = output_voltage_real.type
        
        return loop_filter
    

loop_filter = Loop_Filter_Generator.generate_block()

if __name__ == "__main__":
    ival_reg = intervallib.compute_intervals_for_block(loop_filter,rel_prec=0.01)

    fp_block = fxplib.to_fixed_point(ival_reg,loop_filter)
    
    int_block = intlib.to_integer(fp_block)
    print(fp_block._vars['output_voltage_real'])
    print(int_block._vars['input_current_real'])
    rtl_block = rtllib.RTLBlock(int_block,{'v_o':0, 'i_r':0, 'int_i_r':0}, name_override = 'loop_filter')

    rtl_block.generate_verilog_src('../')