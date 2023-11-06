

module voltage_controlled_oscillator #
(
  parameter gain = 1536,
  parameter damping_resistance = 1887
)
(
  input clk,
  input reset,
  input [10-1:0] input_voltage_real,
  output [17-1:0] output_clock_real
);

  reg [17-1:0] x;
  reg [17-1:0] v;
  wire [11-1:0] dvdt;
  wire [10-1:0] dxdt;
  wire [11-1:0] padl_0;
  wire [9-1:0] padl_bits_1;
  wire [11-1:0] truncR_2;
  wire [25-1:0] truncR_3;
  wire [35-1:0] truncval_4;
  wire [35-1:0] padl_5;
  wire [17-1:0] padl_bits_6;
  wire [17-1:0] padr_7;
  wire [2-1:0] padr_bits_8;
  assign padr_bits_8 = 0;
  wire [15-1:0] padl_9;
  wire [10-1:0] padl_bits_10;
  wire [10-1:0] neg_imm_11;
  wire [27-1:0] truncR_12;
  wire [35-1:0] truncval_13;
  wire [35-1:0] padl_14;
  wire [17-1:0] padl_bits_15;
  wire [17-1:0] padr_16;
  wire [7-1:0] padr_bits_17;
  assign padr_bits_17 = 0;
  wire [20-1:0] truncR_18;
  wire [21-1:0] truncval_19;
  wire [21-1:0] padl_20;
  wire [10-1:0] padl_bits_21;
  wire [10-1:0] padr_22;
  wire [1-1:0] padr_bits_23;
  assign padr_bits_23 = 0;
  wire [9-1:0] padl_24;
  wire [8-1:0] padl_bits_25;
  wire [24-1:0] truncR_26;
  wire [28-1:0] truncval_27;
  wire [28-1:0] padl_28;
  wire [14-1:0] padl_bits_29;
  wire [14-1:0] padl_30;
  wire [11-1:0] padl_bits_31;
  wire [11-1:0] param_32;
  assign param_32 = gain;
  assign padl_bits_31 = param_32;
  wire [3-1:0] padl_bits_zero_33;
  assign padl_bits_zero_33 = 0;
  assign padl_30 = { padl_bits_zero_33, padl_bits_31 };
  assign padl_bits_29 = padl_30;
  wire [14-1:0] padl_bits_zero_34;
  assign padl_bits_zero_34 = 0;
  assign padl_28 = { padl_bits_zero_34, padl_bits_29 };
  wire [28-1:0] padl_35;
  wire [14-1:0] padl_bits_36;
  wire [14-1:0] padr_37;
  wire [4-1:0] padr_bits_38;
  assign padr_bits_38 = 0;
  assign padr_37 = { input_voltage_real, padr_bits_38 };
  assign padl_bits_36 = padr_37;
  wire [14-1:0] padl_bits_zero_39;
  assign padl_bits_zero_39 = 0;
  assign padl_35 = { padl_bits_zero_39, padl_bits_36 };
  assign truncval_27 = padl_28 * padl_35;
  assign truncR_26 = truncval_27[23:0];
  assign padl_bits_25 = truncR_26[23:16];
  wire [1-1:0] padl_bits_zero_40;
  assign padl_bits_zero_40 = 0;
  assign padl_24 = { padl_bits_zero_40, padl_bits_25 };
  assign padr_22 = { padl_24, padr_bits_23 };
  assign padl_bits_21 = padr_22;
  wire [11-1:0] padl_bits_zero_41;
  assign padl_bits_zero_41 = 0;
  assign padl_20 = { padl_bits_zero_41, padl_bits_21 };
  wire [21-1:0] padl_42;
  wire [10-1:0] padl_bits_43;
  assign padl_bits_43 = input_voltage_real;
  wire [11-1:0] padl_bits_zero_44;
  assign padl_bits_zero_44 = 0;
  assign padl_42 = { padl_bits_zero_44, padl_bits_43 };
  assign truncval_19 = padl_20 * padl_42;
  wire [20-1:0] truncval_imm_45;
  assign truncval_imm_45 = { truncval_19[20], truncval_19[18:0] };
  assign truncR_18 = truncval_imm_45;
  wire [10-1:0] truncR_shift_46;
  assign truncR_shift_46 = truncR_18 >>> 10;
  wire [10-1:0] truncR_imm_47;
  assign truncR_imm_47 = (truncR_18[19])? truncR_shift_46[9:0] : truncR_18[19:10];
  assign padr_16 = { truncR_imm_47, padr_bits_17 };
  assign padl_bits_15 = padr_16;
  assign padl_14 = { { 18{ padl_bits_15[16] } }, padl_bits_15 };
  wire [35-1:0] padl_48;
  wire [17-1:0] padl_bits_49;
  wire [17-1:0] padl_50;
  wire [12-1:0] padl_bits_51;
  wire [1-1:0] toSInt_52;
  assign toSInt_52 = 0;
  wire [12-1:0] toSInt_imm_53;
  wire [11-1:0] param_54;
  assign param_54 = gain;
  assign toSInt_imm_53 = { toSInt_52, param_54 };
  assign padl_bits_51 = toSInt_imm_53;
  assign padl_50 = { { 5{ padl_bits_51[11] } }, padl_bits_51 };
  assign padl_bits_49 = padl_50;
  assign padl_48 = { { 18{ padl_bits_49[16] } }, padl_bits_49 };
  assign truncval_13 = padl_14 * padl_48;
  wire [27-1:0] truncval_imm_55;
  assign truncval_imm_55 = { truncval_13[34], truncval_13[25:0] };
  assign truncR_12 = truncval_imm_55;
  wire [10-1:0] truncR_shift_56;
  assign truncR_shift_56 = truncR_12 >>> 17;
  wire [10-1:0] truncR_imm_57;
  assign truncR_imm_57 = (truncR_12[26])? truncR_shift_56[9:0] : truncR_12[26:17];
  assign neg_imm_11 = -truncR_imm_57;
  assign padl_bits_10 = neg_imm_11;
  assign padl_9 = { { 5{ padl_bits_10[9] } }, padl_bits_10 };
  assign padr_7 = { padl_9, padr_bits_8 };
  assign padl_bits_6 = padr_7;
  assign padl_5 = { { 18{ padl_bits_6[16] } }, padl_bits_6 };
  wire [35-1:0] padl_58;
  wire [17-1:0] padl_bits_59;
  assign padl_bits_59 = x;
  assign padl_58 = { { 18{ padl_bits_59[16] } }, padl_bits_59 };
  assign truncval_4 = padl_5 * padl_58;
  wire [25-1:0] truncval_imm_60;
  assign truncval_imm_60 = { truncval_4[34], truncval_4[23:0] };
  assign truncR_3 = truncval_imm_60;
  wire [11-1:0] truncR_shift_61;
  assign truncR_shift_61 = truncR_3 >>> 14;
  wire [11-1:0] truncR_imm_62;
  assign truncR_imm_62 = (truncR_3[24])? truncR_shift_61[10:0] : truncR_3[24:14];
  assign truncR_2 = truncR_imm_62;
  wire [9-1:0] truncR_shift_63;
  assign truncR_shift_63 = truncR_2 >>> 2;
  wire [9-1:0] truncR_imm_64;
  assign truncR_imm_64 = (truncR_2[10])? truncR_shift_63[8:0] : truncR_2[10:2];
  assign padl_bits_1 = truncR_imm_64;
  assign padl_0 = { { 2{ padl_bits_1[8] } }, padl_bits_1 };
  assign dvdt = padl_0;
  wire [10-1:0] padl_65;
  wire [9-1:0] padl_bits_66;
  wire [10-1:0] truncR_67;
  wire [17-1:0] truncR_68;
  assign truncR_68 = v;
  wire [10-1:0] truncR_shift_69;
  assign truncR_shift_69 = truncR_68 >>> 7;
  wire [10-1:0] truncR_imm_70;
  assign truncR_imm_70 = (truncR_68[16])? truncR_shift_69[9:0] : truncR_68[16:7];
  assign truncR_67 = truncR_imm_70;
  wire [9-1:0] truncR_shift_71;
  assign truncR_shift_71 = truncR_67 >>> 1;
  wire [9-1:0] truncR_imm_72;
  assign truncR_imm_72 = (truncR_67[9])? truncR_shift_71[8:0] : truncR_67[9:1];
  assign padl_bits_66 = truncR_imm_72;
  assign padl_65 = { { 1{ padl_bits_66[8] } }, padl_bits_66 };
  assign dxdt = padl_65;
  assign output_clock_real = x;
  wire [22-1:0] truncR_73;
  wire [22-1:0] padl_74;
  wire [14-1:0] padl_bits_75;
  wire [52-1:0] truncR_76;
  wire [73-1:0] truncval_77;
  wire [73-1:0] padl_78;
  wire [37-1:0] padl_bits_79;
  wire [37-1:0] padl_80;
  wire [27-1:0] padl_bits_81;
  wire [1-1:0] toSInt_82;
  assign toSInt_82 = 0;
  wire [27-1:0] toSInt_imm_83;
  wire [26-1:0] const_84;
  assign const_84 = 6710;
  assign toSInt_imm_83 = { toSInt_82, const_84 };
  assign padl_bits_81 = toSInt_imm_83;
  assign padl_80 = { { 10{ padl_bits_81[26] } }, padl_bits_81 };
  assign padl_bits_79 = padl_80;
  assign padl_78 = { { 36{ padl_bits_79[36] } }, padl_bits_79 };
  wire [73-1:0] padl_85;
  wire [37-1:0] padl_bits_86;
  wire [37-1:0] padr_87;
  wire [26-1:0] padr_bits_88;
  assign padr_bits_88 = 0;
  assign padr_87 = { dvdt, padr_bits_88 };
  assign padl_bits_86 = padr_87;
  assign padl_85 = { { 36{ padl_bits_86[36] } }, padl_bits_86 };
  assign truncval_77 = padl_78 * padl_85;
  wire [52-1:0] truncval_imm_89;
  assign truncval_imm_89 = { truncval_77[72], truncval_77[50:0] };
  assign truncR_76 = truncval_imm_89;
  wire [14-1:0] truncR_shift_90;
  assign truncR_shift_90 = truncR_76 >>> 38;
  wire [14-1:0] truncR_imm_91;
  assign truncR_imm_91 = (truncR_76[51])? truncR_shift_90[13:0] : truncR_76[51:38];
  assign padl_bits_75 = truncR_imm_91;
  assign padl_74 = { { 8{ padl_bits_75[13] } }, padl_bits_75 };
  assign truncR_73 = padl_74;
  wire [17-1:0] truncR_shift_92;
  assign truncR_shift_92 = truncR_73 >>> 5;
  wire [17-1:0] truncR_imm_93;
  assign truncR_imm_93 = (truncR_73[21])? truncR_shift_92[16:0] : truncR_73[21:5];
  wire [22-1:0] truncR_94;
  wire [22-1:0] padl_95;
  wire [14-1:0] padl_bits_96;
  wire [53-1:0] truncR_97;
  wire [72-1:0] truncval_98;
  wire [72-1:0] padl_99;
  wire [36-1:0] padl_bits_100;
  wire [36-1:0] padl_101;
  wire [27-1:0] padl_bits_102;
  wire [1-1:0] toSInt_103;
  assign toSInt_103 = 0;
  wire [27-1:0] toSInt_imm_104;
  wire [26-1:0] const_105;
  assign const_105 = 6710;
  assign toSInt_imm_104 = { toSInt_103, const_105 };
  assign padl_bits_102 = toSInt_imm_104;
  assign padl_101 = { { 9{ padl_bits_102[26] } }, padl_bits_102 };
  assign padl_bits_100 = padl_101;
  assign padl_99 = { { 36{ padl_bits_100[35] } }, padl_bits_100 };
  wire [72-1:0] padl_106;
  wire [36-1:0] padl_bits_107;
  wire [36-1:0] padr_108;
  wire [26-1:0] padr_bits_109;
  assign padr_bits_109 = 0;
  assign padr_108 = { dxdt, padr_bits_109 };
  assign padl_bits_107 = padr_108;
  assign padl_106 = { { 36{ padl_bits_107[35] } }, padl_bits_107 };
  assign truncval_98 = padl_99 * padl_106;
  wire [53-1:0] truncval_imm_110;
  assign truncval_imm_110 = { truncval_98[71], truncval_98[51:0] };
  assign truncR_97 = truncval_imm_110;
  wire [14-1:0] truncR_shift_111;
  assign truncR_shift_111 = truncR_97 >>> 39;
  wire [14-1:0] truncR_imm_112;
  assign truncR_imm_112 = (truncR_97[52])? truncR_shift_111[13:0] : truncR_97[52:39];
  assign padl_bits_96 = truncR_imm_112;
  assign padl_95 = { { 8{ padl_bits_96[13] } }, padl_bits_96 };
  assign truncR_94 = padl_95;
  wire [17-1:0] truncR_shift_113;
  assign truncR_shift_113 = truncR_94 >>> 5;
  wire [17-1:0] truncR_imm_114;
  assign truncR_imm_114 = (truncR_94[21])? truncR_shift_113[16:0] : truncR_94[21:5];

  always @(posedge clk) begin
    if(reset) begin
      v <= 0;
    end else begin
      v <= v + truncR_imm_93;
    end
    if(reset) begin
      x <= 128;
    end else begin
      x <= x + truncR_imm_114;
    end
  end


endmodule

