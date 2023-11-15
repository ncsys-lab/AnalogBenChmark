from pymtl3 import *
from pymtl3.passes.backends.verilog import *

# PyMTL wrapper for the Floating Point Multiplier Verilog model

class sar_adc(VerilogPlaceholder, Component):

    def construct(self, N_BITS=10):

        self.input_voltage_real = InPort(mk_bits(10))
        self.input_hold_digital = InPort(mk_bits(1))

        self.eoc = OutPort(mk_bits(1))

        self.output_result_digital = OutPort(mk_bits(N_BITS))

