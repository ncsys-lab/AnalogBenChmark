

module digital_to_analog_converter
(
  input clk,
  input reset,
  input [11-1:0] input_voltage_digital,
  output [10-1:0] output_voltage_real
);

  wire [10-1:0] padr_0;
  wire [2-1:0] padr_bits_1;
  assign padr_bits_1 = 0;
  wire [29-1:0] truncR_2;
  wire [54-1:0] truncval_3;
  wire [54-1:0] padl_4;
  wire [27-1:0] padl_bits_5;
  wire [27-1:0] padr_6;
  wire [13-1:0] padr_bits_7;
  assign padr_bits_7 = 0;
  wire [1-1:0] toSInt_8;
  assign toSInt_8 = 0;
  wire [14-1:0] toSInt_imm_9;
  wire [35-1:0] truncR_10;
  wire [44-1:0] truncval_11;
  wire [44-1:0] padl_12;
  wire [22-1:0] padl_bits_13;
  wire [22-1:0] padl_14;
  wire [13-1:0] padl_bits_15;
  wire [13-1:0] const_16;
  assign const_16 = 13'd6758;
  assign padl_bits_15 = const_16;
  wire [9-1:0] padl_bits_zero_17;
  assign padl_bits_zero_17 = 0;
  assign padl_14 = { padl_bits_zero_17, padl_bits_15 };
  assign padl_bits_13 = padl_14;
  wire [22-1:0] padl_bits_zero_18;
  assign padl_bits_zero_18 = 0;
  assign padl_12 = { padl_bits_zero_18, padl_bits_13 };
  wire [44-1:0] padl_19;
  wire [22-1:0] padl_bits_20;
  wire [22-1:0] padr_21;
  wire [11-1:0] padr_bits_22;
  assign padr_bits_22 = 0;
  assign padr_21 = { input_voltage_digital, padr_bits_22 };
  assign padl_bits_20 = padr_21;
  wire [22-1:0] padl_bits_zero_23;
  assign padl_bits_zero_23 = 0;
  assign padl_19 = { padl_bits_zero_23, padl_bits_20 };
  assign truncval_11 = padl_12 * padl_19;
  assign truncR_10 = truncval_11[34:0];
  assign toSInt_imm_9 = { toSInt_8, truncR_10[34:22] };
  assign padr_6 = { toSInt_imm_9, padr_bits_7 };
  assign padl_bits_5 = padr_6;
  assign padl_4 = { { 27{ padl_bits_5[26] } }, padl_bits_5 };
  wire [54-1:0] padl_24;
  wire [27-1:0] padl_bits_25;
  wire [27-1:0] padl_26;
  wire [15-1:0] padl_bits_27;
  wire [15-1:0] const_28;
  assign const_28 = 15'd8;
  assign padl_bits_27 = const_28;
  assign padl_26 = { { 12{ padl_bits_27[14] } }, padl_bits_27 };
  assign padl_bits_25 = padl_26;
  assign padl_24 = { { 27{ padl_bits_25[26] } }, padl_bits_25 };
  assign truncval_3 = padl_4 * padl_24;
  assign truncR_2 = truncval_3[28:0];
  assign padr_0 = { truncR_2[28:21], padr_bits_1 };
  assign output_voltage_real = padr_0;

endmodule

