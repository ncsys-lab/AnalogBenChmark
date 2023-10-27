from pymtl3 import *
from pymtl3.passes.backends.verilog import *

# PyMTL wrapper for the Floating Point Multiplier Verilog model

class phase_locked_loop(VerilogPlaceholder, Component):

    def construct(self):

        self.reference_clk_digital = InPort(mk_bits(1))
        self.output_clk_digital = OutPort(mk_bits(1))