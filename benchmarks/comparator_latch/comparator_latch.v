

module comparator_latch #
(
  parameter n_to_response_time = -1038,
  parameter p_to_response_time = -1020,
  parameter const_response_time = 1285,
  parameter n_to_tau = -1248,
  parameter p_to_tau = 1037,
  parameter const_tau = 1042,
  parameter n_to_response_time_lh = -1752,
  parameter p_to_response_time_lh = -1006,
  parameter const_response_time_lh = 1185,
  parameter n_to_tau_lh = 1131,
  parameter p_to_tau_lh = -1115,
  parameter const_tau_lh = 1529
)
(
  input clk,
  input reset,
  input sys_clk,
  input [15-1:0] n,
  input [15-1:0] p,
  output [35-1:0] out
);

  reg [17-1:0] state_cycle_counter;
  reg [1-1:0] prev_sys_clk;
  reg [35-1:0] o;
  wire [32-1:0] wait_time;
  wire [51-1:0] tau;
  wire [36-1:0] dvdt;
  wire [32-1:0] wait_time_lh;
  wire [59-1:0] tau_lh;
  wire [37-1:0] dodt;
  reg [32-1:0] fsm;
  localparam fsm_init = 0;
  wire [35-1:0] padr_0;
  wire [23-1:0] padr_bits_1;
  assign padr_bits_1 = 0;
  wire [29-1:0] truncR_2;
  wire [29-1:0] padl_3;
  wire [28-1:0] padl_bits_4;
  wire [1-1:0] toSInt_5;
  assign toSInt_5 = 0;
  wire [28-1:0] toSInt_imm_6;
  wire [27-1:0] const_7;
  assign const_7 = 27'd55364812;
  assign toSInt_imm_6 = { toSInt_5, const_7 };
  assign padl_bits_4 = toSInt_imm_6;
  assign padl_3 = { { 1{ padl_bits_4[27] } }, padl_bits_4 };
  assign truncR_2 = padl_3;
  wire [12-1:0] truncR_shift_8;
  assign truncR_shift_8 = truncR_2 >>> 17;
  wire [12-1:0] truncR_imm_9;
  assign truncR_imm_9 = (truncR_2[28])? truncR_shift_8[11:0] : truncR_2[28:17];
  assign padr_0 = { truncR_imm_9, padr_bits_1 };
  wire [32-1:0] padl_10;
  wire [18-1:0] padl_bits_11;
  wire [32-1:0] truncR_12;
  wire [32-1:0] padl_13;
  wire [17-1:0] padl_bits_14;
  wire [96-1:0] truncR_15;
  wire [163-1:0] truncval_16;
  wire [163-1:0] padl_17;
  wire [85-1:0] padl_bits_18;
  wire [85-1:0] padl_19;
  wire [52-1:0] padl_bits_20;
  wire [98-1:0] truncR_21;
  wire [107-1:0] truncval_22;
  wire [107-1:0] padl_23;
  wire [53-1:0] padl_bits_24;
  wire [53-1:0] padr_25;
  wire [38-1:0] padr_bits_26;
  assign padr_bits_26 = 0;
  assign padr_25 = { n, padr_bits_26 };
  assign padl_bits_24 = padr_25;
  assign padl_23 = { { 54{ padl_bits_24[52] } }, padl_bits_24 };
  wire [107-1:0] padl_27;
  wire [53-1:0] padl_bits_28;
  wire [53-1:0] padl_29;
  wire [50-1:0] padl_bits_30;
  wire [50-1:0] param_31;
  assign param_31 = n_to_response_time;
  assign padl_bits_30 = param_31;
  assign padl_29 = { { 3{ padl_bits_30[49] } }, padl_bits_30 };
  assign padl_bits_28 = padl_29;
  assign padl_27 = { { 54{ padl_bits_28[52] } }, padl_bits_28 };
  assign truncval_22 = padl_23 * padl_27;
  wire [98-1:0] truncval_imm_32;
  assign truncval_imm_32 = { truncval_22[106], truncval_22[96:0] };
  assign truncR_21 = truncval_imm_32;
  wire [52-1:0] truncR_shift_33;
  assign truncR_shift_33 = truncR_21 >>> 46;
  wire [52-1:0] truncR_imm_34;
  assign truncR_imm_34 = (truncR_21[97])? truncR_shift_33[51:0] : truncR_21[97:46];
  wire [52-1:0] padr_35;
  wire [2-1:0] padr_bits_36;
  assign padr_bits_36 = 0;
  wire [94-1:0] truncR_37;
  wire [103-1:0] truncval_38;
  wire [103-1:0] padl_39;
  wire [51-1:0] padl_bits_40;
  wire [51-1:0] padr_41;
  wire [36-1:0] padr_bits_42;
  assign padr_bits_42 = 0;
  assign padr_41 = { p, padr_bits_42 };
  assign padl_bits_40 = padr_41;
  assign padl_39 = { { 52{ padl_bits_40[50] } }, padl_bits_40 };
  wire [103-1:0] padl_43;
  wire [51-1:0] padl_bits_44;
  wire [51-1:0] padl_45;
  wire [48-1:0] padl_bits_46;
  wire [48-1:0] param_47;
  assign param_47 = p_to_response_time;
  assign padl_bits_46 = param_47;
  assign padl_45 = { { 3{ padl_bits_46[47] } }, padl_bits_46 };
  assign padl_bits_44 = padl_45;
  assign padl_43 = { { 52{ padl_bits_44[50] } }, padl_bits_44 };
  assign truncval_38 = padl_39 * padl_43;
  wire [94-1:0] truncval_imm_48;
  assign truncval_imm_48 = { truncval_38[102], truncval_38[92:0] };
  assign truncR_37 = truncval_imm_48;
  wire [50-1:0] truncR_shift_49;
  assign truncR_shift_49 = truncR_37 >>> 44;
  wire [50-1:0] truncR_imm_50;
  assign truncR_imm_50 = (truncR_37[93])? truncR_shift_49[49:0] : truncR_37[93:44];
  assign padr_35 = { truncR_imm_50, padr_bits_36 };
  wire [52-1:0] padr_51;
  wire [8-1:0] padr_bits_52;
  assign padr_bits_52 = 0;
  wire [44-1:0] padl_53;
  wire [43-1:0] padl_bits_54;
  wire [1-1:0] toSInt_55;
  assign toSInt_55 = 0;
  wire [43-1:0] toSInt_imm_56;
  wire [42-1:0] param_57;
  assign param_57 = const_response_time;
  assign toSInt_imm_56 = { toSInt_55, param_57 };
  assign padl_bits_54 = toSInt_imm_56;
  assign padl_53 = { { 1{ padl_bits_54[42] } }, padl_bits_54 };
  assign padr_51 = { padl_53, padr_bits_52 };
  assign padl_bits_20 = truncR_imm_34 + padr_35 + padr_51;
  assign padl_19 = { { 33{ padl_bits_20[51] } }, padl_bits_20 };
  assign padl_bits_18 = padl_19;
  assign padl_17 = { { 78{ padl_bits_18[84] } }, padl_bits_18 };
  wire [163-1:0] padl_58;
  wire [85-1:0] padl_bits_59;
  wire [85-1:0] padr_60;
  wire [50-1:0] padr_bits_61;
  assign padr_bits_61 = 0;
  wire [1-1:0] toSInt_62;
  assign toSInt_62 = 0;
  wire [35-1:0] toSInt_imm_63;
  wire [34-1:0] const_64;
  assign const_64 = 34'd78125000;
  assign toSInt_imm_63 = { toSInt_62, const_64 };
  assign padr_60 = { toSInt_imm_63, padr_bits_61 };
  assign padl_bits_59 = padr_60;
  assign padl_58 = { { 78{ padl_bits_59[84] } }, padl_bits_59 };
  assign truncval_16 = padl_17 * padl_58;
  assign truncR_15 = truncval_16[95:0];
  assign padl_bits_14 = truncR_15[95:79];
  wire [15-1:0] padl_bits_zero_65;
  assign padl_bits_zero_65 = 0;
  assign padl_13 = { padl_bits_zero_65, padl_bits_14 };
  assign truncR_12 = padl_13;
  assign padl_bits_11 = truncR_12[31:14];
  wire [14-1:0] padl_bits_zero_66;
  assign padl_bits_zero_66 = 0;
  assign padl_10 = { padl_bits_zero_66, padl_bits_11 };
  assign wait_time = padl_10;
  wire [35-1:0] padr_67;
  wire [23-1:0] padr_bits_68;
  assign padr_bits_68 = 0;
  wire [29-1:0] truncR_69;
  wire [29-1:0] padl_70;
  wire [28-1:0] padl_bits_71;
  wire [1-1:0] toSInt_72;
  assign toSInt_72 = 0;
  wire [28-1:0] toSInt_imm_73;
  wire [27-1:0] const_74;
  assign const_74 = 27'd55364812;
  assign toSInt_imm_73 = { toSInt_72, const_74 };
  assign padl_bits_71 = toSInt_imm_73;
  assign padl_70 = { { 1{ padl_bits_71[27] } }, padl_bits_71 };
  assign truncR_69 = padl_70;
  wire [12-1:0] truncR_shift_75;
  assign truncR_shift_75 = truncR_69 >>> 17;
  wire [12-1:0] truncR_imm_76;
  assign truncR_imm_76 = (truncR_69[28])? truncR_shift_75[11:0] : truncR_69[28:17];
  assign padr_67 = { truncR_imm_76, padr_bits_68 };
  wire [51-1:0] padr_77;
  wire [6-1:0] padr_bits_78;
  assign padr_bits_78 = 0;
  wire [46-1:0] truncval_79;
  wire [47-1:0] toUsInt_80;
  wire [47-1:0] padr_81;
  wire [1-1:0] padr_bits_82;
  assign padr_bits_82 = 0;
  wire [88-1:0] truncR_83;
  wire [97-1:0] truncval_84;
  wire [97-1:0] padl_85;
  wire [48-1:0] padl_bits_86;
  wire [48-1:0] padr_87;
  wire [33-1:0] padr_bits_88;
  assign padr_bits_88 = 0;
  assign padr_87 = { n, padr_bits_88 };
  assign padl_bits_86 = padr_87;
  assign padl_85 = { { 49{ padl_bits_86[47] } }, padl_bits_86 };
  wire [97-1:0] padl_89;
  wire [48-1:0] padl_bits_90;
  wire [48-1:0] padl_91;
  wire [45-1:0] padl_bits_92;
  wire [45-1:0] param_93;
  assign param_93 = n_to_tau;
  assign padl_bits_92 = param_93;
  assign padl_91 = { { 3{ padl_bits_92[44] } }, padl_bits_92 };
  assign padl_bits_90 = padl_91;
  assign padl_89 = { { 49{ padl_bits_90[47] } }, padl_bits_90 };
  assign truncval_84 = padl_85 * padl_89;
  wire [88-1:0] truncval_imm_94;
  assign truncval_imm_94 = { truncval_84[96], truncval_84[86:0] };
  assign truncR_83 = truncval_imm_94;
  wire [46-1:0] truncR_shift_95;
  assign truncR_shift_95 = truncR_83 >>> 42;
  wire [46-1:0] truncR_imm_96;
  assign truncR_imm_96 = (truncR_83[87])? truncR_shift_95[45:0] : truncR_83[87:42];
  assign padr_81 = { truncR_imm_96, padr_bits_82 };
  wire [88-1:0] truncR_97;
  wire [97-1:0] truncval_98;
  wire [97-1:0] padl_99;
  wire [48-1:0] padl_bits_100;
  wire [48-1:0] padr_101;
  wire [33-1:0] padr_bits_102;
  assign padr_bits_102 = 0;
  assign padr_101 = { p, padr_bits_102 };
  assign padl_bits_100 = padr_101;
  assign padl_99 = { { 49{ padl_bits_100[47] } }, padl_bits_100 };
  wire [97-1:0] padl_103;
  wire [48-1:0] padl_bits_104;
  wire [48-1:0] padl_105;
  wire [44-1:0] padl_bits_106;
  wire [1-1:0] toSInt_107;
  assign toSInt_107 = 0;
  wire [44-1:0] toSInt_imm_108;
  wire [43-1:0] param_109;
  assign param_109 = p_to_tau;
  assign toSInt_imm_108 = { toSInt_107, param_109 };
  assign padl_bits_106 = toSInt_imm_108;
  assign padl_105 = { { 4{ padl_bits_106[43] } }, padl_bits_106 };
  assign padl_bits_104 = padl_105;
  assign padl_103 = { { 49{ padl_bits_104[47] } }, padl_bits_104 };
  assign truncval_98 = padl_99 * padl_103;
  wire [88-1:0] truncval_imm_110;
  assign truncval_imm_110 = { truncval_98[96], truncval_98[86:0] };
  assign truncR_97 = truncval_imm_110;
  wire [47-1:0] truncR_shift_111;
  assign truncR_shift_111 = truncR_97 >>> 41;
  wire [47-1:0] truncR_imm_112;
  assign truncR_imm_112 = (truncR_97[87])? truncR_shift_111[46:0] : truncR_97[87:41];
  wire [47-1:0] padr_113;
  wire [4-1:0] padr_bits_114;
  assign padr_bits_114 = 0;
  wire [43-1:0] padl_115;
  wire [42-1:0] padl_bits_116;
  wire [1-1:0] toSInt_117;
  assign toSInt_117 = 0;
  wire [42-1:0] toSInt_imm_118;
  wire [41-1:0] param_119;
  assign param_119 = const_tau;
  assign toSInt_imm_118 = { toSInt_117, param_119 };
  assign padl_bits_116 = toSInt_imm_118;
  assign padl_115 = { { 1{ padl_bits_116[41] } }, padl_bits_116 };
  assign padr_113 = { padl_115, padr_bits_114 };
  assign toUsInt_80 = padr_81 + truncR_imm_112 + padr_113;
  assign truncval_79 = toUsInt_80[43:0];
  assign padr_77 = { truncval_79[44:0], padr_bits_78 };
  assign tau = padr_77;
  wire [36-1:0] padl_120;
  wire [13-1:0] padl_bits_121;
  wire [36-1:0] truncR_122;
  wire [60-1:0] truncR_123;
  wire [93-1:0] truncval_124;
  wire [93-1:0] padl_125;
  wire [46-1:0] padl_bits_126;
  wire [46-1:0] padl_127;
  wire [16-1:0] padl_bits_128;
  wire [16-1:0] neg_imm_129;
  wire [16-1:0] padr_130;
  wire [5-1:0] padr_bits_131;
  assign padr_bits_131 = 0;
  wire [12-1:0] truncval_132;
  wire [35-1:0] truncR_133;
  assign truncR_133 = o;
  wire [12-1:0] truncR_shift_134;
  assign truncR_shift_134 = truncR_133 >>> 23;
  wire [12-1:0] truncR_imm_135;
  assign truncR_imm_135 = (truncR_133[34])? truncR_shift_134[11:0] : truncR_133[34:23];
  assign truncval_132 = truncR_imm_135;
  wire [11-1:0] truncval_imm_136;
  assign truncval_imm_136 = { truncval_132[11], truncval_132[9:0] };
  assign padr_130 = { truncval_imm_136, padr_bits_131 };
  assign neg_imm_129 = -padr_130;
  assign padl_bits_128 = neg_imm_129;
  assign padl_127 = { { 30{ padl_bits_128[15] } }, padl_bits_128 };
  assign padl_bits_126 = padl_127;
  assign padl_125 = { { 47{ padl_bits_126[45] } }, padl_bits_126 };
  wire [93-1:0] padl_137;
  wire [46-1:0] padl_bits_138;
  wire [46-1:0] padr_139;
  wire [12-1:0] padr_bits_140;
  assign padr_bits_140 = 0;
  wire [1-1:0] toSInt_141;
  assign toSInt_141 = 0;
  wire [34-1:0] toSInt_imm_142;
  wire [51-1:0] truncval_143;
  assign truncval_143 = 52'd2251799813685248 / tau;
  assign toSInt_imm_142 = { toSInt_141, truncval_143[32:0] };
  assign padr_139 = { toSInt_imm_142, padr_bits_140 };
  assign padl_bits_138 = padr_139;
  assign padl_137 = { { 47{ padl_bits_138[45] } }, padl_bits_138 };
  assign truncval_124 = padl_125 * padl_137;
  wire [60-1:0] truncval_imm_144;
  assign truncval_imm_144 = { truncval_124[92], truncval_124[58:0] };
  assign truncR_123 = truncval_imm_144;
  wire [36-1:0] truncR_shift_145;
  assign truncR_shift_145 = truncR_123 >>> 24;
  wire [36-1:0] truncR_imm_146;
  assign truncR_imm_146 = (truncR_123[59])? truncR_shift_145[35:0] : truncR_123[59:24];
  assign truncR_122 = truncR_imm_146;
  wire [13-1:0] truncR_shift_147;
  assign truncR_shift_147 = truncR_122 >>> 23;
  wire [13-1:0] truncR_imm_148;
  assign truncR_imm_148 = (truncR_122[35])? truncR_shift_147[12:0] : truncR_122[35:23];
  assign padl_bits_121 = truncR_imm_148;
  assign padl_120 = { { 23{ padl_bits_121[12] } }, padl_bits_121 };
  assign dvdt = padl_120;
  wire [35-1:0] padr_149;
  wire [23-1:0] padr_bits_150;
  assign padr_bits_150 = 0;
  wire [19-1:0] truncR_151;
  wire [19-1:0] padl_152;
  wire [16-1:0] padl_bits_153;
  wire [31-1:0] truncR_154;
  wire [102-1:0] truncval_155;
  wire [102-1:0] padl_156;
  wire [62-1:0] padl_bits_157;
  wire [62-1:0] padl_158;
  wire [28-1:0] padl_bits_159;
  wire [28-1:0] const_160;
  assign const_160 = 28'd0;
  assign padl_bits_159 = const_160;
  assign padl_158 = { { 34{ padl_bits_159[27] } }, padl_bits_159 };
  assign padl_bits_157 = padl_158;
  assign padl_156 = { { 40{ padl_bits_157[61] } }, padl_bits_157 };
  wire [102-1:0] padl_161;
  wire [62-1:0] padl_bits_162;
  wire [62-1:0] padr_163;
  wire [26-1:0] padr_bits_164;
  assign padr_bits_164 = 0;
  assign padr_163 = { dvdt, padr_bits_164 };
  assign padl_bits_162 = padr_163;
  assign padl_161 = { { 40{ padl_bits_162[61] } }, padl_bits_162 };
  assign truncval_155 = padl_156 * padl_161;
  wire [31-1:0] truncval_imm_165;
  assign truncval_imm_165 = { truncval_155[101], truncval_155[29:0] };
  assign truncR_154 = truncval_imm_165;
  wire [16-1:0] truncR_shift_166;
  assign truncR_shift_166 = truncR_154 >>> 15;
  wire [16-1:0] truncR_imm_167;
  assign truncR_imm_167 = (truncR_154[30])? truncR_shift_166[15:0] : truncR_154[30:15];
  assign padl_bits_153 = truncR_imm_167;
  assign padl_152 = { { 3{ padl_bits_153[15] } }, padl_bits_153 };
  assign truncR_151 = padl_152;
  wire [12-1:0] truncR_shift_168;
  assign truncR_shift_168 = truncR_151 >>> 7;
  wire [12-1:0] truncR_imm_169;
  assign truncR_imm_169 = (truncR_151[18])? truncR_shift_168[11:0] : truncR_151[18:7];
  assign padr_149 = { truncR_imm_169, padr_bits_150 };
  wire [32-1:0] padl_170;
  wire [2-1:0] padl_bits_171;
  wire [13-1:0] truncR_172;
  wire [16-1:0] truncR_173;
  wire [93-1:0] truncR_174;
  wire [161-1:0] truncval_175;
  wire [161-1:0] padl_176;
  wire [84-1:0] padl_bits_177;
  wire [84-1:0] padl_178;
  wire [51-1:0] padl_bits_179;
  wire [98-1:0] truncR_180;
  wire [107-1:0] truncval_181;
  wire [107-1:0] padl_182;
  wire [53-1:0] padl_bits_183;
  wire [53-1:0] padr_184;
  wire [41-1:0] padr_bits_185;
  assign padr_bits_185 = 0;
  wire [15-1:0] truncR_186;
  assign truncR_186 = n;
  wire [12-1:0] truncR_shift_187;
  assign truncR_shift_187 = truncR_186 >>> 3;
  wire [12-1:0] truncR_imm_188;
  assign truncR_imm_188 = (truncR_186[14])? truncR_shift_187[11:0] : truncR_186[14:3];
  assign padr_184 = { truncR_imm_188, padr_bits_185 };
  assign padl_bits_183 = padr_184;
  assign padl_182 = { { 54{ padl_bits_183[52] } }, padl_bits_183 };
  wire [107-1:0] padl_189;
  wire [53-1:0] padl_bits_190;
  wire [53-1:0] padl_191;
  wire [50-1:0] padl_bits_192;
  wire [50-1:0] param_193;
  assign param_193 = n_to_response_time_lh;
  assign padl_bits_192 = param_193;
  assign padl_191 = { { 3{ padl_bits_192[49] } }, padl_bits_192 };
  assign padl_bits_190 = padl_191;
  assign padl_189 = { { 54{ padl_bits_190[52] } }, padl_bits_190 };
  assign truncval_181 = padl_182 * padl_189;
  wire [98-1:0] truncval_imm_194;
  assign truncval_imm_194 = { truncval_181[106], truncval_181[96:0] };
  assign truncR_180 = truncval_imm_194;
  wire [51-1:0] truncR_shift_195;
  assign truncR_shift_195 = truncR_180 >>> 47;
  wire [51-1:0] truncR_imm_196;
  assign truncR_imm_196 = (truncR_180[97])? truncR_shift_195[50:0] : truncR_180[97:47];
  wire [51-1:0] padr_197;
  wire [1-1:0] padr_bits_198;
  assign padr_bits_198 = 0;
  wire [94-1:0] truncR_199;
  wire [103-1:0] truncval_200;
  wire [103-1:0] padl_201;
  wire [51-1:0] padl_bits_202;
  wire [51-1:0] padr_203;
  wire [39-1:0] padr_bits_204;
  assign padr_bits_204 = 0;
  assign padr_203 = { p, padr_bits_204 };
  assign padl_bits_202 = padr_203;
  assign padl_201 = { { 52{ padl_bits_202[50] } }, padl_bits_202 };
  wire [103-1:0] padl_205;
  wire [51-1:0] padl_bits_206;
  wire [51-1:0] padl_207;
  wire [48-1:0] padl_bits_208;
  wire [48-1:0] param_209;
  assign param_209 = p_to_response_time_lh;
  assign padl_bits_208 = param_209;
  assign padl_207 = { { 3{ padl_bits_208[47] } }, padl_bits_208 };
  assign padl_bits_206 = padl_207;
  assign padl_205 = { { 52{ padl_bits_206[50] } }, padl_bits_206 };
  assign truncval_200 = padl_201 * padl_205;
  wire [94-1:0] truncval_imm_210;
  assign truncval_imm_210 = { truncval_200[102], truncval_200[92:0] };
  assign truncR_199 = truncval_imm_210;
  wire [50-1:0] truncR_shift_211;
  assign truncR_shift_211 = truncR_199 >>> 44;
  wire [50-1:0] truncR_imm_212;
  assign truncR_imm_212 = (truncR_199[93])? truncR_shift_211[49:0] : truncR_199[93:44];
  assign padr_197 = { truncR_imm_212, padr_bits_198 };
  wire [51-1:0] padr_213;
  wire [6-1:0] padr_bits_214;
  assign padr_bits_214 = 0;
  wire [45-1:0] padl_215;
  wire [44-1:0] padl_bits_216;
  wire [1-1:0] toSInt_217;
  assign toSInt_217 = 0;
  wire [44-1:0] toSInt_imm_218;
  wire [43-1:0] param_219;
  assign param_219 = const_response_time_lh;
  assign toSInt_imm_218 = { toSInt_217, param_219 };
  assign padl_bits_216 = toSInt_imm_218;
  assign padl_215 = { { 1{ padl_bits_216[43] } }, padl_bits_216 };
  assign padr_213 = { padl_215, padr_bits_214 };
  assign padl_bits_179 = truncR_imm_196 + padr_197 + padr_213;
  assign padl_178 = { { 33{ padl_bits_179[50] } }, padl_bits_179 };
  assign padl_bits_177 = padl_178;
  assign padl_176 = { { 77{ padl_bits_177[83] } }, padl_bits_177 };
  wire [161-1:0] padl_220;
  wire [84-1:0] padl_bits_221;
  wire [84-1:0] padr_222;
  wire [49-1:0] padr_bits_223;
  assign padr_bits_223 = 0;
  wire [1-1:0] toSInt_224;
  assign toSInt_224 = 0;
  wire [35-1:0] toSInt_imm_225;
  wire [34-1:0] const_226;
  assign const_226 = 34'd78125000;
  assign toSInt_imm_225 = { toSInt_224, const_226 };
  assign padr_222 = { toSInt_imm_225, padr_bits_223 };
  assign padl_bits_221 = padr_222;
  assign padl_220 = { { 77{ padl_bits_221[83] } }, padl_bits_221 };
  assign truncval_175 = padl_176 * padl_220;
  assign truncR_174 = truncval_175[92:0];
  assign truncR_173 = truncR_174[92:77];
  assign truncR_172 = truncR_173[15:3];
  assign padl_bits_171 = truncR_172[12:11];
  wire [30-1:0] padl_bits_zero_227;
  assign padl_bits_zero_227 = 0;
  assign padl_170 = { padl_bits_zero_227, padl_bits_171 };
  assign wait_time_lh = padl_170;
  wire [35-1:0] padr_228;
  wire [26-1:0] padr_bits_229;
  assign padr_bits_229 = 0;
  wire [31-1:0] truncR_230;
  wire [31-1:0] padl_231;
  wire [27-1:0] padl_bits_232;
  wire [1-1:0] toSInt_233;
  assign toSInt_233 = 0;
  wire [27-1:0] toSInt_imm_234;
  wire [26-1:0] const_235;
  assign const_235 = 26'd67108;
  assign toSInt_imm_234 = { toSInt_233, const_235 };
  assign padl_bits_232 = toSInt_imm_234;
  assign padl_231 = { { 4{ padl_bits_232[26] } }, padl_bits_232 };
  assign truncR_230 = padl_231;
  wire [9-1:0] truncR_shift_236;
  assign truncR_shift_236 = truncR_230 >>> 22;
  wire [9-1:0] truncR_imm_237;
  assign truncR_imm_237 = (truncR_230[30])? truncR_shift_236[8:0] : truncR_230[30:22];
  assign padr_228 = { truncR_imm_237, padr_bits_229 };
  wire [59-1:0] padr_238;
  wire [10-1:0] padr_bits_239;
  assign padr_bits_239 = 0;
  wire [50-1:0] truncval_240;
  wire [51-1:0] toUsInt_241;
  wire [51-1:0] padr_242;
  wire [3-1:0] padr_bits_243;
  assign padr_bits_243 = 0;
  wire [90-1:0] truncR_244;
  wire [99-1:0] truncval_245;
  wire [99-1:0] padl_246;
  wire [49-1:0] padl_bits_247;
  wire [49-1:0] padr_248;
  wire [37-1:0] padr_bits_249;
  assign padr_bits_249 = 0;
  wire [15-1:0] truncR_250;
  assign truncR_250 = n;
  wire [12-1:0] truncR_shift_251;
  assign truncR_shift_251 = truncR_250 >>> 3;
  wire [12-1:0] truncR_imm_252;
  assign truncR_imm_252 = (truncR_250[14])? truncR_shift_251[11:0] : truncR_250[14:3];
  assign padr_248 = { truncR_imm_252, padr_bits_249 };
  assign padl_bits_247 = padr_248;
  assign padl_246 = { { 50{ padl_bits_247[48] } }, padl_bits_247 };
  wire [99-1:0] padl_253;
  wire [49-1:0] padl_bits_254;
  wire [49-1:0] padl_255;
  wire [45-1:0] padl_bits_256;
  wire [1-1:0] toSInt_257;
  assign toSInt_257 = 0;
  wire [45-1:0] toSInt_imm_258;
  wire [44-1:0] param_259;
  assign param_259 = n_to_tau_lh;
  assign toSInt_imm_258 = { toSInt_257, param_259 };
  assign padl_bits_256 = toSInt_imm_258;
  assign padl_255 = { { 4{ padl_bits_256[44] } }, padl_bits_256 };
  assign padl_bits_254 = padl_255;
  assign padl_253 = { { 50{ padl_bits_254[48] } }, padl_bits_254 };
  assign truncval_245 = padl_246 * padl_253;
  wire [90-1:0] truncval_imm_260;
  assign truncval_imm_260 = { truncval_245[98], truncval_245[88:0] };
  assign truncR_244 = truncval_imm_260;
  wire [48-1:0] truncR_shift_261;
  assign truncR_shift_261 = truncR_244 >>> 42;
  wire [48-1:0] truncR_imm_262;
  assign truncR_imm_262 = (truncR_244[89])? truncR_shift_261[47:0] : truncR_244[89:42];
  assign padr_242 = { truncR_imm_262, padr_bits_243 };
  wire [96-1:0] truncR_263;
  wire [105-1:0] truncval_264;
  wire [105-1:0] padl_265;
  wire [52-1:0] padl_bits_266;
  wire [52-1:0] padr_267;
  wire [40-1:0] padr_bits_268;
  assign padr_bits_268 = 0;
  assign padr_267 = { p, padr_bits_268 };
  assign padl_bits_266 = padr_267;
  assign padl_265 = { { 53{ padl_bits_266[51] } }, padl_bits_266 };
  wire [105-1:0] padl_269;
  wire [52-1:0] padl_bits_270;
  wire [52-1:0] padl_271;
  wire [49-1:0] padl_bits_272;
  wire [49-1:0] param_273;
  assign param_273 = p_to_tau_lh;
  assign padl_bits_272 = param_273;
  assign padl_271 = { { 3{ padl_bits_272[48] } }, padl_bits_272 };
  assign padl_bits_270 = padl_271;
  assign padl_269 = { { 53{ padl_bits_270[51] } }, padl_bits_270 };
  assign truncval_264 = padl_265 * padl_269;
  wire [96-1:0] truncval_imm_274;
  assign truncval_imm_274 = { truncval_264[104], truncval_264[94:0] };
  assign truncR_263 = truncval_imm_274;
  wire [51-1:0] truncR_shift_275;
  assign truncR_shift_275 = truncR_263 >>> 45;
  wire [51-1:0] truncR_imm_276;
  assign truncR_imm_276 = (truncR_263[95])? truncR_shift_275[50:0] : truncR_263[95:45];
  wire [51-1:0] padr_277;
  wire [6-1:0] padr_bits_278;
  assign padr_bits_278 = 0;
  wire [45-1:0] padl_279;
  wire [44-1:0] padl_bits_280;
  wire [1-1:0] toSInt_281;
  assign toSInt_281 = 0;
  wire [44-1:0] toSInt_imm_282;
  wire [43-1:0] param_283;
  assign param_283 = const_tau_lh;
  assign toSInt_imm_282 = { toSInt_281, param_283 };
  assign padl_bits_280 = toSInt_imm_282;
  assign padl_279 = { { 1{ padl_bits_280[43] } }, padl_bits_280 };
  assign padr_277 = { padl_279, padr_bits_278 };
  assign toUsInt_241 = padr_242 + truncR_imm_276 + padr_277;
  assign truncval_240 = toUsInt_241[47:0];
  assign padr_238 = { truncval_240[48:0], padr_bits_239 };
  assign tau_lh = padr_238;
  wire [37-1:0] padl_284;
  wire [13-1:0] padl_bits_285;
  wire [37-1:0] truncR_286;
  wire [38-1:0] truncval_287;
  wire [98-1:0] truncR_288;
  wire [129-1:0] truncval_289;
  wire [129-1:0] padl_290;
  wire [64-1:0] padl_bits_291;
  wire [64-1:0] padl_292;
  wire [35-1:0] padl_bits_293;
  wire [35-1:0] padr_294;
  wire [6-1:0] padr_bits_295;
  assign padr_bits_295 = 0;
  wire [29-1:0] padl_296;
  wire [28-1:0] padl_bits_297;
  wire [1-1:0] toSInt_298;
  assign toSInt_298 = 0;
  wire [28-1:0] toSInt_imm_299;
  wire [27-1:0] const_300;
  assign const_300 = 27'd55364812;
  assign toSInt_imm_299 = { toSInt_298, const_300 };
  assign padl_bits_297 = toSInt_imm_299;
  assign padl_296 = { { 1{ padl_bits_297[27] } }, padl_bits_297 };
  assign padr_294 = { padl_296, padr_bits_295 };
  assign padl_bits_293 = padr_294 - o;
  assign padl_292 = { { 29{ padl_bits_293[34] } }, padl_bits_293 };
  assign padl_bits_291 = padl_292;
  assign padl_290 = { { 65{ padl_bits_291[63] } }, padl_bits_291 };
  wire [129-1:0] padl_301;
  wire [64-1:0] padl_bits_302;
  wire [64-1:0] padr_303;
  wire [30-1:0] padr_bits_304;
  assign padr_bits_304 = 0;
  wire [1-1:0] toSInt_305;
  assign toSInt_305 = 0;
  wire [34-1:0] toSInt_imm_306;
  wire [59-1:0] truncval_307;
  assign truncval_307 = 60'd576460752303423488 / tau_lh;
  assign toSInt_imm_306 = { toSInt_305, truncval_307[32:0] };
  assign padr_303 = { toSInt_imm_306, padr_bits_304 };
  assign padl_bits_302 = padr_303;
  assign padl_301 = { { 65{ padl_bits_302[63] } }, padl_bits_302 };
  assign truncval_289 = padl_290 * padl_301;
  wire [98-1:0] truncval_imm_308;
  assign truncval_imm_308 = { truncval_289[128], truncval_289[96:0] };
  assign truncR_288 = truncval_imm_308;
  wire [38-1:0] truncR_shift_309;
  assign truncR_shift_309 = truncR_288 >>> 60;
  wire [38-1:0] truncR_imm_310;
  assign truncR_imm_310 = (truncR_288[97])? truncR_shift_309[37:0] : truncR_288[97:60];
  assign truncval_287 = truncR_imm_310;
  wire [37-1:0] truncval_imm_311;
  assign truncval_imm_311 = { truncval_287[37], truncval_287[35:0] };
  assign truncR_286 = truncval_imm_311;
  wire [13-1:0] truncR_shift_312;
  assign truncR_shift_312 = truncR_286 >>> 24;
  wire [13-1:0] truncR_imm_313;
  assign truncR_imm_313 = (truncR_286[36])? truncR_shift_312[12:0] : truncR_286[36:24];
  assign padl_bits_285 = truncR_imm_313;
  assign padl_284 = { { 24{ padl_bits_285[12] } }, padl_bits_285 };
  assign dodt = padl_284;
  wire [35-1:0] padr_314;
  wire [17-1:0] padr_bits_315;
  assign padr_bits_315 = 0;
  wire [18-1:0] padl_316;
  wire [17-1:0] padl_bits_317;
  wire [32-1:0] truncR_318;
  wire [103-1:0] truncval_319;
  wire [103-1:0] padl_320;
  wire [63-1:0] padl_bits_321;
  wire [63-1:0] padl_322;
  wire [28-1:0] padl_bits_323;
  wire [28-1:0] const_324;
  assign const_324 = 28'd0;
  assign padl_bits_323 = const_324;
  assign padl_322 = { { 35{ padl_bits_323[27] } }, padl_bits_323 };
  assign padl_bits_321 = padl_322;
  assign padl_320 = { { 40{ padl_bits_321[62] } }, padl_bits_321 };
  wire [103-1:0] padl_325;
  wire [63-1:0] padl_bits_326;
  wire [63-1:0] padr_327;
  wire [26-1:0] padr_bits_328;
  assign padr_bits_328 = 0;
  assign padr_327 = { dodt, padr_bits_328 };
  assign padl_bits_326 = padr_327;
  assign padl_325 = { { 40{ padl_bits_326[62] } }, padl_bits_326 };
  assign truncval_319 = padl_320 * padl_325;
  wire [32-1:0] truncval_imm_329;
  assign truncval_imm_329 = { truncval_319[102], truncval_319[30:0] };
  assign truncR_318 = truncval_imm_329;
  wire [17-1:0] truncR_shift_330;
  assign truncR_shift_330 = truncR_318 >>> 15;
  wire [17-1:0] truncR_imm_331;
  assign truncR_imm_331 = (truncR_318[31])? truncR_shift_330[16:0] : truncR_318[31:15];
  assign padl_bits_317 = truncR_imm_331;
  assign padl_316 = { { 1{ padl_bits_317[16] } }, padl_bits_317 };
  assign padr_314 = { padl_316, padr_bits_315 };
  assign out = (fsm == 0)? o : o;

  always @(posedge clk) begin
    prev_sys_clk <= sys_clk;
  end

  localparam fsm_1 = 1;
  localparam fsm_2 = 2;
  localparam fsm_3 = 3;
  localparam fsm_4 = 4;

  always @(posedge clk) begin
    if(reset) begin
      fsm <= fsm_init;
    end else begin
      case(fsm)
        fsm_init: begin
          if(reset) begin
            o <= 35'd3543348019;
          end else begin
            o <= padr_0;
          end
          if(~prev_sys_clk & sys_clk & ((n > p) & (n <= 15'd16384))) begin
            fsm <= fsm_1;
          end 
        end
        fsm_1: begin
          if(reset) begin
            o <= 35'd3543348019;
          end else begin
            o <= padr_67;
          end
          if(state_cycle_counter > wait_time) begin
            state_cycle_counter <= 0;
          end else begin
            state_cycle_counter <= state_cycle_counter + 1;
          end
          if(state_cycle_counter > wait_time) begin
            fsm <= fsm_2;
          end 
        end
        fsm_2: begin
          if(reset) begin
            o <= 35'd3543348019;
          end else begin
            o <= o + padr_149;
          end
          if(prev_sys_clk & ~sys_clk) begin
            fsm <= fsm_3;
          end 
        end
        fsm_3: begin
          if(reset) begin
            o <= 35'd3543348019;
          end else begin
            o <= padr_228;
          end
          if(state_cycle_counter > wait_time_lh) begin
            state_cycle_counter <= 0;
          end else begin
            state_cycle_counter <= state_cycle_counter + 1;
          end
          if(state_cycle_counter > wait_time_lh) begin
            fsm <= fsm_4;
          end 
        end
        fsm_4: begin
          if(reset) begin
            o <= 35'd3543348019;
          end else begin
            o <= o + padr_314;
          end
          if((o > 35'd3532610600) & (o <= 35'd17179869184)) begin
            fsm <= fsm_init;
          end 
        end
      endcase
    end
  end


endmodule

