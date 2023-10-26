

module voltage_controled_oscillator
(
  input clk,
  input reset,
  input [10-1:0] input_voltage_real,
  output [1-1:0] output_clock_digital
);

  reg [9-1:0] x;
  reg [12-1:0] v;
  wire [10-1:0] dvdt;
  wire [8-1:0] dxdt;
  wire [19-1:0] truncR_0;
  wire [19-1:0] padl_1;
  wire [15-1:0] padl_bits_2;
  wire [1-1:0] toSInt_3;
  assign toSInt_3 = 0;
  wire [15-1:0] toSInt_imm_4;
  wire [14-1:0] const_5;
  assign const_5 = 6553;
  assign toSInt_imm_4 = { toSInt_3, const_5 };
  assign padl_bits_2 = toSInt_imm_4;
  assign padl_1 = { { 4{ padl_bits_2[14] } }, padl_bits_2 };
  wire [19-1:0] padr_6;
  wire [9-1:0] padr_bits_7;
  assign padr_bits_7 = 0;
  wire [19-1:0] truncR_8;
  wire [25-1:0] truncval_9;
  wire [25-1:0] padl_10;
  wire [12-1:0] padl_bits_11;
  wire [12-1:0] padr_12;
  wire [2-1:0] padr_bits_13;
  assign padr_bits_13 = 0;
  wire [20-1:0] truncR_14;
  wire [21-1:0] truncval_15;
  wire [21-1:0] padl_16;
  wire [10-1:0] padl_bits_17;
  assign padl_bits_17 = input_voltage_real;
  wire [11-1:0] padl_bits_zero_18;
  assign padl_bits_zero_18 = 0;
  assign padl_16 = { padl_bits_zero_18, padl_bits_17 };
  wire [21-1:0] padl_19;
  wire [10-1:0] padl_bits_20;
  assign padl_bits_20 = input_voltage_real;
  wire [11-1:0] padl_bits_zero_21;
  assign padl_bits_zero_21 = 0;
  assign padl_19 = { padl_bits_zero_21, padl_bits_20 };
  assign truncval_15 = padl_16 * padl_19;
  wire [20-1:0] truncval_imm_22;
  assign truncval_imm_22 = { truncval_15[20], truncval_15[18:0] };
  assign truncR_14 = truncval_imm_22;
  wire [10-1:0] truncR_shift_23;
  assign truncR_shift_23 = truncR_14 >>> 10;
  wire [10-1:0] truncR_imm_24;
  assign truncR_imm_24 = (truncR_14[19])? truncR_shift_23[9:0] : truncR_14[19:10];
  assign padr_12 = { truncR_imm_24, padr_bits_13 };
  assign padl_bits_11 = padr_12;
  assign padl_10 = { { 13{ padl_bits_11[11] } }, padl_bits_11 };
  wire [25-1:0] padl_25;
  wire [12-1:0] padl_bits_26;
  wire [12-1:0] padl_27;
  wire [10-1:0] padl_bits_28;
  wire [1-1:0] toSInt_29;
  assign toSInt_29 = 0;
  wire [10-1:0] toSInt_imm_30;
  assign toSInt_imm_30 = { toSInt_29, x };
  assign padl_bits_28 = toSInt_imm_30;
  assign padl_27 = { { 2{ padl_bits_28[9] } }, padl_bits_28 };
  assign padl_bits_26 = padl_27;
  assign padl_25 = { { 13{ padl_bits_26[11] } }, padl_bits_26 };
  assign truncval_9 = padl_10 * padl_25;
  wire [19-1:0] truncval_imm_31;
  assign truncval_imm_31 = { truncval_9[24], truncval_9[17:0] };
  assign truncR_8 = truncval_imm_31;
  wire [10-1:0] truncR_shift_32;
  assign truncR_shift_32 = truncR_8 >>> 9;
  wire [10-1:0] truncR_imm_33;
  assign truncR_imm_33 = (truncR_8[18])? truncR_shift_32[9:0] : truncR_8[18:9];
  assign padr_6 = { truncR_imm_33, padr_bits_7 };
  assign truncR_0 = padl_1 - padr_6;
  wire [10-1:0] truncR_shift_34;
  assign truncR_shift_34 = truncR_0 >>> 9;
  wire [10-1:0] truncR_imm_35;
  assign truncR_imm_35 = (truncR_0[18])? truncR_shift_34[9:0] : truncR_0[18:9];
  assign dvdt = truncR_imm_35;
  wire [9-1:0] truncR_36;
  wire [11-1:0] truncval_37;
  wire [12-1:0] toUsInt_38;
  assign toUsInt_38 = v;
  assign truncval_37 = toUsInt_38[8:0];
  assign truncR_36 = truncval_37[8:0];
  assign dxdt = truncR_36[8:1];
  wire [7-1:0] truncR_39;
  wire [9-1:0] truncval_40;
  assign truncval_40 = x;
  assign truncR_39 = truncval_40[6:0];
  assign output_clock_digital = truncR_39[6:6];
  wire [25-1:0] truncR_41;
  wire [25-1:0] padl_42;
  wire [21-1:0] padl_bits_43;
  wire [60-1:0] truncR_44;
  wire [73-1:0] truncval_45;
  wire [73-1:0] padl_46;
  wire [36-1:0] padl_bits_47;
  wire [36-1:0] padl_48;
  wire [30-1:0] padl_bits_49;
  wire [1-1:0] toSInt_50;
  assign toSInt_50 = 0;
  wire [30-1:0] toSInt_imm_51;
  wire [29-1:0] const_52;
  assign const_52 = 5368;
  assign toSInt_imm_51 = { toSInt_50, const_52 };
  assign padl_bits_49 = toSInt_imm_51;
  assign padl_48 = { { 6{ padl_bits_49[29] } }, padl_bits_49 };
  assign padl_bits_47 = padl_48;
  assign padl_46 = { { 37{ padl_bits_47[35] } }, padl_bits_47 };
  wire [73-1:0] padl_53;
  wire [36-1:0] padl_bits_54;
  wire [36-1:0] padr_55;
  wire [26-1:0] padr_bits_56;
  assign padr_bits_56 = 0;
  assign padr_55 = { dvdt, padr_bits_56 };
  assign padl_bits_54 = padr_55;
  assign padl_53 = { { 37{ padl_bits_54[35] } }, padl_bits_54 };
  assign truncval_45 = padl_46 * padl_53;
  wire [60-1:0] truncval_imm_57;
  assign truncval_imm_57 = { truncval_45[72], truncval_45[58:0] };
  assign truncR_44 = truncval_imm_57;
  wire [21-1:0] truncR_shift_58;
  assign truncR_shift_58 = truncR_44 >>> 39;
  wire [21-1:0] truncR_imm_59;
  assign truncR_imm_59 = (truncR_44[59])? truncR_shift_58[20:0] : truncR_44[59:39];
  assign padl_bits_43 = truncR_imm_59;
  assign padl_42 = { { 4{ padl_bits_43[20] } }, padl_bits_43 };
  assign truncR_41 = padl_42;
  wire [12-1:0] truncR_shift_60;
  assign truncR_shift_60 = truncR_41 >>> 13;
  wire [12-1:0] truncR_imm_61;
  assign truncR_imm_61 = (truncR_41[24])? truncR_shift_60[11:0] : truncR_41[24:13];
  wire [25-1:0] truncR_62;
  wire [25-1:0] padl_63;
  wire [22-1:0] padl_bits_64;
  wire [58-1:0] truncR_65;
  wire [64-1:0] truncval_66;
  wire [64-1:0] padl_67;
  wire [32-1:0] padl_bits_68;
  wire [32-1:0] padl_69;
  wire [29-1:0] padl_bits_70;
  wire [29-1:0] const_71;
  assign const_71 = 5368;
  assign padl_bits_70 = const_71;
  wire [3-1:0] padl_bits_zero_72;
  assign padl_bits_zero_72 = 0;
  assign padl_69 = { padl_bits_zero_72, padl_bits_70 };
  assign padl_bits_68 = padl_69;
  wire [32-1:0] padl_bits_zero_73;
  assign padl_bits_zero_73 = 0;
  assign padl_67 = { padl_bits_zero_73, padl_bits_68 };
  wire [64-1:0] padl_74;
  wire [32-1:0] padl_bits_75;
  wire [32-1:0] padr_76;
  wire [24-1:0] padr_bits_77;
  assign padr_bits_77 = 0;
  assign padr_76 = { dxdt, padr_bits_77 };
  assign padl_bits_75 = padr_76;
  wire [32-1:0] padl_bits_zero_78;
  assign padl_bits_zero_78 = 0;
  assign padl_74 = { padl_bits_zero_78, padl_bits_75 };
  assign truncval_66 = padl_67 * padl_74;
  assign truncR_65 = truncval_66[57:0];
  assign padl_bits_64 = truncR_65[57:36];
  wire [3-1:0] padl_bits_zero_79;
  assign padl_bits_zero_79 = 0;
  assign padl_63 = { padl_bits_zero_79, padl_bits_64 };
  assign truncR_62 = padl_63;

  always @(posedge clk) begin
    if(reset) begin
      v <= 0;
    end else begin
      v <= v + truncR_imm_61;
    end
    if(reset) begin
      x <= 0;
    end else begin
      x <= x + truncR_62[24:16];
    end
  end


endmodule

