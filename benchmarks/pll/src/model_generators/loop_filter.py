import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib
from src.model_generators.charge_pump import Charge_Pump_Generator

class Loop_Filter_Generator:
    
    output_voltage_real_type = None

    def generate_block(input_voltage = 3.3, rel_prec = 0.01, timestep = 1e-7):
    
        loop_filter = blocklib.AMSBlock('loop_filter')

        C_one_param = loop_filter.decl_param('C_one', Constant(5e-13))
        C_two_param = loop_filter.decl_param('C_two', Constant(4e-14))
        R_param     = loop_filter.decl_param('R',     Constant(2e5))

        input_current_real = loop_filter.decl_var('input_current_real', blocklib.VarKind.Input, Charge_Pump_Generator.output_current_real_type)
        output_voltage_real = loop_filter.decl_var('output_voltage_real', blocklib.VarKind.Output, RealType(0, input_voltage, rel_prec))

        v_o = loop_filter.decl_var('v_o', blocklib.VarKind.StateVar, output_voltage_real.type)

        i_r = loop_filter.decl_var('i_r', blocklib.VarKind.StateVar, Charge_Pump_Generator.output_current_real_type)

        di_dt = loop_filter.decl_var('di_dt', blocklib.VarKind.Transient, \
                                     intervallib.real_type_from_expr(loop_filter, input_current_real * Constant(1 / R_param.value * C_two_param.value) -\
                                                                      i_r * (Constant(1 / R_param.value * C_two_param.value)) - i_r * (Constant(1 / R_param.value * C_one_param.value)), rel_prec=rel_prec))

        int_i_r = loop_filter.decl_var('int_i_r', blocklib.VarKind.StateVar, \
                                       intervallib.real_type_from_expr(loop_filter, v_o * C_one_param, rel_prec=rel_prec) )

        loop_filter.decl_relation(VarAssign(di_dt, input_current_real * Constant(1 / R_param.value * C_two_param.value) -\
                                                                      i_r * (Constant(1 / R_param.value * C_two_param.value)) - i_r * (Constant(1 / R_param.value * C_one_param.value)) ))

        loop_filter.decl_relation(Integrate(i_r, di_dt, timestep=timestep))
        loop_filter.decl_relation(Integrate(int_i_r, i_r, timestep=timestep))

        loop_filter.decl_relation(VarAssign(v_o, i_r * R_param + Constant(1/C_one_param.value) * int_i_r))
        
        loop_filter.decl_relation(VarAssign(output_voltage_real, v_o))
        
        Loop_Filter_Generator.output_voltage_real_type = output_voltage_real.type
        
        return loop_filter
    

loop_filter = Loop_Filter_Generator.generate_block()

if __name__ == "__main__":
    ival_reg = intervallib.compute_intervals_for_block(loop_filter,rel_prec=0.01)

    fp_block = fxplib.to_fixed_point(ival_reg,loop_filter)
    
    int_block = intlib.to_integer(fp_block)
    print(fp_block._vars['output_voltage_real'])
    print(int_block._vars['output_voltage_real'])
    rtl_block = rtllib.RTLBlock(int_block,{'v_o':0, 'i_r':0, 'int_i_r':0}, name_override = 'loop_filter')

    rtl_block.generate_verilog_src('../')