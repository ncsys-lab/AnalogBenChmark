import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib 

from pythams.core.fsmblock import *

import sys
import copy



class ComparatorGenerator:

    
    def generate_block(voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):

        initial_conditions = Initializer({'state_cap':0})

        sah_fsm = FSMAMSBlock(timestep, 1, initial_conditions, 'sah')
        
        high_state = ComparatorGenerator.generate_high_state()
        low_state  = ComparatorGenerator.generate_low_state()

        high_low = Edge(high_state, low_state, AnalogSignalCondition('p_voltage_real', (0.0,high_state.block.get_var('n_voltage_real'))))
        low_high = Edge(low_state, high_state, AnalogSignalCondition('p_voltage_real', (high_state.block.get_var('n_voltage_real'),float('inf'))))

        sah_fsm.addNode(high_state)
        sah_fsm.addNode(low_state)

        sah_fsm.addEdge(high_low)
        sah_fsm.addEdge(low_high)

        sah_fsm.starting_state = high_state
        sah_fsm.reset()

        return sah_fsm

    def generate_high_state(voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):
        high = Node('high')
        
        p_voltage_real = high.block.decl_var("p_voltage_real", kind=blocklib.VarKind.Input, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        n_voltage_real = high.block.decl_var("n_voltage_real", kind=blocklib.VarKind.Input, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        out_digital  = high.block.decl_var("out_digital",kind=blocklib.VarKind.Output, type=DigitalType(nbits=1))
        
        high.block.decl_relation(VarAssign(out_digital,Constant(1)))

        return high

    def generate_low_state(voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):
        low = Node('low')
        
        p_voltage_real = low.block.decl_var("p_voltage_real", kind=blocklib.VarKind.Input, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        n_voltage_real = low.block.decl_var("n_voltage_real", kind=blocklib.VarKind.Input, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        
        out_digital  = low.block.decl_var("out_digital",kind=blocklib.VarKind.Output, type=DigitalType(nbits=1))
        
        zero = Constant(0)
        zero.type = DigitalType(nbits=1)

        low.block.decl_relation(VarAssign(out_digital,zero))

        return low




rel_prec = 1e-2

comparator_ams_block = ComparatorGenerator.generate_block(rel_prec=rel_prec)

comparator_ams_block.preprocessHierarchy(rel_prec=rel_prec)

rtl_block = rtllib.RTLBlock(comparator_ams_block,{},name_override='comparator')

if __name__ == "__main__":

    rtl_block.generate_verilog_src(sys.argv[1])