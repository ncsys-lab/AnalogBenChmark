

module comparator
(
  input clk,
  input reset,
  input sys_clk,
  input [10-1:0] p_voltage_real,
  input [10-1:0] n_voltage_real,
  output [1-1:0] out_digital
);


  assign out_digital = (p_voltage_real > n_voltage_real)? 1 : 0;



endmodule

