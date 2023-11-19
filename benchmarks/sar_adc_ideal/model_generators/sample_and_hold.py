import pythams.core.block as blocklib
from pythams.core.expr import *
import pythams.core.intervals as intervallib
import pythams.core.fixedpoint as fxplib
import pythams.core.integer as intlib 
import pythams.core.rtl as rtllib 

from pythams.core.fsmblock import *

import sys
import copy



class SaHGenerator:

    
    def generate_block(voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):

        initial_conditions = Initializer({'state_cap':0})

        sah_fsm = FSMAMSBlock(timestep, 1, initial_conditions, 'sah')
        
        transparent_state = SaHGenerator.generate_transparent_state()
        opaque_state = SaHGenerator.generate_opaque_state()

        transparent_opaque = Edge(transparent_state, opaque_state, DigitalSignalCondition('input_control_digital'))
        opaque_transparent = Edge(opaque_state, transparent_state, DigitalSignalCondition('input_control_digital', inv=True))

        sah_fsm.addNode(transparent_state)
        sah_fsm.addNode(opaque_state)

        sah_fsm.addEdge(transparent_opaque)
        sah_fsm.addEdge(opaque_transparent)

        sah_fsm.starting_state = transparent_state
        sah_fsm.reset()

        return sah_fsm

    def generate_transparent_state(voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):
        transparent = Node('transparent')
        
        in_voltage_real  = transparent.block.decl_var("input_voltage_real", kind=blocklib.VarKind.Input , type=RealType(lower=0,upper=3.3,prec=rel_prec))
        out_voltage_real = transparent.block.decl_var("output_voltage_real",kind=blocklib.VarKind.Output, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        
        state_cap = transparent.block.decl_var("state_cap",kind=blocklib.VarKind.StateVar, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        
        in_control_digital = transparent.block.decl_var("input_control_digital", kind=blocklib.VarKind.Input, type=DigitalType(nbits = 1))

        transparent.block.decl_relation(VarAssign(state_cap, in_voltage_real))
        transparent.block.decl_relation(VarAssign(out_voltage_real, state_cap))
        

        return transparent

    def generate_opaque_state(voltage = 3.3, rel_prec = 0.01, timestep = 5e-5):

        opaque = Node('opaque')
        
        in_voltage_real  = opaque.block.decl_var("input_voltage_real", kind=blocklib.VarKind.Input , type=RealType(lower=0,upper=3.3,prec=rel_prec))
        out_voltage_real = opaque.block.decl_var("output_voltage_real",kind=blocklib.VarKind.Output, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        
        state_cap = opaque.block.decl_var("state_cap",kind=blocklib.VarKind.StateVar, type=RealType(lower=0,upper=3.3,prec=rel_prec))
        
        in_control_digital = opaque.block.decl_var("input_control_digital", kind=blocklib.VarKind.Input, type=DigitalType(nbits = 1))
        
        opaque.block.decl_relation(VarAssign(state_cap, state_cap))
        opaque.block.decl_relation(VarAssign(out_voltage_real, state_cap))
        
        return opaque




rel_prec = 1e-2

dac_ams_block = SaHGenerator.generate_block(rel_prec=rel_prec)

dac_ams_block.preprocessHierarchy(rel_prec=rel_prec)

rtl_block = rtllib.RTLBlock(dac_ams_block,{'state_cap':0},name_override='sample_and_hold')

if __name__ == "__main__":

    rtl_block.generate_verilog_src(sys.argv[1])