`timescale 1ns/1ns

// Here we do not use GekkioNames on purpose, so that we can make cross checks without engagement.

module Decoder1 (CLK2, a, d);

	input CLK2;
	input [25:0] a;
	output [106:0] d;

	assign d[0] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[13]&a[14]&a[17]&a[18]&a[20]&a[23]&a[24]) : 1'b1);
	assign d[1] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[13]&a[14]&a[17]&a[18]&a[20]&a[23]&a[24]) : 1'b1);
	assign d[2] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[13]&a[14]&a[17]&a[18]&a[20]&a[23]&a[25]) : 1'b1);
	assign d[3] = ~(CLK2 ? ~(a[0]&a[2]&((a[5]&a[6])|(a[5]&a[7]&a[15]&a[17]&a[18]))) : 1'b1);
	assign d[4] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&a[14]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[5] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&a[15]&a[16]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[6] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&a[14]&a[16]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[7] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[9]&a[14]&a[16]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[8] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[12]&a[14]&a[18]) : 1'b1);
	assign d[9] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[13]&a[15]&a[16])|(a[15]&a[16]&a[18]))&a[20]&a[22]&a[24]) : 1'b1);
	assign d[10] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[13]&a[15]&a[16])|(a[15]&a[16]&a[18]))&a[20]&a[22]&a[25]) : 1'b1);
	assign d[11] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[13]&a[15]&a[16])|(a[15]&a[16]&a[18]))&a[20]&a[23]&a[24]) : 1'b1);
	assign d[12] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[13]&a[15]&a[16])|(a[15]&a[16]&a[18]))&a[20]&a[23]&a[25]) : 1'b1);
	assign d[13] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[13]&a[15]&a[16])|(a[15]&a[16]&a[18]))&a[21]&a[22]&a[24]) : 1'b1);
	assign d[14] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[15]&a[17]&a[18]) : 1'b1);
	assign d[15] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[15]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[16] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&((a[13])|(a[10])|(a[8]))&a[15]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[17] = ~(CLK2 ? ~(a[0]&a[2]&a[21]&a[23]&a[24]) : 1'b1);
	assign d[18] = ~(CLK2 ? ~(a[2]&a[21]&a[23]&a[25]) : 1'b1);
	assign d[19] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&((a[9]&a[14]&a[16]&a[18])|(a[8]&a[11]&a[13]&a[14]&a[16]&a[18]))&a[22]&a[25]) : 1'b1);
	assign d[20] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&((a[9]&a[14]&a[16]&a[18])|(a[8]&a[11]&a[13]&a[14]&a[16]&a[18]))&a[22]&a[24]) : 1'b1);
	assign d[21] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[23]&a[24]) : 1'b1);
	assign d[22] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[13]&a[14]&a[16]&a[18]&a[23]&a[24]) : 1'b1);
	assign d[23] = ~(CLK2 ? ~(a[0]&a[3]&a[5]&a[6]&((a[14])|(a[16])|(a[19]))&a[22]&a[24]) : 1'b1);
	assign d[24] = ~(CLK2 ? ~(a[0]&a[3]&a[5]&a[6]&a[15]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[25] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[8]&a[15]&a[17]&a[19]) : 1'b1);
	assign d[26] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[13]&a[14]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[27] = ~(CLK2 ? ~(a[0]&a[3]&a[4]&a[7]) : 1'b1);
	assign d[28] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[12]&a[14]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[29] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[13]&a[14]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[30] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[12]&a[14]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[31] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[12]&a[14]&a[16]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[32] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[12]&a[14]&a[16]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[33] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&((a[7]&a[8])|(a[7]&a[10])|(a[7]&a[13]))&a[15]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[34] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[15]&a[17]&a[19]&a[20]) : 1'b1);
	assign d[35] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[13]&a[14]&a[16]&a[19]&a[24]) : 1'b1);
	assign d[36] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[13]&a[14]&a[17]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[37] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[12]&a[14]&a[17]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[38] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[12]&a[15]&a[16]&a[19]&a[22]&a[25]) : 1'b1);
	assign d[39] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[12]&a[15]&a[16]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[40] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[7]&((a[8])|(a[10])|(a[13]))&((a[19])|(a[16])|(a[14]))&a[20]) : 1'b1);
	assign d[41] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[7]) : 1'b1);
	assign d[42] = ~(CLK2 ? ~(a[0]&a[3]&a[4]&a[6]) : 1'b1);
	assign d[43] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[12]&a[14]&a[17])|(a[14]&a[17]&a[18]))&a[22]&a[24]) : 1'b1);
	assign d[44] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[12]&a[14]&a[17])|(a[14]&a[17]&a[18]))&a[22]&a[25]) : 1'b1);
	assign d[45] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[10]&a[12]&a[14]&a[17])|(a[14]&a[17]&a[18]))&a[23]&a[24]) : 1'b1);
	assign d[46] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[13]&a[14]&a[16]&a[19]&a[22]&a[25]) : 1'b1);
	assign d[47] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[9]&a[11]&a[12]&a[15]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[48] = ~(CLK2 ? ~(a[24]&a[25]) : 1'b1);
	assign d[49] = ~(CLK2 ? ~(a[24]&a[25]) : 1'b1);
	assign d[50] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[12]&a[15]&a[16]&a[19]&a[23]&a[24]) : 1'b1);
	assign d[51] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[12]&a[14]&a[16]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[52] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[12]&a[14]&a[16]&a[19]&a[22]&a[25]) : 1'b1);
	assign d[53] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[22]&a[25]) : 1'b1);
	assign d[54] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[13]&a[14]&a[16]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[55] = ~(CLK2 ? ~(a[0]&a[3]&a[5]&a[7]&((a[14])|(a[16])|(a[19]))&a[22]&a[24]) : 1'b1);
	assign d[56] = ~(CLK2 ? ~(a[0]&a[3]&a[5]&a[7]&a[15]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[57] = ~(CLK2 ? ~(a[0]&a[3]&a[5]&a[15]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[58] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[12]&a[14]&a[16]&a[19]&a[23]&a[24]) : 1'b1);
	assign d[59] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[12]&a[14]&a[16]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[60] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[8]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[23]&a[24]) : 1'b1);
	assign d[61] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[8]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[22]&a[24]) : 1'b1);
	assign d[62] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[13]&a[14]&a[16]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[63] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[22]&a[24]) : 1'b1);
	assign d[64] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[23]&a[25]) : 1'b1);
	assign d[65] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[13]&a[14]&a[16]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[66] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[8]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[23]&a[25]) : 1'b1);
	assign d[67] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[8]&a[10]&a[13]&a[14]&a[16]&a[18]&a[20]&a[22]&a[25]) : 1'b1);
	assign d[68] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[7]&a[9]&a[11]&a[12]&((a[19])|(a[16])|(a[14]))&a[22]&a[24]) : 1'b1);
	assign d[69] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[9]&a[11]&a[12]&a[15]&a[16]&a[22]&a[24]) : 1'b1);
	assign d[70] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[9]&a[11]&a[12]&a[15]&a[16]&a[22]&a[25]) : 1'b1);
	assign d[71] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[12]&a[14]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[72] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[12]&a[14]&a[16]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[73] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[15]&a[17]&a[19]&a[22]&a[25]) : 1'b1);
	assign d[74] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[15]&a[17]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[75] = ~(CLK2 ? ~(a[1]&a[2]&a[21]&a[22]&a[25]) : 1'b1);
	assign d[76] = ~(CLK2 ? ~(a[1]&a[2]&a[21]&a[22]&a[24]) : 1'b1);
	assign d[77] = ~(CLK2 ? ~(a[1]&a[2]&a[20]&a[22]&a[24]) : 1'b1);
	assign d[78] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[6]&((a[16])|(a[14])|(a[19]))&a[20]) : 1'b1);
	assign d[79] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&a[13]&a[14]&a[16]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[80] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&a[14]&a[16]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[81] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[10]&a[13]&a[14]&a[16]&a[19]&a[20]) : 1'b1);
	assign d[82] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[13]&a[14]&a[16])|(a[14]&a[16]&a[18]))&a[20]&a[23]&a[24]) : 1'b1);
	assign d[83] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&((a[13]&a[14]&a[16])|(a[14]&a[16]&a[18]))&a[20]&a[23]&a[25]) : 1'b1);
	assign d[84] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[9]&a[10]&a[14]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[85] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[9]&a[11]&a[14]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[86] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[12]&a[14]&a[16]&a[19]&a[22]&a[24]) : 1'b1);
	assign d[87] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[12]&a[14]&a[16]&a[19]&a[22]&a[25]) : 1'b1);
	assign d[88] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[12]&a[14]&a[16]&a[19]&a[23]&a[24]) : 1'b1);
	assign d[89] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&((a[13])|(a[10])|(a[8]))&a[15]&a[16]&a[20]) : 1'b1);
	assign d[90] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[6]&a[15]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[91] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[15]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[92] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[15]&a[17]&a[19]&a[23]&a[24]) : 1'b1);
	assign d[93] = ~(CLK2 ? ~(a[1]&a[2]&a[21]&a[23]&a[24]) : 1'b1);
	assign d[94] = ~(CLK2 ? ~(a[0]&a[3]&((a[19])|(a[14])|(a[16]))&a[20]) : 1'b1);
	assign d[95] = ~(CLK2 ? ~(a[0]&a[3]&a[15]&a[17]&a[18]&a[22]&a[24]) : 1'b1);
	assign d[96] = ~(CLK2 ? ~(a[0]&a[3]&a[4]&a[7]&a[15]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[97] = ~(CLK2 ? ~(a[0]&a[3]&a[6]&a[15]&a[17]&a[18]&a[22]&a[25]) : 1'b1);
	assign d[98] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[15]&a[16]) : 1'b1);
	assign d[99] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[11]&a[14]&a[17]&a[19]&a[20]) : 1'b1);
	assign d[100] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[7]&a[9]&a[11]&a[12]&a[15]&a[17]&a[18]&a[20]) : 1'b1);
	assign d[101] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&a[8]&a[12]&a[14]&a[16]&a[18]&a[20]) : 1'b1);
	assign d[102] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[8]&a[10]&a[13]&a[14]&a[17]&a[19]&a[20]) : 1'b1);
	assign d[103] = ~(CLK2 ? ~(a[0]&a[2]&a[4]&a[6]&((a[8]&a[11]&a[13]&a[14]&a[16]&a[18])|(a[9]&a[14]&a[16]&a[18]))&a[23]&a[24]) : 1'b1);
	assign d[104] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[13]&a[14]&a[17]&a[18]&a[20]&a[22]&a[24]) : 1'b1);
	assign d[105] = ~(CLK2 ? ~(a[0]&a[2]&a[5]&a[7]&a[9]&a[13]&a[14]&a[17]&a[18]&a[20]&a[22]&a[25]) : 1'b1);
	assign d[106] = ~(CLK2 ? ~(a[24]&a[25]) : 1'b1);

endmodule // Decoder1
