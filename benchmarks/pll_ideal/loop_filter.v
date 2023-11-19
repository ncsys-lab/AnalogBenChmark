

module loop_filter #
(
  parameter C_one = 1677,
  parameter C_two = 1441,
  parameter R = 1302
)
(
  input clk,
  input reset,
  input [19-1:0] input_current_real,
  output [10-1:0] output_voltage_real
);

  reg [12-1:0] v_o;
  reg [19-1:0] i_r;
  wire [11-1:0] truncval_0;
  wire [12-1:0] toUsInt_1;
  assign toUsInt_1 = v_o;
  assign truncval_0 = toUsInt_1[8:0];
  assign output_voltage_real = truncval_0[9:0];
  wire [16-1:0] truncR_2;
  wire [16-1:0] padl_3;
  wire [13-1:0] padl_bits_4;
  wire [40-1:0] truncR_5;
  wire [49-1:0] truncval_6;
  wire [49-1:0] padl_7;
  wire [24-1:0] padl_bits_8;
  wire [24-1:0] padl_9;
  wire [20-1:0] padl_bits_10;
  wire [1-1:0] toSInt_11;
  assign toSInt_11 = 0;
  wire [20-1:0] toSInt_imm_12;
  wire [19-1:0] const_13;
  assign const_13 = 5242;
  assign toSInt_imm_12 = { toSInt_11, const_13 };
  assign padl_bits_10 = toSInt_imm_12;
  assign padl_9 = { { 4{ padl_bits_10[19] } }, padl_bits_10 };
  assign padl_bits_8 = padl_9;
  assign padl_7 = { { 25{ padl_bits_8[23] } }, padl_bits_8 };
  wire [49-1:0] padl_14;
  wire [24-1:0] padl_bits_15;
  wire [24-1:0] padr_16;
  wire [14-1:0] padr_bits_17;
  assign padr_bits_17 = 0;
  wire [41-1:0] truncR_18;
  wire [67-1:0] truncval_19;
  wire [67-1:0] padl_20;
  wire [33-1:0] padl_bits_21;
  wire [33-1:0] padr_22;
  wire [18-1:0] padr_bits_23;
  assign padr_bits_23 = 0;
  wire [1-1:0] toSInt_24;
  assign toSInt_24 = 0;
  wire [15-1:0] toSInt_imm_25;
  wire [14-1:0] const_26;
  assign const_26 = 5000;
  assign toSInt_imm_25 = { toSInt_24, const_26 };
  assign padr_22 = { toSInt_imm_25, padr_bits_23 };
  assign padl_bits_21 = padr_22;
  assign padl_20 = { { 34{ padl_bits_21[32] } }, padl_bits_21 };
  wire [67-1:0] padl_27;
  wire [33-1:0] padl_bits_28;
  wire [33-1:0] padl_29;
  wire [20-1:0] padl_bits_30;
  wire [20-1:0] padr_31;
  wire [1-1:0] padr_bits_32;
  assign padr_bits_32 = 0;
  assign padr_31 = { i_r, padr_bits_32 };
  wire [52-1:0] truncR_33;
  wire [61-1:0] truncval_34;
  wire [61-1:0] padl_35;
  wire [30-1:0] padl_bits_36;
  wire [30-1:0] padr_37;
  wire [18-1:0] padr_bits_38;
  assign padr_bits_38 = 0;
  assign padr_37 = { v_o, padr_bits_38 };
  assign padl_bits_36 = padr_37;
  assign padl_35 = { { 31{ padl_bits_36[29] } }, padl_bits_36 };
  wire [61-1:0] padl_39;
  wire [30-1:0] padl_bits_40;
  wire [30-1:0] padl_41;
  wire [26-1:0] padl_bits_42;
  wire [1-1:0] toSInt_43;
  assign toSInt_43 = 0;
  wire [26-1:0] toSInt_imm_44;
  wire [25-1:0] const_45;
  assign const_45 = 6440;
  assign toSInt_imm_44 = { toSInt_43, const_45 };
  assign padl_bits_42 = toSInt_imm_44;
  assign padl_41 = { { 4{ padl_bits_42[25] } }, padl_bits_42 };
  assign padl_bits_40 = padl_41;
  assign padl_39 = { { 31{ padl_bits_40[29] } }, padl_bits_40 };
  assign truncval_34 = padl_35 * padl_39;
  wire [52-1:0] truncval_imm_46;
  assign truncval_imm_46 = { truncval_34[60], truncval_34[50:0] };
  assign truncR_33 = truncval_imm_46;
  wire [20-1:0] truncR_shift_47;
  assign truncR_shift_47 = truncR_33 >>> 32;
  wire [20-1:0] truncR_imm_48;
  assign truncR_imm_48 = (truncR_33[51])? truncR_shift_47[19:0] : truncR_33[51:32];
  assign padl_bits_30 = padr_31 - truncR_imm_48;
  assign padl_29 = { { 13{ padl_bits_30[19] } }, padl_bits_30 };
  assign padl_bits_28 = padl_29;
  assign padl_27 = { { 34{ padl_bits_28[32] } }, padl_bits_28 };
  assign truncval_19 = padl_20 * padl_27;
  wire [41-1:0] truncval_imm_49;
  assign truncval_imm_49 = { truncval_19[66], truncval_19[39:0] };
  assign truncR_18 = truncval_imm_49;
  wire [10-1:0] truncR_shift_50;
  assign truncR_shift_50 = truncR_18 >>> 31;
  wire [10-1:0] truncR_imm_51;
  assign truncR_imm_51 = (truncR_18[40])? truncR_shift_50[9:0] : truncR_18[40:31];
  assign padr_16 = { truncR_imm_51, padr_bits_17 };
  assign padl_bits_15 = padr_16;
  assign padl_14 = { { 25{ padl_bits_15[23] } }, padl_bits_15 };
  assign truncval_6 = padl_7 * padl_14;
  wire [40-1:0] truncval_imm_52;
  assign truncval_imm_52 = { truncval_6[48], truncval_6[38:0] };
  assign truncR_5 = truncval_imm_52;
  wire [13-1:0] truncR_shift_53;
  assign truncR_shift_53 = truncR_5 >>> 27;
  wire [13-1:0] truncR_imm_54;
  assign truncR_imm_54 = (truncR_5[39])? truncR_shift_53[12:0] : truncR_5[39:27];
  assign padl_bits_4 = truncR_imm_54;
  assign padl_3 = { { 3{ padl_bits_4[12] } }, padl_bits_4 };
  assign truncR_2 = padl_3;
  wire [12-1:0] truncR_shift_55;
  assign truncR_shift_55 = truncR_2 >>> 4;
  wire [12-1:0] truncR_imm_56;
  assign truncR_imm_56 = (truncR_2[15])? truncR_shift_55[11:0] : truncR_2[15:4];

  always @(posedge clk) begin
    if(reset) begin
      i_r <= 0;
    end else begin
      i_r <= input_current_real;
    end
    if(reset) begin
      v_o <= 0;
    end else begin
      v_o <= v_o + truncR_imm_56;
    end
  end


endmodule

