

module charge_pump_fp_int #
(
  parameter up_current_param = 1342,
  parameter down_current_param = 1342
)
(
  input sys_clk,
  input clk,
  input reset,
  input [1-1:0] input_up_digital,
  input [1-1:0] input_down_digital,
  output [22-1:0] output_current_real
);

  wire [23-1:0] truncR_0;
  wire [52-1:0] truncR_1;
  wire [54-1:0] truncval_2;
  wire [54-1:0] padl_3;
  wire [27-1:0] padl_bits_4;
  wire [27-1:0] padl_5;
  wire [26-1:0] padl_bits_6;
  wire [26-1:0] param_7;
  assign param_7 = up_current_param;
  assign padl_bits_6 = param_7;
  wire [1-1:0] padl_bits_zero_8;
  assign padl_bits_zero_8 = 0;
  assign padl_5 = { padl_bits_zero_8, padl_bits_6 };
  assign padl_bits_4 = padl_5;
  wire [27-1:0] padl_bits_zero_9;
  assign padl_bits_zero_9 = 0;
  assign padl_3 = { padl_bits_zero_9, padl_bits_4 };
  wire [54-1:0] padl_10;
  wire [27-1:0] padl_bits_11;
  wire [27-1:0] padr_12;
  wire [26-1:0] padr_bits_13;
  assign padr_bits_13 = 0;
  assign padr_12 = { input_up_digital, padr_bits_13 };
  assign padl_bits_11 = padr_12;
  wire [27-1:0] padl_bits_zero_14;
  assign padl_bits_zero_14 = 0;
  assign padl_10 = { padl_bits_zero_14, padl_bits_11 };
  assign truncval_2 = padl_3 * padl_10;
  assign truncR_1 = truncval_2[51:0];
  wire [52-1:0] truncR_15;
  wire [54-1:0] truncval_16;
  wire [54-1:0] padl_17;
  wire [27-1:0] padl_bits_18;
  wire [27-1:0] padl_19;
  wire [26-1:0] padl_bits_20;
  wire [26-1:0] param_21;
  assign param_21 = down_current_param;
  assign padl_bits_20 = param_21;
  wire [1-1:0] padl_bits_zero_22;
  assign padl_bits_zero_22 = 0;
  assign padl_19 = { padl_bits_zero_22, padl_bits_20 };
  assign padl_bits_18 = padl_19;
  wire [27-1:0] padl_bits_zero_23;
  assign padl_bits_zero_23 = 0;
  assign padl_17 = { padl_bits_zero_23, padl_bits_18 };
  wire [54-1:0] padl_24;
  wire [27-1:0] padl_bits_25;
  wire [27-1:0] padr_26;
  wire [26-1:0] padr_bits_27;
  assign padr_bits_27 = 0;
  assign padr_26 = { input_down_digital, padr_bits_27 };
  assign padl_bits_25 = padr_26;
  wire [27-1:0] padl_bits_zero_28;
  assign padl_bits_zero_28 = 0;
  assign padl_24 = { padl_bits_zero_28, padl_bits_25 };
  assign truncval_16 = padl_17 * padl_24;
  assign truncR_15 = truncval_16[51:0];
  assign truncR_0 = truncR_1[51:29] + truncR_15[51:29];
  assign output_current_real = truncR_0[22:1];

endmodule

