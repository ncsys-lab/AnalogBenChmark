

module loop_filter #
(
  parameter C_one = 1125,
  parameter C_two = 1441,
  parameter R = 1562
)
(
  input clk,
  input reset,
  input [24-1:0] input_current_real,
  output [10-1:0] output_voltage_real
);

  reg [10-1:0] v_o;
  reg [24-1:0] i_r;
  wire [83-1:0] di_dt;
  reg [46-1:0] int_i_r;
  wire [86-1:0] truncR_0;
  wire [152-1:0] truncR_1;
  wire [155-1:0] truncval_2;
  wire [155-1:0] padl_3;
  wire [77-1:0] padl_bits_4;
  wire [77-1:0] padr_5;
  wire [53-1:0] padr_bits_6;
  assign padr_bits_6 = 0;
  assign padr_5 = { input_current_real, padr_bits_6 };
  assign padl_bits_4 = padr_5;
  assign padl_3 = { { 78{ padl_bits_4[76] } }, padl_bits_4 };
  wire [155-1:0] padl_7;
  wire [77-1:0] padl_bits_8;
  wire [77-1:0] padl_9;
  wire [76-1:0] padl_bits_10;
  wire [1-1:0] toSInt_11;
  assign toSInt_11 = 0;
  wire [76-1:0] toSInt_imm_12;
  wire [75-1:0] const_13;
  assign const_13 = 7555;
  assign toSInt_imm_12 = { toSInt_11, const_13 };
  assign padl_bits_10 = toSInt_imm_12;
  assign padl_9 = { { 1{ padl_bits_10[75] } }, padl_bits_10 };
  assign padl_bits_8 = padl_9;
  assign padl_7 = { { 78{ padl_bits_8[76] } }, padl_bits_8 };
  assign truncval_2 = padl_3 * padl_7;
  wire [152-1:0] truncval_imm_14;
  assign truncval_imm_14 = { truncval_2[154], truncval_2[150:0] };
  assign truncR_1 = truncval_imm_14;
  wire [86-1:0] truncR_shift_15;
  assign truncR_shift_15 = truncR_1 >>> 66;
  wire [86-1:0] truncR_imm_16;
  assign truncR_imm_16 = (truncR_1[151])? truncR_shift_15[85:0] : truncR_1[151:66];
  wire [152-1:0] truncR_17;
  wire [155-1:0] truncval_18;
  wire [155-1:0] padl_19;
  wire [77-1:0] padl_bits_20;
  wire [77-1:0] padr_21;
  wire [53-1:0] padr_bits_22;
  assign padr_bits_22 = 0;
  assign padr_21 = { i_r, padr_bits_22 };
  assign padl_bits_20 = padr_21;
  assign padl_19 = { { 78{ padl_bits_20[76] } }, padl_bits_20 };
  wire [155-1:0] padl_23;
  wire [77-1:0] padl_bits_24;
  wire [77-1:0] padl_25;
  wire [76-1:0] padl_bits_26;
  wire [1-1:0] toSInt_27;
  assign toSInt_27 = 0;
  wire [76-1:0] toSInt_imm_28;
  wire [75-1:0] const_29;
  assign const_29 = 7555;
  assign toSInt_imm_28 = { toSInt_27, const_29 };
  assign padl_bits_26 = toSInt_imm_28;
  assign padl_25 = { { 1{ padl_bits_26[75] } }, padl_bits_26 };
  assign padl_bits_24 = padl_25;
  assign padl_23 = { { 78{ padl_bits_24[76] } }, padl_bits_24 };
  assign truncval_18 = padl_19 * padl_23;
  wire [152-1:0] truncval_imm_30;
  assign truncval_imm_30 = { truncval_18[154], truncval_18[150:0] };
  assign truncR_17 = truncval_imm_30;
  wire [86-1:0] truncR_shift_31;
  assign truncR_shift_31 = truncR_17 >>> 66;
  wire [86-1:0] truncR_imm_32;
  assign truncR_imm_32 = (truncR_17[151])? truncR_shift_31[85:0] : truncR_17[151:66];
  wire [86-1:0] padr_33;
  wire [3-1:0] padr_bits_34;
  assign padr_bits_34 = 0;
  wire [144-1:0] truncR_35;
  wire [147-1:0] truncval_36;
  wire [147-1:0] padl_37;
  wire [73-1:0] padl_bits_38;
  wire [73-1:0] padr_39;
  wire [49-1:0] padr_bits_40;
  assign padr_bits_40 = 0;
  assign padr_39 = { i_r, padr_bits_40 };
  assign padl_bits_38 = padr_39;
  assign padl_37 = { { 74{ padl_bits_38[72] } }, padl_bits_38 };
  wire [147-1:0] padl_41;
  wire [73-1:0] padl_bits_42;
  wire [73-1:0] padl_43;
  wire [72-1:0] padl_bits_44;
  wire [1-1:0] toSInt_45;
  assign toSInt_45 = 0;
  wire [72-1:0] toSInt_imm_46;
  wire [71-1:0] const_47;
  assign const_47 = 5902;
  assign toSInt_imm_46 = { toSInt_45, const_47 };
  assign padl_bits_44 = toSInt_imm_46;
  assign padl_43 = { { 1{ padl_bits_44[71] } }, padl_bits_44 };
  assign padl_bits_42 = padl_43;
  assign padl_41 = { { 74{ padl_bits_42[72] } }, padl_bits_42 };
  assign truncval_36 = padl_37 * padl_41;
  wire [144-1:0] truncval_imm_48;
  assign truncval_imm_48 = { truncval_36[146], truncval_36[142:0] };
  assign truncR_35 = truncval_imm_48;
  wire [83-1:0] truncR_shift_49;
  assign truncR_shift_49 = truncR_35 >>> 61;
  wire [83-1:0] truncR_imm_50;
  assign truncR_imm_50 = (truncR_35[143])? truncR_shift_49[82:0] : truncR_35[143:61];
  assign padr_33 = { truncR_imm_50, padr_bits_34 };
  assign truncR_0 = truncR_imm_16 - truncR_imm_32 - padr_33;
  wire [83-1:0] truncR_shift_51;
  assign truncR_shift_51 = truncR_0 >>> 3;
  wire [83-1:0] truncR_imm_52;
  assign truncR_imm_52 = (truncR_0[85])? truncR_shift_51[82:0] : truncR_0[85:3];
  assign di_dt = truncR_imm_52;
  wire [99-1:0] truncR_53;
  wire [164-1:0] truncR_54;
  wire [167-1:0] truncval_55;
  wire [167-1:0] padl_56;
  wire [83-1:0] padl_bits_57;
  wire [83-1:0] padr_58;
  wire [52-1:0] padr_bits_59;
  assign padr_bits_59 = 0;
  wire [31-1:0] padl_60;
  wire [30-1:0] padl_bits_61;
  wire [1-1:0] toSInt_62;
  assign toSInt_62 = 0;
  wire [30-1:0] toSInt_imm_63;
  wire [29-1:0] const_64;
  assign const_64 = 5368;
  assign toSInt_imm_63 = { toSInt_62, const_64 };
  assign padl_bits_61 = toSInt_imm_63;
  assign padl_60 = { { 1{ padl_bits_61[29] } }, padl_bits_61 };
  assign padr_58 = { padl_60, padr_bits_59 };
  assign padl_bits_57 = padr_58;
  assign padl_56 = { { 84{ padl_bits_57[82] } }, padl_bits_57 };
  wire [167-1:0] padl_65;
  wire [83-1:0] padl_bits_66;
  assign padl_bits_66 = di_dt;
  assign padl_65 = { { 84{ padl_bits_66[82] } }, padl_bits_66 };
  assign truncval_55 = padl_56 * padl_65;
  wire [164-1:0] truncval_imm_67;
  assign truncval_imm_67 = { truncval_55[166], truncval_55[162:0] };
  assign truncR_54 = truncval_imm_67;
  wire [99-1:0] truncR_shift_68;
  assign truncR_shift_68 = truncR_54 >>> 65;
  wire [99-1:0] truncR_imm_69;
  assign truncR_imm_69 = (truncR_54[163])? truncR_shift_68[98:0] : truncR_54[163:65];
  assign truncR_53 = truncR_imm_69;
  wire [24-1:0] truncR_shift_70;
  assign truncR_shift_70 = truncR_53 >>> 75;
  wire [24-1:0] truncR_imm_71;
  assign truncR_imm_71 = (truncR_53[98])? truncR_shift_70[23:0] : truncR_53[98:75];
  wire [46-1:0] padr_72;
  wire [7-1:0] padr_bits_73;
  assign padr_bits_73 = 0;
  wire [40-1:0] truncval_74;
  wire [41-1:0] toUsInt_75;
  wire [60-1:0] truncR_76;
  wire [63-1:0] truncval_77;
  wire [63-1:0] padl_78;
  wire [31-1:0] padl_bits_79;
  wire [31-1:0] padl_80;
  wire [30-1:0] padl_bits_81;
  wire [1-1:0] toSInt_82;
  assign toSInt_82 = 0;
  wire [30-1:0] toSInt_imm_83;
  wire [29-1:0] const_84;
  assign const_84 = 5368;
  assign toSInt_imm_83 = { toSInt_82, const_84 };
  assign padl_bits_81 = toSInt_imm_83;
  assign padl_80 = { { 1{ padl_bits_81[29] } }, padl_bits_81 };
  assign padl_bits_79 = padl_80;
  assign padl_78 = { { 32{ padl_bits_79[30] } }, padl_bits_79 };
  wire [63-1:0] padl_85;
  wire [31-1:0] padl_bits_86;
  wire [31-1:0] padr_87;
  wire [7-1:0] padr_bits_88;
  assign padr_bits_88 = 0;
  assign padr_87 = { i_r, padr_bits_88 };
  assign padl_bits_86 = padr_87;
  assign padl_85 = { { 32{ padl_bits_86[30] } }, padl_bits_86 };
  assign truncval_77 = padl_78 * padl_85;
  wire [60-1:0] truncval_imm_89;
  assign truncval_imm_89 = { truncval_77[62], truncval_77[58:0] };
  assign truncR_76 = truncval_imm_89;
  wire [41-1:0] truncR_shift_90;
  assign truncR_shift_90 = truncR_76 >>> 19;
  wire [41-1:0] truncR_imm_91;
  assign truncR_imm_91 = (truncR_76[59])? truncR_shift_90[40:0] : truncR_76[59:19];
  assign toUsInt_75 = truncR_imm_91;
  assign truncval_74 = toUsInt_75[37:0];
  assign padr_72 = { truncval_74[38:0], padr_bits_73 };
  wire [10-1:0] padr_92;
  wire [2-1:0] padr_bits_93;
  assign padr_bits_93 = 0;
  wire [9-1:0] toUsInt_94;
  wire [41-1:0] truncR_95;
  wire [76-1:0] truncval_96;
  wire [76-1:0] padl_97;
  wire [41-1:0] padl_bits_98;
  wire [41-1:0] padl_99;
  wire [24-1:0] padl_bits_100;
  assign padl_bits_100 = i_r;
  assign padl_99 = { { 17{ padl_bits_100[23] } }, padl_bits_100 };
  assign padl_bits_98 = padl_99;
  assign padl_97 = { { 35{ padl_bits_98[40] } }, padl_bits_98 };
  wire [76-1:0] padl_101;
  wire [41-1:0] padl_bits_102;
  wire [41-1:0] padr_103;
  wire [22-1:0] padr_bits_104;
  assign padr_bits_104 = 0;
  wire [1-1:0] toSInt_105;
  assign toSInt_105 = 0;
  wire [19-1:0] toSInt_imm_106;
  wire [18-1:0] param_107;
  assign param_107 = R;
  assign toSInt_imm_106 = { toSInt_105, param_107 };
  assign padr_103 = { toSInt_imm_106, padr_bits_104 };
  assign padl_bits_102 = padr_103;
  assign padl_101 = { { 35{ padl_bits_102[40] } }, padl_bits_102 };
  assign truncval_96 = padl_97 * padl_101;
  wire [41-1:0] truncval_imm_108;
  assign truncval_imm_108 = { truncval_96[75], truncval_96[39:0] };
  assign truncR_95 = truncval_imm_108;
  wire [9-1:0] truncR_shift_109;
  assign truncR_shift_109 = truncR_95 >>> 32;
  wire [9-1:0] truncR_imm_110;
  assign truncR_imm_110 = (truncR_95[40])? truncR_shift_109[8:0] : truncR_95[40:32];
  wire [1-1:0] toSInt_111;
  assign toSInt_111 = 0;
  wire [9-1:0] toSInt_imm_112;
  wire [67-1:0] truncR_113;
  wire [148-1:0] truncval_114;
  wire [148-1:0] padl_115;
  wire [88-1:0] padl_bits_116;
  wire [88-1:0] padr_117;
  wire [46-1:0] padr_bits_118;
  assign padr_bits_118 = 0;
  wire [42-1:0] const_119;
  assign const_119 = 7450;
  assign padr_117 = { const_119, padr_bits_118 };
  assign padl_bits_116 = padr_117;
  wire [60-1:0] padl_bits_zero_120;
  assign padl_bits_zero_120 = 0;
  assign padl_115 = { padl_bits_zero_120, padl_bits_116 };
  wire [148-1:0] padl_121;
  wire [88-1:0] padl_bits_122;
  wire [88-1:0] padl_123;
  wire [46-1:0] padl_bits_124;
  assign padl_bits_124 = int_i_r;
  wire [42-1:0] padl_bits_zero_125;
  assign padl_bits_zero_125 = 0;
  assign padl_123 = { padl_bits_zero_125, padl_bits_124 };
  assign padl_bits_122 = padl_123;
  wire [60-1:0] padl_bits_zero_126;
  assign padl_bits_zero_126 = 0;
  assign padl_121 = { padl_bits_zero_126, padl_bits_122 };
  assign truncval_114 = padl_115 * padl_121;
  assign truncR_113 = truncval_114[66:0];
  assign toSInt_imm_112 = { toSInt_111, truncR_113[66:59] };
  assign toUsInt_94 = truncR_imm_110 + toSInt_imm_112;
  assign padr_92 = { toUsInt_94[5:0], padr_bits_93 };
  assign output_voltage_real = v_o;

  always @(posedge clk) begin
    if(reset) begin
      i_r <= 0;
    end else begin
      i_r <= i_r + truncR_imm_71;
    end
    if(reset) begin
      int_i_r <= 0;
    end else begin
      int_i_r <= int_i_r + padr_72;
    end
    if(reset) begin
      v_o <= 0;
    end else begin
      v_o <= padr_92;
    end
  end


endmodule

