import pythams.core.fsmblock as fsmlib
import pythams.core.intervals as intervallib
import yaml
import matplotlib.pyplot as plt
import numpy as np
import pythams.core.fixedpoint as fixlib
import pythams.core.rtl as rtllib
import pythams.core.integer as intlib
import pythams.core.block as blocklib
from pythams.core.block import VarKind
from pythams.core.expr import RealType, VarAssign, Constant, Reciprocal, Integrate, DigitalType


import sys


def read_yaml( f ):
    with open(f, 'r') as stream:
        return yaml.safe_load(stream)

class ModelParams:
    def __init__(self, low_high_param_yaml_path = "../model_generators/regression_results_zero_one.yaml", high_low_param_yaml_path = "../model_generators/regression_results_one_zero.yaml" ):
        low_high_param = read_yaml(low_high_param_yaml_path)
        high_low_param = read_yaml(high_low_param_yaml_path)

        self.high_low_paramdict_tau      = dict(map(lambda p:(p[0],p[1]['const_1']), high_low_param['tau'].items()))          
        self.high_low_paramdict_resptime = dict(map(lambda p:(p[0],p[1]['const_1']), high_low_param['response_time'].items()))

        self.low_high_paramdict_tau      = dict(map(lambda p:(p[0],p[1]['const_1']), low_high_param['tau'].items()))
        self.low_high_paramdict_resptime = dict(map(lambda p:(p[0],p[1]['const_1']), low_high_param['response_time'].items()))

    def compute_high_low_tau(self, block, n, p):
        n_to_tau = block.decl_param('n_to_tau', Constant(self.high_low_paramdict_tau['n_to_tau']))
        p_to_tau = block.decl_param('p_to_tau', Constant(self.high_low_paramdict_tau['p_to_tau']))
        const_tau   = block.decl_param('const_tau'  , Constant(self.high_low_paramdict_tau['const_tau'])  )
        #print(n_to_tau)
        #print(p_to_tau)
        #print(const_tau)       
        return n * n_to_tau  + p * p_to_tau  + const_tau

    def compute_high_low_response_time(self, block, n, p):
        n_to_response_time = block.decl_param('n_to_response_time',  Constant(self.high_low_paramdict_resptime['n_to_response_time']))
        p_to_response_time = block.decl_param('p_to_response_time',  Constant(self.high_low_paramdict_resptime['p_to_response_time']))
        const_to_response_time = block.decl_param('const_response_time'  , Constant(self.high_low_paramdict_resptime['const_response_time'  ]))
        return n * n_to_response_time + p * p_to_response_time + const_to_response_time

    def compute_low_high_tau(self, block, n, p):
        n_to_tau = block.decl_param( ('n_to_tau_lh'), Constant(self.low_high_paramdict_tau['n_to_tau'] ) ) 
        p_to_tau = block.decl_param( ('p_to_tau_lh'), Constant(self.low_high_paramdict_tau['p_to_tau'] ) ) 
        const_tau   = block.decl_param( ('const_tau_lh'  ), Constant(self.low_high_paramdict_tau['const_tau'  ] ) )
        return n * n_to_tau + p * p_to_tau + const_tau

    def compute_low_high_response_time(self, block, n, p):
        n_to_response_time = block.decl_param( ('n_to_response_time_lh'), Constant(self.low_high_paramdict_resptime['n_to_response_time'] ) )
        p_to_response_time = block.decl_param( ('p_to_response_time_lh'), Constant(self.low_high_paramdict_resptime['p_to_response_time'] ) )
        const_response_time   = block.decl_param( ('const_response_time_lh'  ), Constant(self.low_high_paramdict_resptime['const_response_time'  ] ) )
        return n * n_to_response_time + p * p_to_response_time + const_response_time
    


class StateMaker:
    """
    'evaluate_high' :         
    'evaluate_low_high_low' : 
    'evaluate_low_stable' :   
    'evaluate_low_low_high' : 
    'evaluate_wait_low_high': 
    'evaluate_wait_high_low':
    """

    model_params = ModelParams()
    
    def create_precharge_state():
        precharge = fsmlib.Node('precharge')

        n = precharge.block.decl_var('n', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        p = precharge.block.decl_var('p', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        o    = precharge.block.decl_var('o',  blocklib.VarKind.StateVar, RealType(-1, 3.3, 0.001))  
        out  = precharge.block.decl_var('out',  blocklib.VarKind.Output, RealType(0, 3.3, 0.01))

        precharge.block.decl_relation(VarAssign(o,Constant(3.3)))
        precharge.block.decl_relation(VarAssign(out,o))  
    
        return precharge
    
    def create_evaluate_wait_high_low_state(fsm):
        evaluate_wait_high_low = fsmlib.Node('evaluate_wait_high_low')
        n = evaluate_wait_high_low.block.decl_var('n', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        p = evaluate_wait_high_low.block.decl_var('p', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        o    = evaluate_wait_high_low.block.decl_var('o',  blocklib.VarKind.StateVar, RealType(-1, 3.3, 0.001))  
        out  = evaluate_wait_high_low.block.decl_var('out',  blocklib.VarKind.Output, RealType(0, 3.3, 0.01))

        wait_time_exp = StateMaker.model_params.compute_high_low_response_time(evaluate_wait_high_low.block, n, p)

        wait_time = evaluate_wait_high_low.block.decl_var('wait_time', blocklib.VarKind.Transient, \
                                                    type=RealType(0,100000,1))
        
        evaluate_wait_high_low.block.decl_relation(VarAssign(wait_time, wait_time_exp * Constant(1 / fsm.evaluate_dt)))

        evaluate_wait_high_low.block.decl_relation(VarAssign(o,Constant(3.3)))
        evaluate_wait_high_low.block.decl_relation(VarAssign(out,o))
        ival_reg = intervallib.compute_intervals_for_block(evaluate_wait_high_low.block,rel_prec=0.001)
        return evaluate_wait_high_low

    def create_evaluate_low_high_low_state(timestep):
        evaluate_wait_high_low = fsmlib.Node('evaluate_low_high_low')
        n = evaluate_wait_high_low.block.decl_var('n', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        p = evaluate_wait_high_low.block.decl_var('p', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        o    = evaluate_wait_high_low.block.decl_var('o',  blocklib.VarKind.StateVar, RealType(-1, 3.3, 0.001))  
        out  = evaluate_wait_high_low.block.decl_var('out',  blocklib.VarKind.Output, RealType(0, 3.3, 0.01))

        tau_exp = StateMaker.model_params.compute_high_low_tau(evaluate_wait_high_low.block, n, p)
        tau  = evaluate_wait_high_low.block.decl_var('tau', kind=blocklib.VarKind.Transient,  \
            type=intervallib.real_type_from_expr(evaluate_wait_high_low.block, tau_exp , rel_prec=0.000001))

        dvdt = evaluate_wait_high_low.block.decl_var("dvdt", kind=blocklib.VarKind.Transient,  \
            type=intervallib.real_type_from_expr(evaluate_wait_high_low.block, - o * Reciprocal(tau), rel_prec=0.001))

        evaluate_wait_high_low.block.decl_relation(VarAssign(tau,tau_exp))
        evaluate_wait_high_low.block.decl_relation(VarAssign(out,o))
        evaluate_wait_high_low.block.decl_relation(VarAssign(dvdt, - o * Reciprocal(tau)))
        evaluate_wait_high_low.block.decl_relation(Integrate(o, dvdt, timestep=timestep))

        return evaluate_wait_high_low
    
    def create_evaluate_wait_low_high_state(fsm):
        evaluate_wait_low_high = fsmlib.Node('evaluate_wait_low_high')
        n = evaluate_wait_low_high.block.decl_var('n', blocklib.VarKind.Input, RealType (0, 3.3, 0.01))
        p = evaluate_wait_low_high.block.decl_var('p', blocklib.VarKind.Input, RealType (0, 3.3, 0.01))
        o    = evaluate_wait_low_high.block.decl_var('o',  blocklib.VarKind.StateVar, RealType(-1, 3.3, 0.001))  
        out  = evaluate_wait_low_high.block.decl_var('out',  blocklib.VarKind.Output, RealType(0, 3.3, 0.01))

        wait_time_exp_lh = StateMaker.model_params.compute_low_high_response_time(evaluate_wait_low_high.block, n, p)
        wait_time_lh = evaluate_wait_low_high.block.decl_var('wait_time_lh', blocklib.VarKind.Transient, \
                                                          type=intervallib.real_type_from_expr(evaluate_wait_low_high.block, wait_time_exp_lh * Constant(1 / fsm.evaluate_dt), rel_prec = 0.001))
        
        evaluate_wait_low_high.block.decl_relation(VarAssign(wait_time_lh, wait_time_exp_lh * Constant(1 / fsm.evaluate_dt)))
        
        evaluate_wait_low_high.block.decl_relation(VarAssign(o, Constant(0.001)))
        evaluate_wait_low_high.block.decl_relation(VarAssign(out,o))

        ival_reg = intervallib.compute_intervals_for_block(evaluate_wait_low_high.block, rel_prec=0.001)
        return evaluate_wait_low_high
    
    def create_evaluate_low_low_high_state(timestep):
        evaluate_low_low_high = fsmlib.Node('evaluate_low_low_high')

        n = evaluate_low_low_high.block.decl_var('n', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        p = evaluate_low_low_high.block.decl_var('p', blocklib.VarKind.Input, RealType(0, 3.3, 0.01))
        o    = evaluate_low_low_high.block.decl_var('o',  blocklib.VarKind.StateVar, RealType(-1, 3.7, 1e-9))  
        out  = evaluate_low_low_high.block.decl_var('out',  blocklib.VarKind.Output, RealType(0, 3.3, 0.01))

        tau_exp = StateMaker.model_params.compute_low_high_tau( evaluate_low_low_high.block, n, p )

        tau_lh = evaluate_low_low_high.block.decl_var('tau_lh', blocklib.VarKind.Transient, \
                                                   type=intervallib.real_type_from_expr(evaluate_low_low_high.block, tau_exp, rel_prec = 0.00000001))
        
        dodt_expr = (Constant(3.3) - o) * Reciprocal( tau_lh )
        dodt = evaluate_low_low_high.block.decl_var('dodt', kind=blocklib.VarKind.Transient, \
                                                     type=intervallib.real_type_from_expr(evaluate_low_low_high.block,dodt_expr, rel_prec=0.001)) #Changed precision

        evaluate_low_low_high.block.decl_relation(VarAssign(tau_lh, tau_exp))
        evaluate_low_low_high.block.decl_relation(VarAssign(out, o))
        evaluate_low_low_high.block.decl_relation(VarAssign(dodt, dodt_expr))
        evaluate_low_low_high.block.decl_relation(Integrate(o, dodt, timestep=timestep))

        ival_reg = intervallib.compute_intervals_for_block(evaluate_low_low_high.block, rel_prec=0.001)
        return evaluate_low_low_high
    

class GenerateComparatorLatch:
    
    def generate_block_model():
        SIM_TICKS     = 40000
        TICK_DIVISION = 10000
        SYSTEM_CLOCK = 1e-6

        initial_conditions = fsmlib.Initializer({'o': 3.3})

        comparator_latch_fsm = fsmlib.FSMAMSBlock(SYSTEM_CLOCK, TICK_DIVISION, initial_conditions, "comparator_latch")

        # [precharge] [evaluate_wait] [evaluate_low] [evaluate_wait] [evaluate_low_high]
        precharge = StateMaker.create_precharge_state()
        evaluate_wait_high_low = StateMaker.create_evaluate_wait_high_low_state(comparator_latch_fsm)
        evaluate_low_high_low = StateMaker.create_evaluate_low_high_low_state(comparator_latch_fsm.evaluate_dt)
        evaluate_wait_low_high = StateMaker.create_evaluate_wait_low_high_state(comparator_latch_fsm)
        evaluate_low_low_high = StateMaker.create_evaluate_low_low_high_state(comparator_latch_fsm.evaluate_dt)


        #[precharge] -posedge clk-> [evaluate_wait] [evaluate_low] []
        precharge_to_eval_w_hl = fsmlib.Edge(precharge, evaluate_wait_high_low, fsmlib.ClockCondition(fsmlib.ClockCondition.Transition.POSEDGE, fsmlib.AnalogSignalCondition( 'n', (precharge.block.get_var('p'),float('inf')) ) ) ) 
        #[precharge] -posedge clk-> [evaluate_wait] -duration-> [evaluate_low] []
        evaluate_wait_hl_to_evaluate_lhl = fsmlib.Edge(evaluate_wait_high_low, evaluate_low_high_low, fsmlib.AnalogTimeCondition(evaluate_wait_high_low.block.get_var('wait_time')))#need to convert this to int and not frac
        #[precharge] -posedge clk-> [evaluate_wait] -duration-> [evaluate_low] -negedge clk-> [evalate_wait]
        evaluate_lhl_to_wait_llh = fsmlib.Edge(evaluate_low_high_low, evaluate_wait_low_high, fsmlib.ClockCondition(fsmlib.ClockCondition.Transition.NEGEDGE))
        #[precharge] -posedge clk-> [evaluate_wait] -duration-> [evaluate_low] -negedge clk-> [evalate_wait] -duration-> [evaluate_low_high]
        evaluate_wait_llh_to_evaluate_llh = fsmlib.Edge(evaluate_wait_low_high, evaluate_low_low_high, fsmlib.AnalogTimeCondition(evaluate_wait_low_high.block.get_var('wait_time_lh')))
        #[precharge] -posedge clk-> [evaluate_wait] -duration-> [evaluate_low] -negedge clk-> [evalate_wait] -duration-> [evaluate_low_high] -signal  < 'o'-> [precharge]
        evaluate_llh_to_precharge = fsmlib.Edge(evaluate_low_low_high, precharge, fsmlib.AnalogSignalCondition('o', ( 3.29, float('inf') ) ) )

        comparator_latch_fsm.addNode(precharge)
        comparator_latch_fsm.addNode(evaluate_wait_high_low)
        comparator_latch_fsm.addNode(evaluate_low_high_low)
        comparator_latch_fsm.addNode(evaluate_wait_low_high)
        comparator_latch_fsm.addNode(evaluate_low_low_high)


        comparator_latch_fsm.addEdge(precharge_to_eval_w_hl)
        comparator_latch_fsm.addEdge(evaluate_wait_hl_to_evaluate_lhl)
        comparator_latch_fsm.addEdge(evaluate_lhl_to_wait_llh)
        comparator_latch_fsm.addEdge(evaluate_wait_llh_to_evaluate_llh)
        comparator_latch_fsm.addEdge(evaluate_llh_to_precharge)



        comparator_latch_fsm.starting_state = precharge
        comparator_latch_fsm.reset()
        return comparator_latch_fsm


comparator_latch_fsm = GenerateComparatorLatch.generate_block_model()

comparator_latch_fsm.preprocessHierarchy(rel_prec = 0.000001, override_dict = {'wait_time':intlib.IntType(nbits = 32, scale = 1.0, signed = 0), 'wait_time_lh':intlib.IntType(nbits = 32, scale = 1.0, signed = 0)})
rtl_fsm = rtllib.RTLBlock(comparator_latch_fsm,{'o':3.3})
if __name__ == "__main__":
    print(comparator_latch_fsm.get_var('out').type)
    rtl_fsm.generate_verilog_src(sys.argv[1])




