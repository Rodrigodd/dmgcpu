
module ALU ( CLK2, CLK5, CLK6, CLK7, DV, Res, AllZeros, TTB3, d, w, x, bc, alu, bq4, bq5, bq7, ALU_to_bot, ALU_to_Thingy, ALU_L1, ALU_L2, ALU_L4, ALU_Out1, IR, nIR );

	input CLK2;
	input CLK5;
	input CLK6;
	input CLK7;

	input [7:0] DV;
	output [7:0] Res;
	input AllZeros;
	input TTB3;
	input [106:0] d;
	input [40:0] w;
	input [68:0] x;
	output [5:0] bc;
	input [7:0] alu;
	input bq4;
	input bq5;
	input bq7;
	output ALU_to_bot;
	output ALU_to_Thingy;
	input ALU_L1;
	input ALU_L2;
	input ALU_L4;
	output ALU_Out1;
	input [7:0] IR;
	input [5:0] nIR;

	// Internal wires

	wire [7:0] e;		// module2 e in
	wire [7:0] f;		// module2 f out
	wire [7:0] ca; 		// comb1-3 out
	wire [7:0] bx;		// module2 x out
	wire [7:0] bm;		// module2 m out
	wire [7:0] bh;		// module2 h out
	wire [7:0] bw;		// module2 w out
	wire [7:0] ao; 		// Christmas tree ands outputs to module6
	wire [7:0] na; 		// Christmas tree nots outputs to module6
	wire [7:0] q; 		// Christmas trees outputs (0-3: left, 4-7: right)
	wire [5:0] nbc; 	// #bc
	wire [13:0] az;		// LargeComb1 results (non-dynamic)

	wire ALU_L0;
	wire ALU_L3;
	wire ALU_L5;

	assign ALU_L0 = ~ALU_to_Thingy;

	assign ao = bh & bx; 		// ands

	// Automagically generated by MakeNandTree py 
 
	assign az[0] = ~((alu[0]) | (w[24]&nIR[3]&nIR[4]&nIR[5]) | (w[10]&IR[5]) | (w[10]&IR[4]) | (w[10]&IR[3]));
	assign az[1] = ~((nIR[0]&w[37]&ALU_L5) | (x[10]&ALU_L5) | (ALU_L3&x[12]) | (w[12]) | (x[26]) | (x[19]) | (ALU_L1&d[58]));
	assign az[2] = ~((f[0]&x[1]) | (ALU_L2&d[58]) | (nbc[1]&IR[3]&x[21]) | (x[21]&nIR[3]) | (x[10]&ALU_to_Thingy) | (nbc[2]&ALU_to_Thingy&x[22]) | (bc[1]&x[22]) | (bc[1]&x[26]) | (x[0]&f[7]) | (ALU_L0&x[11]));
	assign az[3] = ~((alu[1]) | (w[24]&IR[3]&nIR[4]&nIR[5]) | (w[10]&IR[5]) | (w[10]&IR[4]) | (w[10]&nIR[3]) | (x[22]&bc[5]) | (x[22]&nbc[2]&bq4));
	assign az[4] = ~((alu[2]) | (x[22]&bq4&nbc[2]) | (x[22]&bc[5]&nbc[2]) | (w[24]&nIR[3]&IR[4]&nIR[5]) | (w[10]&IR[5]) | (w[10]&nIR[4]) | (w[10]&IR[3]));
	assign az[5] = ~((alu[3]) | (w[24]&IR[3]&IR[4]&nIR[5]) | (w[10]&nIR[3]) | (w[10]&nIR[4]) | (w[10]&IR[5]) | (x[22]&bc[5]&bc[2]));
	assign az[6] = ~((alu[4]) | (x[22]&bc[5]&bc[2]) | (w[24]&nIR[3]&nIR[4]&IR[5]) | (w[10]&IR[3]) | (w[10]&IR[4]) | (w[10]&nIR[5]));
	assign az[7] = ~((bc[2]&x[22]) | (x[12]) | (x[26]) | (d[58]&ALU_L4));
	assign az[8] = ~((alu[5]) | (w[24]&IR[3]&nIR[4]&IR[5]) | (w[10]&nIR[3]) | (w[10]&IR[4]) | (w[10]&nIR[5]) | (x[22]&nbc[5]&bc[1]&bc[2]) | (x[22]&bc[5]&nbc[1]&bc[2]) | (x[22]&bq5&nbc[2]) | (x[22]&bc[1]&nbc[2]) | (x[22]&bq7&bq4&nbc[2]));
	assign az[9] = ~((alu[6]) | (w[24]&nIR[3]&IR[4]&IR[5]) | (w[10]&IR[3]) | (w[10]&nIR[4]) | (w[10]&nIR[5]) | (x[22]&bc[5]&nbc[1]&bc[2]) | (x[22]&bq7&bq4&nbc[2]) | (x[22]&bc[1]&nbc[2]) | (x[22]&bq5&nbc[2]));
	assign az[10] = ~((alu[7]) | (w[24]&IR[3]&IR[4]&IR[5]) | (w[10]&nIR[3]) | (w[10]&nIR[4]) | (w[10]&nIR[5]) | (x[22]&bc[5]&bc[2]) | (x[22]&bc[1]&bc[2]));
	assign az[11] = ~((w[0]&nIR[3]&IR[4]&bc[1]) | (w[0]&IR[3]&IR[4]&nbc[1]) | (w[0]&IR[3]&nIR[4]&nbc[3]) | (w[0]&nIR[3]&nIR[4]&bc[3]));
	assign az[12] = ~((f[0]&w[12]&nIR[3]&nIR[4]&nIR[5]) | (f[1]&w[12]&IR[3]&nIR[4]&nIR[5]) | (f[2]&w[12]&nIR[3]&IR[4]&nIR[5]) | (f[3]&w[12]&IR[3]&IR[4]&nIR[5]) | (f[4]&w[12]&nIR[3]&nIR[4]&IR[5]) | (f[5]&w[12]&IR[3]&nIR[4]&IR[5]) | (f[6]&w[12]&nIR[3]&IR[4]&IR[5]) | (f[7]&w[12]&IR[3]&IR[4]&IR[5]) | (d[42]&AllZeros) | (w[3]&AllZeros) | (w[37]&AllZeros) | (x[22]&AllZeros) | (TTB3&d[58]) | (bc[3]&w[19]) | (bc[3]&x[21]) | (bc[3]&w[15]) | (bc[3]&x[26]));
	assign az[13] = ~((w[37]&nIR[0]) | (x[27]) | (w[9]&bc[1]) | (nbc[1]&x[24]) | (nIR[3]&x[24]) | (bc[1]&w[19]) | (IR[3]&x[23]));

endmodule // ALU
