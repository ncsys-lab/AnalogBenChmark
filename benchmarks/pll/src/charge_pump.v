

module charge_pump #
(
  parameter up_current_param = 1342,
  parameter down_current_param = 1342
)
(
  input clk,
  input reset,
  input [1-1:0] input_up_digital,
  input [1-1:0] input_down_digital,
  output [24-1:0] output_current_real
);

  wire [25-1:0] truncR_0;
  wire [25-1:0] padl_1;
  wire [24-1:0] padl_bits_2;
  wire [1-1:0] toSInt_3;
  assign toSInt_3 = 0;
  wire [24-1:0] toSInt_imm_4;
  wire [52-1:0] truncR_5;
  wire [54-1:0] truncval_6;
  wire [54-1:0] padl_7;
  wire [27-1:0] padl_bits_8;
  wire [27-1:0] padl_9;
  wire [26-1:0] padl_bits_10;
  wire [26-1:0] param_11;
  assign param_11 = up_current_param;
  assign padl_bits_10 = param_11;
  wire [1-1:0] padl_bits_zero_12;
  assign padl_bits_zero_12 = 0;
  assign padl_9 = { padl_bits_zero_12, padl_bits_10 };
  assign padl_bits_8 = padl_9;
  wire [27-1:0] padl_bits_zero_13;
  assign padl_bits_zero_13 = 0;
  assign padl_7 = { padl_bits_zero_13, padl_bits_8 };
  wire [54-1:0] padl_14;
  wire [27-1:0] padl_bits_15;
  wire [27-1:0] padr_16;
  wire [26-1:0] padr_bits_17;
  assign padr_bits_17 = 0;
  assign padr_16 = { input_up_digital, padr_bits_17 };
  assign padl_bits_15 = padr_16;
  wire [27-1:0] padl_bits_zero_18;
  assign padl_bits_zero_18 = 0;
  assign padl_14 = { padl_bits_zero_18, padl_bits_15 };
  assign truncval_6 = padl_7 * padl_14;
  assign truncR_5 = truncval_6[51:0];
  wire [52-1:0] truncR_19;
  wire [54-1:0] truncval_20;
  wire [54-1:0] padl_21;
  wire [27-1:0] padl_bits_22;
  wire [27-1:0] padl_23;
  wire [26-1:0] padl_bits_24;
  wire [26-1:0] param_25;
  assign param_25 = down_current_param;
  assign padl_bits_24 = param_25;
  wire [1-1:0] padl_bits_zero_26;
  assign padl_bits_zero_26 = 0;
  assign padl_23 = { padl_bits_zero_26, padl_bits_24 };
  assign padl_bits_22 = padl_23;
  wire [27-1:0] padl_bits_zero_27;
  assign padl_bits_zero_27 = 0;
  assign padl_21 = { padl_bits_zero_27, padl_bits_22 };
  wire [54-1:0] padl_28;
  wire [27-1:0] padl_bits_29;
  wire [27-1:0] padr_30;
  wire [26-1:0] padr_bits_31;
  assign padr_bits_31 = 0;
  assign padr_30 = { input_down_digital, padr_bits_31 };
  assign padl_bits_29 = padr_30;
  wire [27-1:0] padl_bits_zero_32;
  assign padl_bits_zero_32 = 0;
  assign padl_28 = { padl_bits_zero_32, padl_bits_29 };
  assign truncval_20 = padl_21 * padl_28;
  assign truncR_19 = truncval_20[51:0];
  assign toSInt_imm_4 = { toSInt_3, truncR_5[51:29] + truncR_19[51:29] };
  assign padl_bits_2 = toSInt_imm_4;
  assign padl_1 = { { 1{ padl_bits_2[23] } }, padl_bits_2 };
  assign truncR_0 = padl_1;
  wire [24-1:0] truncR_shift_33;
  assign truncR_shift_33 = truncR_0 >>> 1;
  wire [24-1:0] truncR_imm_34;
  assign truncR_imm_34 = (truncR_0[24])? truncR_shift_33[23:0] : truncR_0[24:1];
  assign output_current_real = truncR_imm_34;

endmodule

