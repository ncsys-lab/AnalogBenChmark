

module loop_filter #
(
  parameter C_one = 1125,
  parameter C_two = 1441,
  parameter R = 1250
)
(
  input clk,
  input reset,
  input [19-1:0] input_current_real,
  output [10-1:0] output_voltage_real
);

  reg [10-1:0] v_o;
  reg [19-1:0] i_r;
  assign output_voltage_real = v_o;
  wire [10-1:0] padr_0;
  wire [7-1:0] padr_bits_1;
  assign padr_bits_1 = 0;
  wire [23-1:0] truncval_2;
  wire [24-1:0] toUsInt_3;
  wire [70-1:0] truncR_4;
  wire [115-1:0] truncval_5;
  wire [115-1:0] padl_6;
  wire [57-1:0] padl_bits_7;
  wire [57-1:0] padl_8;
  wire [24-1:0] padl_bits_9;
  wire [1-1:0] toSInt_10;
  assign toSInt_10 = 0;
  wire [24-1:0] toSInt_imm_11;
  wire [23-1:0] const_12;
  assign const_12 = 8388;
  assign toSInt_imm_11 = { toSInt_10, const_12 };
  assign padl_bits_9 = toSInt_imm_11;
  assign padl_8 = { { 33{ padl_bits_9[23] } }, padl_bits_9 };
  assign padl_bits_7 = padl_8;
  assign padl_6 = { { 58{ padl_bits_7[56] } }, padl_bits_7 };
  wire [115-1:0] padl_13;
  wire [57-1:0] padl_bits_14;
  wire [57-1:0] padr_15;
  wire [23-1:0] padr_bits_16;
  assign padr_bits_16 = 0;
  wire [42-1:0] truncR_17;
  wire [95-1:0] truncval_18;
  wire [95-1:0] padl_19;
  wire [61-1:0] padl_bits_20;
  wire [61-1:0] padr_21;
  wire [18-1:0] padr_bits_22;
  assign padr_bits_22 = 0;
  wire [1-1:0] toSInt_23;
  assign toSInt_23 = 0;
  wire [43-1:0] toSInt_imm_24;
  wire [42-1:0] const_25;
  assign const_25 = 7450;
  assign toSInt_imm_24 = { toSInt_23, const_25 };
  assign padr_21 = { toSInt_imm_24, padr_bits_22 };
  assign padl_bits_20 = padr_21;
  assign padl_19 = { { 34{ padl_bits_20[60] } }, padl_bits_20 };
  wire [95-1:0] padl_26;
  wire [61-1:0] padl_bits_27;
  wire [61-1:0] padl_28;
  wire [20-1:0] padl_bits_29;
  wire [20-1:0] padr_30;
  wire [1-1:0] padr_bits_31;
  assign padr_bits_31 = 0;
  assign padr_30 = { i_r, padr_bits_31 };
  wire [20-1:0] padl_32;
  wire [19-1:0] padl_bits_33;
  wire [1-1:0] toSInt_34;
  assign toSInt_34 = 0;
  wire [19-1:0] toSInt_imm_35;
  wire [50-1:0] truncR_36;
  wire [56-1:0] truncval_37;
  wire [56-1:0] padl_38;
  wire [28-1:0] padl_bits_39;
  wire [28-1:0] padr_40;
  wire [18-1:0] padr_bits_41;
  assign padr_bits_41 = 0;
  assign padr_40 = { v_o, padr_bits_41 };
  assign padl_bits_39 = padr_40;
  wire [28-1:0] padl_bits_zero_42;
  assign padl_bits_zero_42 = 0;
  assign padl_38 = { padl_bits_zero_42, padl_bits_39 };
  wire [56-1:0] padl_43;
  wire [28-1:0] padl_bits_44;
  wire [28-1:0] padl_45;
  wire [25-1:0] padl_bits_46;
  wire [25-1:0] const_47;
  assign const_47 = 6710;
  assign padl_bits_46 = const_47;
  wire [3-1:0] padl_bits_zero_48;
  assign padl_bits_zero_48 = 0;
  assign padl_45 = { padl_bits_zero_48, padl_bits_46 };
  assign padl_bits_44 = padl_45;
  wire [28-1:0] padl_bits_zero_49;
  assign padl_bits_zero_49 = 0;
  assign padl_43 = { padl_bits_zero_49, padl_bits_44 };
  assign truncval_37 = padl_38 * padl_43;
  assign truncR_36 = truncval_37[49:0];
  assign toSInt_imm_35 = { toSInt_34, truncR_36[49:32] };
  assign padl_bits_33 = toSInt_imm_35;
  assign padl_32 = { { 1{ padl_bits_33[18] } }, padl_bits_33 };
  assign padl_bits_29 = padr_30 - padl_32;
  assign padl_28 = { { 41{ padl_bits_29[19] } }, padl_bits_29 };
  assign padl_bits_27 = padl_28;
  assign padl_26 = { { 34{ padl_bits_27[60] } }, padl_bits_27 };
  assign truncval_18 = padl_19 * padl_26;
  wire [42-1:0] truncval_imm_50;
  assign truncval_imm_50 = { truncval_18[94], truncval_18[40:0] };
  assign truncR_17 = truncval_imm_50;
  wire [34-1:0] truncR_shift_51;
  assign truncR_shift_51 = truncR_17 >>> 8;
  wire [34-1:0] truncR_imm_52;
  assign truncR_imm_52 = (truncR_17[41])? truncR_shift_51[33:0] : truncR_17[41:8];
  assign padr_15 = { truncR_imm_52, padr_bits_16 };
  assign padl_bits_14 = padr_15;
  assign padl_13 = { { 58{ padl_bits_14[56] } }, padl_bits_14 };
  assign truncval_5 = padl_6 * padl_13;
  wire [70-1:0] truncval_imm_53;
  assign truncval_imm_53 = { truncval_5[114], truncval_5[68:0] };
  assign truncR_4 = truncval_imm_53;
  wire [24-1:0] truncR_shift_54;
  assign truncR_shift_54 = truncR_4 >>> 46;
  wire [24-1:0] truncR_imm_55;
  assign truncR_imm_55 = (truncR_4[69])? truncR_shift_54[23:0] : truncR_4[69:46];
  assign toUsInt_3 = truncR_imm_55;
  assign truncval_2 = toUsInt_3[20:0];
  assign padr_0 = { truncval_2[2:0], padr_bits_1 };

  always @(posedge clk) begin
    if(reset) begin
      i_r <= 0;
    end else begin
      i_r <= input_current_real;
    end
    if(reset) begin
      v_o <= 0;
    end else begin
      v_o <= v_o + padr_0;
    end
  end


endmodule

