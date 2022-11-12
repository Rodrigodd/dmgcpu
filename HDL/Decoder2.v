`timescale 1ns/1ns

`define delay 0

// Here we do not use GekkioNames on purpose, so that we can make cross checks without engagement.

module Decoder2( CLK2, d, w, SeqOut_2, IR7 );

	input CLK2;
	input [106:0] d;
	output [40:0] w;
	input SeqOut_2;
	input IR7;

	// Automagically generated by MakeNorTree py 
 
	assign #`delay w[0] = ~(CLK2 ? ~((d[4]|d[5]|d[6]|d[7])) : 1'b1);
	assign #`delay w[1] = ~(CLK2 ? ~((d[0]|d[1]|w[27])) : 1'b1);
	assign #`delay w[4] = ~(CLK2 ? ~((d[0]|d[28])) : 1'b1);
	assign #`delay w[5] = ~(CLK2 ? ~((d[2]|d[26])) : 1'b1);
	assign #`delay w[6] = ~(CLK2 ? ~((d[0]|d[12]|d[13]|d[24]|d[28]|d[30]|d[32]|d[38]|d[47]|d[50]|d[56]|d[60]|d[66]|d[68]|d[70]|d[73]|d[75]|d[92]|d[93]|d[97])) : 1'b1);
	assign #`delay w[9] = ~(CLK2 ? ~((d[21]|d[22])) : 1'b1);
	assign #`delay w[10] = ~(CLK2 ? ~((d[23]|d[24])) : 1'b1);
	assign #`delay w[11] = ~(CLK2 ? ~((d[32]|d[59]|d[0]|d[1]|d[2]|d[9]|d[10]|d[12]|d[13]|d[15]|d[16]|d[17]|d[18]|d[20]|d[22]|d[23]|d[24]|d[26]|d[28]|d[29]|d[30]|d[31]|d[33]|d[34]|d[38]|d[40]|d[43]|d[44]|d[46]|d[47]|d[50]|d[51]|d[52]|d[55]|d[56]|d[57]|d[58]|d[60]|d[61]|d[63]|d[64]|d[65]|d[66]|d[67]|d[68]|d[69]|d[70]|d[71]|d[72]|d[73]|d[75]|d[78]|d[79]|d[80]|d[81]|d[82]|d[86]|d[87]|d[88]|d[89]|d[90]|d[91]|d[92]|d[93]|d[94]|d[95]|d[96]|d[97]|d[99]|d[100]|d[101]|d[102]|d[103]|d[104]|d[105])) : 1'b1);
	assign #`delay w[13] = ~(CLK2 ? ~((d[28]|d[29])) : 1'b1);
	assign #`delay w[14] = ~(CLK2 ? ~((d[30]|d[32])) : 1'b1);
	assign #`delay w[16] = ~(CLK2 ? ~((d[36]|d[37])) : 1'b1);
	assign #`delay w[17] = ~(CLK2 ? ~((d[32]|d[59])) : 1'b1);
	assign #`delay w[18] = ~(CLK2 ? ~((d[1]|d[9]|d[10]|d[15]|d[20]|d[29]|d[31]|d[33]|d[43]|d[44]|d[51]|d[52]|d[57]|d[59]|d[61]|d[63]|d[65]|d[67]|d[69]|d[71]|d[72]|d[79]|d[80]|d[82]|d[86]|d[87]|d[90]|d[91]|d[95]|d[104]|d[105])) : 1'b1);
	assign #`delay w[20] = ~(CLK2 ? ~((d[0]|d[1]|d[6]|d[9]|d[11]|d[13]|d[15]|d[20]|d[21]|d[24]|d[28]|d[29]|d[30]|d[31]|d[32]|d[35]|d[36]|d[37]|d[39]|d[43]|d[45]|d[47]|d[50]|d[51]|d[56]|d[57]|d[60]|d[61]|d[62]|d[63]|d[65]|d[66]|d[68]|d[69]|d[70]|d[72]|d[74]|d[76]|d[82]|d[83]|d[86]|d[92]|d[93]|d[95]|d[97]|d[104])) : 1'b1);
	assign #`delay w[22] = ~(CLK2 ? ~((d[24]|d[33]|d[47]|d[56]|d[57]|d[62]|d[68]|d[69]|d[70]|d[81]|d[90]|d[95]|d[97])) : 1'b1);
	assign #`delay w[23] = ~(CLK2 ? ~((d[53]|d[54])) : 1'b1);
	assign #`delay w[24] = ~(CLK2 ? ~((d[55]|d[56])) : 1'b1);
	assign #`delay w[25] = ~(CLK2 ? ~((d[2]|d[9]|d[10]|d[15]|d[16]|d[17]|d[18]|d[20]|d[22]|d[23]|d[26]|d[31]|d[34]|d[40]|d[43]|d[44]|d[46]|d[55]|d[58]|d[61]|d[63]|d[64]|d[65]|d[67]|d[72]|d[77]|d[78]|d[86]|d[87]|d[88]|d[89]|d[91]|d[94]|d[96]|d[99]|d[100]|d[101]|d[102]|d[104]|d[105])) : 1'b1);
	assign #`delay w[26] = ~(CLK2 ? ~((d[2]|d[16]|d[17]|d[18]|d[22]|d[23]|d[26]|d[34]|d[40]|d[46]|d[55]|d[58]|d[64]|d[78]|d[81]|d[88]|d[89]|d[94]|d[96]|d[99]|d[100]|d[101]|d[102]|d[103])) : 1'b1);
	assign #`delay w[27] = ~(CLK2 ? ~((d[60]|d[66])) : 1'b1);
	assign #`delay w[28] = ~(CLK2 ? ~((d[12]|d[73]|d[75])) : 1'b1);
	assign #`delay w[29] = ~(CLK2 ? ~((d[30]|d[71])) : 1'b1);
	assign #`delay w[30] = ~(CLK2 ? ~((d[11]|d[12]|d[13]|d[38]|d[39]|d[50]|d[51]|d[52]|d[73]|d[74]|d[75]|d[76]|d[79]|d[80]|d[82]|d[92]|d[93])) : 1'b1);
	assign #`delay w[31] = ~(CLK2 ? ~((d[2]|d[9]|d[10]|d[15]|d[16]|d[17]|d[18]|d[20]|d[22]|d[23]|d[26]|d[31]|d[34]|d[37]|d[40]|d[43]|d[44]|d[46]|d[51]|d[52]|d[55]|d[58]|d[60]|d[61]|d[63]|d[64]|d[65]|d[67]|d[72]|d[78]|d[79]|d[80]|d[81]|d[82]|d[84]|d[86]|d[87]|d[88]|d[89]|d[91]|d[94]|d[96]|d[99]|d[101]|d[102]|d[103]|d[104]|d[105])) : 1'b1);
	assign #`delay w[32] = ~(CLK2 ? ~((d[0]|d[12]|d[13]|d[24]|d[28]|d[30]|d[32]|d[33]|d[36]|d[37]|d[45]|d[47]|d[50]|d[56]|d[59]|d[62]|d[66]|d[68]|d[70]|d[71]|d[75]|d[76]|d[77]|d[83]|d[90]|d[91]|d[92]|d[93]|d[97])) : 1'b1);
	assign #`delay w[33] = ~(CLK2 ? ~((d[0]|d[1]|d[10]|d[11]|d[13]|d[19]|d[21]|d[24]|d[28]|d[30]|d[32]|d[33]|d[36]|d[37]|d[38]|d[44]|d[45]|d[47]|d[50]|d[52]|d[53]|d[54]|d[56]|d[59]|d[60]|d[62]|d[66]|d[67]|d[68]|d[70]|d[71]|d[73]|d[75]|d[79]|d[80]|d[82]|d[83]|d[87]|d[90]|d[91]|d[92]|d[93]|d[97]|d[105])) : 1'b1);
	assign #`delay w[34] = ~(CLK2 ? ~((d[13]|d[92]|d[93])) : 1'b1);
	assign #`delay w[35] = ~(CLK2 ? ~((d[11]|d[12]|d[36]|d[38]|d[39]|d[73]|d[74]|d[75]|d[76]|d[77]|d[85])) : 1'b1);
	assign #`delay w[36] = ~(CLK2 ? ~((d[13]|d[45]|d[83])) : 1'b1);
	assign #`delay w[38] = ~(CLK2 ? ~((d[2]|d[13]|d[16]|d[17]|d[22]|d[23]|d[26]|d[28]|d[29]|d[34]|d[35]|d[36]|d[37]|d[38]|d[40]|d[45]|d[46]|d[50]|d[53]|d[54]|d[55]|d[58]|d[62]|d[68]|d[70]|d[78]|d[81]|d[88]|d[89]|d[92]|d[93]|d[94]|d[96]|d[97]|d[99]|d[100]|d[101])) : 1'b1);

	// Does not use NOR tree

	assign w[2] = d[103];
	assign w[3] = d[3];
	assign w[7] = ~IR7;			// Not used
	assign w[8] = d[19];
	assign w[12] = d[27];
	assign w[15] = d[35];
	assign w[19] = d[46];
	assign w[21] = d[50];
	assign w[37] = d[98];
	assign w[39] = ~SeqOut_2;
	assign w[40] = w[18] & w[39];

endmodule // Decoder2
