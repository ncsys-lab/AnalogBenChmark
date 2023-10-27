

module voltage_controlled_oscillator #
(
  parameter gain = 1024
)
(
  input clk,
  input reset,
  input [10-1:0] input_voltage_real,
  output [12-1:0] output_clock_real
);

  reg [12-1:0] x;
  reg [12-1:0] v;
  wire [9-1:0] dvdt;
  wire [9-1:0] dxdt;
  wire [29-1:0] truncR_0;
  wire [37-1:0] truncval_1;
  wire [37-1:0] padl_2;
  wire [18-1:0] padl_bits_3;
  wire [18-1:0] padr_4;
  wire [8-1:0] padr_bits_5;
  assign padr_bits_5 = 0;
  wire [20-1:0] truncR_6;
  wire [21-1:0] truncval_7;
  wire [21-1:0] padl_8;
  wire [10-1:0] padl_bits_9;
  assign padl_bits_9 = input_voltage_real;
  wire [11-1:0] padl_bits_zero_10;
  assign padl_bits_zero_10 = 0;
  assign padl_8 = { padl_bits_zero_10, padl_bits_9 };
  wire [21-1:0] padl_11;
  wire [10-1:0] padl_bits_12;
  assign padl_bits_12 = input_voltage_real;
  wire [11-1:0] padl_bits_zero_13;
  assign padl_bits_zero_13 = 0;
  assign padl_11 = { padl_bits_zero_13, padl_bits_12 };
  assign truncval_7 = padl_8 * padl_11;
  wire [20-1:0] truncval_imm_14;
  assign truncval_imm_14 = { truncval_7[20], truncval_7[18:0] };
  assign truncR_6 = truncval_imm_14;
  wire [10-1:0] truncR_shift_15;
  assign truncR_shift_15 = truncR_6 >>> 10;
  wire [10-1:0] truncR_imm_16;
  assign truncR_imm_16 = (truncR_6[19])? truncR_shift_15[9:0] : truncR_6[19:10];
  assign padr_4 = { truncR_imm_16, padr_bits_5 };
  assign padl_bits_3 = padr_4;
  assign padl_2 = { { 19{ padl_bits_3[17] } }, padl_bits_3 };
  wire [37-1:0] padl_17;
  wire [18-1:0] padl_bits_18;
  wire [18-1:0] padl_19;
  wire [17-1:0] padl_bits_20;
  wire [17-1:0] padr_21;
  wire [7-1:0] padr_bits_22;
  assign padr_bits_22 = 0;
  wire [10-1:0] neg_imm_23;
  wire [12-1:0] truncR_24;
  assign truncR_24 = x;
  wire [10-1:0] truncR_shift_25;
  assign truncR_shift_25 = truncR_24 >>> 2;
  wire [10-1:0] truncR_imm_26;
  assign truncR_imm_26 = (truncR_24[11])? truncR_shift_25[9:0] : truncR_24[11:2];
  assign neg_imm_23 = -truncR_imm_26;
  assign padr_21 = { neg_imm_23, padr_bits_22 };
  wire [17-1:0] padl_27;
  wire [16-1:0] padl_bits_28;
  wire [16-1:0] const_29;
  assign const_29 = -6553;
  assign padl_bits_28 = const_29;
  assign padl_27 = { { 1{ padl_bits_28[15] } }, padl_bits_28 };
  assign padl_bits_20 = padr_21 - padl_27;
  assign padl_19 = { { 1{ padl_bits_20[16] } }, padl_bits_20 };
  assign padl_bits_18 = padl_19;
  assign padl_17 = { { 19{ padl_bits_18[17] } }, padl_bits_18 };
  assign truncval_1 = padl_2 * padl_17;
  wire [29-1:0] truncval_imm_30;
  assign truncval_imm_30 = { truncval_1[36], truncval_1[27:0] };
  assign truncR_0 = truncval_imm_30;
  wire [9-1:0] truncR_shift_31;
  assign truncR_shift_31 = truncR_0 >>> 20;
  wire [9-1:0] truncR_imm_32;
  assign truncR_imm_32 = (truncR_0[28])? truncR_shift_31[8:0] : truncR_0[28:20];
  assign dvdt = truncR_imm_32;
  wire [12-1:0] truncR_33;
  assign truncR_33 = v;
  wire [9-1:0] truncR_shift_34;
  assign truncR_shift_34 = truncR_33 >>> 3;
  wire [9-1:0] truncR_imm_35;
  assign truncR_imm_35 = (truncR_33[11])? truncR_shift_34[8:0] : truncR_33[11:3];
  assign dxdt = truncR_imm_35;
  assign output_clock_real = x;
  wire [16-1:0] truncR_36;
  wire [16-1:0] padl_37;
  wire [13-1:0] padl_bits_38;
  wire [40-1:0] truncR_39;
  wire [49-1:0] truncval_40;
  wire [49-1:0] padl_41;
  wire [24-1:0] padl_bits_42;
  wire [24-1:0] padl_43;
  wire [20-1:0] padl_bits_44;
  wire [1-1:0] toSInt_45;
  assign toSInt_45 = 0;
  wire [20-1:0] toSInt_imm_46;
  wire [19-1:0] const_47;
  assign const_47 = 5242;
  assign toSInt_imm_46 = { toSInt_45, const_47 };
  assign padl_bits_44 = toSInt_imm_46;
  assign padl_43 = { { 4{ padl_bits_44[19] } }, padl_bits_44 };
  assign padl_bits_42 = padl_43;
  assign padl_41 = { { 25{ padl_bits_42[23] } }, padl_bits_42 };
  wire [49-1:0] padl_48;
  wire [24-1:0] padl_bits_49;
  wire [24-1:0] padr_50;
  wire [15-1:0] padr_bits_51;
  assign padr_bits_51 = 0;
  assign padr_50 = { dvdt, padr_bits_51 };
  assign padl_bits_49 = padr_50;
  assign padl_48 = { { 25{ padl_bits_49[23] } }, padl_bits_49 };
  assign truncval_40 = padl_41 * padl_48;
  wire [40-1:0] truncval_imm_52;
  assign truncval_imm_52 = { truncval_40[48], truncval_40[38:0] };
  assign truncR_39 = truncval_imm_52;
  wire [13-1:0] truncR_shift_53;
  assign truncR_shift_53 = truncR_39 >>> 27;
  wire [13-1:0] truncR_imm_54;
  assign truncR_imm_54 = (truncR_39[39])? truncR_shift_53[12:0] : truncR_39[39:27];
  assign padl_bits_38 = truncR_imm_54;
  assign padl_37 = { { 3{ padl_bits_38[12] } }, padl_bits_38 };
  assign truncR_36 = padl_37;
  wire [12-1:0] truncR_shift_55;
  assign truncR_shift_55 = truncR_36 >>> 4;
  wire [12-1:0] truncR_imm_56;
  assign truncR_imm_56 = (truncR_36[15])? truncR_shift_55[11:0] : truncR_36[15:4];
  wire [16-1:0] truncR_57;
  wire [16-1:0] padl_58;
  wire [13-1:0] padl_bits_59;
  wire [40-1:0] truncR_60;
  wire [49-1:0] truncval_61;
  wire [49-1:0] padl_62;
  wire [24-1:0] padl_bits_63;
  wire [24-1:0] padl_64;
  wire [20-1:0] padl_bits_65;
  wire [1-1:0] toSInt_66;
  assign toSInt_66 = 0;
  wire [20-1:0] toSInt_imm_67;
  wire [19-1:0] const_68;
  assign const_68 = 5242;
  assign toSInt_imm_67 = { toSInt_66, const_68 };
  assign padl_bits_65 = toSInt_imm_67;
  assign padl_64 = { { 4{ padl_bits_65[19] } }, padl_bits_65 };
  assign padl_bits_63 = padl_64;
  assign padl_62 = { { 25{ padl_bits_63[23] } }, padl_bits_63 };
  wire [49-1:0] padl_69;
  wire [24-1:0] padl_bits_70;
  wire [24-1:0] padr_71;
  wire [15-1:0] padr_bits_72;
  assign padr_bits_72 = 0;
  assign padr_71 = { dxdt, padr_bits_72 };
  assign padl_bits_70 = padr_71;
  assign padl_69 = { { 25{ padl_bits_70[23] } }, padl_bits_70 };
  assign truncval_61 = padl_62 * padl_69;
  wire [40-1:0] truncval_imm_73;
  assign truncval_imm_73 = { truncval_61[48], truncval_61[38:0] };
  assign truncR_60 = truncval_imm_73;
  wire [13-1:0] truncR_shift_74;
  assign truncR_shift_74 = truncR_60 >>> 27;
  wire [13-1:0] truncR_imm_75;
  assign truncR_imm_75 = (truncR_60[39])? truncR_shift_74[12:0] : truncR_60[39:27];
  assign padl_bits_59 = truncR_imm_75;
  assign padl_58 = { { 3{ padl_bits_59[12] } }, padl_bits_59 };
  assign truncR_57 = padl_58;
  wire [12-1:0] truncR_shift_76;
  assign truncR_shift_76 = truncR_57 >>> 4;
  wire [12-1:0] truncR_imm_77;
  assign truncR_imm_77 = (truncR_57[15])? truncR_shift_76[11:0] : truncR_57[15:4];

  always @(posedge clk) begin
    if(reset) begin
      v <= 0;
    end else begin
      v <= v + truncR_imm_56;
    end
    if(reset) begin
      x <= 0;
    end else begin
      x <= x + truncR_imm_77;
    end
  end


endmodule

