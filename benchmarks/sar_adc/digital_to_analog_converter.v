

module digital_to_analog_converter
(
  input clk,
  input reset,
  input [10-1:0] input_voltage_digital,
  output [10-1:0] output_voltage_real
);

  wire [10-1:0] padr_0;
  wire [1-1:0] padr_bits_1;
  assign padr_bits_1 = 0;
  wire [9-1:0] padl_2;
  wire [8-1:0] padl_bits_3;
  wire [28-1:0] truncR_4;
  wire [52-1:0] truncval_5;
  wire [52-1:0] padl_6;
  wire [26-1:0] padl_bits_7;
  wire [26-1:0] padr_8;
  wire [13-1:0] padr_bits_9;
  assign padr_bits_9 = 0;
  wire [1-1:0] toSInt_10;
  assign toSInt_10 = 0;
  wire [13-1:0] toSInt_imm_11;
  wire [34-1:0] truncR_12;
  wire [42-1:0] truncval_13;
  wire [42-1:0] padl_14;
  wire [21-1:0] padl_bits_15;
  wire [21-1:0] padl_16;
  wire [13-1:0] padl_bits_17;
  wire [13-1:0] const_18;
  assign const_18 = 13'd6758;
  assign padl_bits_17 = const_18;
  wire [8-1:0] padl_bits_zero_19;
  assign padl_bits_zero_19 = 0;
  assign padl_16 = { padl_bits_zero_19, padl_bits_17 };
  assign padl_bits_15 = padl_16;
  wire [21-1:0] padl_bits_zero_20;
  assign padl_bits_zero_20 = 0;
  assign padl_14 = { padl_bits_zero_20, padl_bits_15 };
  wire [42-1:0] padl_21;
  wire [21-1:0] padl_bits_22;
  wire [21-1:0] padr_23;
  wire [11-1:0] padr_bits_24;
  assign padr_bits_24 = 0;
  assign padr_23 = { input_voltage_digital, padr_bits_24 };
  assign padl_bits_22 = padr_23;
  wire [21-1:0] padl_bits_zero_25;
  assign padl_bits_zero_25 = 0;
  assign padl_21 = { padl_bits_zero_25, padl_bits_22 };
  assign truncval_13 = padl_14 * padl_21;
  assign truncR_12 = truncval_13[33:0];
  assign toSInt_imm_11 = { toSInt_10, truncR_12[33:22] };
  assign padr_8 = { toSInt_imm_11, padr_bits_9 };
  assign padl_bits_7 = padr_8;
  assign padl_6 = { { 26{ padl_bits_7[25] } }, padl_bits_7 };
  wire [52-1:0] padl_26;
  wire [26-1:0] padl_bits_27;
  wire [26-1:0] padl_28;
  wire [15-1:0] padl_bits_29;
  wire [15-1:0] const_30;
  assign const_30 = 15'd8;
  assign padl_bits_29 = const_30;
  assign padl_28 = { { 11{ padl_bits_29[14] } }, padl_bits_29 };
  assign padl_bits_27 = padl_28;
  assign padl_26 = { { 26{ padl_bits_27[25] } }, padl_bits_27 };
  assign truncval_5 = padl_6 * padl_26;
  assign truncR_4 = truncval_5[27:0];
  assign padl_bits_3 = truncR_4[27:20];
  wire [1-1:0] padl_bits_zero_31;
  assign padl_bits_zero_31 = 0;
  assign padl_2 = { padl_bits_zero_31, padl_bits_3 };
  assign padr_0 = { padl_2, padr_bits_1 };
  assign output_voltage_real = padr_0;

endmodule

