
module Bottom ( CLK2, CLK3, CLK4, CLK5, CLK6, CLK7, DL, DV, bc, bq4, bq5, bq7, ALU_L2, ALU_L1, ALU_L4, BTT, alu, Res, IR, d, w, x, 
	SYNC_RES, TTB1, TTB2, TTB3, Maybe1, Thingy_to_bot, bot_to_Thingy, SeqControl_1, SeqControl_2, SeqOut_1,
	A, CPU_IRQ_ACK, CPU_IRQ_TRIG, RD );

	input CLK2;
	input CLK3;
	input CLK4;
	input CLK5;
	input CLK6;
	input CLK7; 

	inout [7:0] DL;
	output [7:0] DV;
	input [5:0] bc;
	output bq4;
	output bq5;
	output bq7;
	output ALU_L2;
	output ALU_L1;
	output ALU_L4;
	output BTT;
	output [7:0] alu;
	input [7:0] Res;

	output [7:0] IR;
	input [106:0] d;
	input [40:0] w;
	input [68:0] x;

	input SYNC_RES;
	input TTB1;
	input TTB2;
	input TTB3;
	input Maybe1;
	input Thingy_to_bot;
	output bot_to_Thingy;
	output SeqControl_1;
	output SeqControl_2;
	input SeqOut_1;

	output [15:0] A;
	output [7:0] CPU_IRQ_ACK;
	input [7:0] CPU_IRQ_TRIG;
	input RD;

	// Internal bottom buses

	wire [7:0] abus;
	wire [7:0] bbus;
	wire [7:0] cbus;
	wire [7:0] dbus;
	wire [7:0] ebus;
	wire [7:0] fbus;
	wire [7:0] zbus;
	wire [7:0] wbus;
	wire [7:0] adl;
	wire [7:0] adh;
	wire [7:3] bro; 		// IRQ Logic

	wire [7:0] Aout;	// Reg A out to bq Logic

	// Implementation

	BusPrecharge precharge (
		.CLK2(CLK2),
		.DL(DL),
		.abus(abus),
		.bbus(bbus),
		.cbus(cbus),
		.dbus(dbus) );

	BottomLeftLogic bottom_left (
		.CLK2(CLK2),
		.bc(bc),
		.bq4(bq4),
		.bq5(bq5),
		.bq7(bq7),
		.pq(Aout),
		.DV(DV) );

	RegsBuses regs (
		.CLK5(CLK5),
		.CLK6(CLK6),
		.w(w),
		.x(x),
		.DL(DL),
		.IR(IR),
		.abus(abus),
		.bbus(bbus),
		.cbus(cbus),
		.dbus(dbus),
		.ebus(ebus),
		.fbus(fbus),
		.Aout(Aout) );

	TempRegsBuses temp_regs (
		.CLK4(CLK4),
		.CLK5(CLK5),
		.CLK6(CLK6),
		.d60(d[60]),
		.w(w),
		.x(x),
		.DL(DL),
		.ebus(ebus),
		.fbus(fbus),
		.zbus(zbus),
		.wbus(wbus),
		.Res(Res),
		.ALU_L2(ALU_L2),
		.ALU_L1(ALU_L1),
		.ALU_L4(ALU_L4),
		.BTT(BTT) );

	SP sp (
		.CLK5(CLK5),
		.CLK6(CLK6),
		.CLK7(CLK7),
		.IR4(IR[4]),
		.IR5(IR[5]),
		.d60(d[60]),
		.d66(d[66]),
		.w(w),
		.x(x),
		.abus(abus),
		.bbus(bbus),
		.cbus(cbus),
		.dbus(dbus),
		.zbus(zbus),
		.wbus(wbus),
		.adl(adl),
		.adh(adh) );

	PC pc (
		.CLK5(CLK5),
		.CLK6(CLK6),
		.CLK7(CLK7),
		.d92(d[92]),
		.w(w),
		.x(x),
		.DL(DL),
		.abus(abus),
		.cbus(cbus),
		.dbus(dbus),
		.zbus(zbus),
		.wbus(wbus),
		.adl(adl),
		.adh(adh),
		.IR(IR),
		.bro(bro) );

	IncDec incdec (
		.CLK4(CLK4),
		.TTB1(TTB1),
		.TTB2(TTB2),
		.TTB3(TTB3),
		.Maybe1(Maybe1),
		.cbus(cbus),
		.dbus(dbus),
		.adl(adl),
		.adh(adh),
		.AddrBus(A) );

	IRQ_Logic irq (
		.CLK3(CLK3),
		.CLK4(CLK4),
		.CLK5(CLK5),
		.CLK6(CLK6),
		.DL(DL),
		.RD(RD),
		.CPU_IRQ_ACK(CPU_IRQ_ACK),
		.CPU_IRQ_TRIG(CPU_IRQ_TRIG),
		.bro(bro),
		.bot_to_Thingy(bot_to_Thingy),
		.Thingy_to_bot(Thingy_to_bot),
		.SYNC_RES(SYNC_RES),
		.SeqControl_1(SeqControl_1),
		.SeqControl_2(SeqControl_2),
		.SeqOut_1(SeqOut_1),
		.d93(d[93]),
		.A(A) );

	assign alu = ~abus;

endmodule // Bottom

module BusPrecharge ( CLK2, DL, abus, bbus, cbus, dbus );

	input CLK2;
	inout [7:0] DL;
	inout [7:0] abus;
	inout [7:0] bbus;
	inout [7:0] cbus;
	inout [7:0] dbus;

	assign DL = CLK2 ? 8'bz : 8'b1;
	assign abus = CLK2 ? 8'bz : 8'b1;
	assign bbus = CLK2 ? 8'bz : 8'b1;
	assign cbus = CLK2 ? 8'bz : 8'b1;
	assign dbus = CLK2 ? 8'bz : 8'b1;

endmodule // BusPrecharge

module BottomLeftLogic ( CLK2, bc, bq4, bq5, bq7, pq, bbus, DV );

	input CLK2;
	input [5:0] bc;
	output bq4;
	output bq5;
	output bq7;
	input [7:0] pq;
	inout [7:0] bbus;
	output [7:0] DV;

	assign bq4 = pq[1] | pq[2] | pq[3];
	assign bq5 = pq[5] | pq[6] | pq[7];
	assign bq7 = pq[4] | pq[7];
	
	assign DV[0] = ~(CLK2 ? (bbus[0] & ~bc[4]) : 1'b1);
	assign DV[1] = ~(CLK2 ? (bbus[1] & ~bc[4]) : 1'b1);
	assign DV[2] = ~(CLK2 ? (bbus[2] & ~bc[4]) : 1'b1);
	assign DV[3] = ~(CLK2 ? (bbus[3] & ~bc[4]) : 1'b1);
	assign DV[4] = ~(CLK2 ? (bbus[4] & ~(bc[4] | (bc[0] & bc[1])) ) : 1'b1);
	assign DV[5] = ~(CLK2 ? (bbus[4] & ~(bc[4] | (bc[0] & bc[5])) ) : 1'b1);
	assign DV[6] = ~(CLK2 ? (bbus[4] & ~(bc[4] | (bc[0] & bc[2])) ) : 1'b1);
	assign DV[7] = ~(CLK2 ? (bbus[4] & ~(bc[4] | (bc[0] & bc[3])) ) : 1'b1);

	// I decided to put the bc0/bc4 generation in the ALU, so that the bc signals would be made as output from the ALU (for beauty).

endmodule // BottomLeftLogic

module RegsBuses ( CLK5, CLK6, w, x, DL, IR, abus, bbus, cbus, dbus, ebus, fbus, Aout );

	input CLK5;
	input CLK6;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] DL;
	output [7:0] IR;
	inout [7:0] abus;
	inout [7:0] bbus;
	inout [7:0] cbus;
	inout [7:0] dbus;
	inout [7:0] ebus;
	inout [7:0] fbus;
	output [7:0] Aout; 			// Reg A output for bq logic

	// Regs output

	wire [7:0] r1q;		// A
	wire [7:0] r2q;		// L
	wire [7:0] r3q;		// H
	wire [7:0] r4q;		// E
	wire [7:0] r5q;		// D
	wire [7:0] r6q;		// C
	wire [7:0] r7q;		// B

	regbit RegIR [7:0] ( .clk(CLK6), .cclk(CLK5), .d(DL), .ld(w[26]), .q(IR) );

	regbit RegA [7:0]( .clk(CLK6), .cclk(CLK5), .d(fbus), .ld(x[38]), .q(r1q) );
	regbit RegL [7:0]( .clk(CLK6), .cclk(CLK5), .d(ebus), .ld(x[40]), .q(r2q) );
	regbit RegH [7:0]( .clk(CLK6), .cclk(CLK5), .d(fbus), .ld(x[39]), .q(r3q) );
	regbit RegE [7:0]( .clk(CLK6), .cclk(CLK5), .d(ebus), .ld(x[50]), .q(r4q) );
	regbit RegD [7:0]( .clk(CLK6), .cclk(CLK5), .d(fbus), .ld(x[48]), .q(r5q) );
	regbit RegC [7:0]( .clk(CLK6), .cclk(CLK5), .d(ebus), .ld(x[51]), .q(r6q) );
	regbit RegB [7:0]( .clk(CLK6), .cclk(CLK5), .d(fbus), .ld(x[49]), .q(r7q) );

	// TBD

	assign Aout = r1q;

endmodule // RegsBuses

module TempRegsBuses ( CLK4, CLK5, CLK6, d60, w, x, DL, ebus, fbus, zbus, wbus, Res, ALU_L2, ALU_L1, ALU_L4, BTT );

	input CLK4;
	input CLK5;
	input CLK6;
	input d60;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] DL;
	inout [7:0] ebus;
	inout [7:0] fbus;
	inout [7:0] zbus;
	inout [7:0] wbus;
	input [7:0] Res;
	output ALU_L2; 			// Flag C from temp Z
	output ALU_L1; 			// Flag H from temp Z
	output ALU_L4; 			// Flag N from temp Z
	output BTT; 			// Flag Z from temp Z

	wire [7:0] Z_in;
	wire [7:0] W_in;

	regbit Z [7:0]( .clk(CLK6), .cclk(CLK5), .d(Z_in), .ld(x[60]), .q(zbus) );
	regbit W [7:0]( .clk(CLK6), .cclk(CLK5), .d(W_in), .ld(x[59]), .q(wbus) );

	// TBD

	assign ALU_L2 = zbus[4];
	assign ALU_L1 = zbus[5];
	assign ALU_L4 = zbus[6];
	assign BTT = zbus[7];

endmodule // TempRegsBuses

module SP ( CLK5, CLK6, CLK7, IR4, IR5, d60, d66, w, x, abus, bbus, cbus, dbus, zbus, wbus, adl, adh );

	input CLK5;
	input CLK6;
	input CLK7;
	input IR4;
	input IR5;
	input d60;
	input d66;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] abus;
	inout [7:0] bbus;
	inout [7:0] cbus;
	inout [7:0] dbus;
	inout [7:0] zbus;
	inout [7:0] wbus;
	inout [7:0] adl;
	inout [7:0] adh;

	// TBD

endmodule // SP

module PC ( CLK5, CLK6, CLK7, d92, w, x, DL, abus, cbus, dbus, zbus, wbus, adl, adh, IR, bro );

	input CLK5;
	input CLK6;
	input CLK7;
	input d92;
	input [40:0] w;
	input [68:0] x;
	inout [7:0] DL;
	inout [7:0] abus;
	inout [7:0] cbus;
	inout [7:0] dbus;
	inout [7:0] zbus;
	inout [7:0] wbus;
	inout [7:0] adl;
	inout [7:0] adh;
	input [7:0] IR;
	input [7:3] bro;

	// TBD

endmodule // PC

module regbit ( clk, cclk, d, ld, q );

	input clk;
	input cclk;
	input d;
	input ld;
	output q;

	// Latch with complementary set enable, complementary CLK.

	reg val;
	initial val <= 1'b0;

	always @(*) begin
		if (clk & ld)
			val <= d;
	end

	assign q = val;

endmodule // regbit

module regbit_res ( clk, cclk, d, ld, res, q );

	input clk;
	input cclk;
	input d;
	input ld;
	input res;
	output q;

	// TBD

endmodule // regbit_res

module IncDec ( CLK4, TTB1, TTB2, TTB3, Maybe1, cbus, dbus, adl, adh, AddrBus );

	input CLK4;
	input TTB1;
	input TTB2;
	input TTB3;
	input Maybe1;
	input [7:0] cbus;
	input [7:0] dbus;
	input [7:0] adl;
	input [7:0] adh;
	output [15:0] AddrBus;

	// TBD

endmodule // IncDec

module cntbit ();

	// TBD

endmodule // cntbit

module IRQ_Logic ( CLK3, CLK4, CLK5, CLK6, DL, RD, CPU_IRQ_ACK, CPU_IRQ_TRIG, bro, bot_to_Thingy, Thingy_to_bot, SYNC_RES,
	SeqControl_1, SeqControl_2, SeqOut_1, d93, A );

	input CLK3;
	input CLK4;
	input CLK5;
	input CLK6;
	inout [7:0] DL;			// DataBus
	input RD;
	output [7:0] CPU_IRQ_ACK;
	input [7:0] CPU_IRQ_TRIG;
	output [7:3] bro;			// Int address  ("Bottom Right output")
	output bot_to_Thingy;			// 1: Access to IE detected
	input Thingy_to_bot;			// 1: Write Access to IE detected (Load IE from DataBus)
	input SYNC_RES;
	output SeqControl_1;
	output SeqControl_2;
	input SeqOut_1;			// IME?
	input d93; 			// 1: Enable IRQ processing by Decoder1, 0: disable
	input [15:0] A;			// To check the address for the value 0xffff (IE)

	// Internal

	wire sc1; 			// "Seq control 1"
	wire sc2; 			// "Seq control 2"
	wire nso;		// "~Seq Out (1)"
	wire [7:0] ieq; 		// IE output
	wire [7:0] ienq;		// IE output (complement)
	wire [7:0] ifq;		// IF output
	wire [7:0] ifnq; 	// IF output (complement)
	wire [7:0] ack; 	// Acknowledged

	// IE/IF
	module7 IE [7:0] ( .clk(CLK6), .cclk(CLK5), .d(DL), .ld(Thingy_to_bot), .res(SYNC_RES), .q(ieq), .nq(ienq) );
	module8 IF [7:0] ( .clk(CLK3), .cclk(CLK4), .d(~(ienq&CPU_IRQ_TRIG)), .q(ifq), .nq(ifnq) );
	assign DL = ({8{RD}} & {8{bot_to_Thingy}} & ieq) ? 8'b0 : 8'bz; 	// znand3.

	// Breadcrumps
	assign nso = ~SeqOut_1;
	assign sc1 = ~(ifnq[0]|ifnq[1]|ifnq[2]|ifnq[3]|ifnq[4]|ifnq[5]|ifnq[6]|ifnq[7]|~nso);
	assign sc2 = CLK6 ? ~(ack[0]|ack[1]|ack[2]|ack[3]|ack[4]|ack[5]|ack[6]|ack[7]) : 1'b1;
	assign bot_to_Thingy = (A[0]&A[1]&A[2]&A[3]&A[4]&A[5]&A[6]&A[7]&A[8]&A[9]&A[10]&A[11]&A[12]&A[13]&A[14]&A[15]); 	// Addr == 0xffff

	// Priority encoder
	assign ack[0] = CLK6 ? ~(ifnq[0]&nso) : 1'b1;
	assign ack[1] = CLK6 ? ~(ifnq[1]&ifq[0]&nso) : 1'b1;
	assign ack[2] = CLK6 ? ~(ifnq[2]&ifq[0]&ifq[1]&nso) : 1'b1;
	assign ack[3] = CLK6 ? ~(ifnq[3]&ifq[0]&ifq[1]&ifq[2]&nso) : 1'b1;
	assign ack[4] = CLK6 ? ~(ifnq[4]&ifq[0]&ifq[1]&ifq[2]&ifq[3]&nso) : 1'b1;
	assign ack[5] = CLK6 ? ~(ifnq[5]&ifq[0]&ifq[1]&ifq[2]&ifq[3]&ifq[4]&nso) : 1'b1;
	assign ack[6] = CLK6 ? ~(ifnq[6]&ifq[0]&ifq[1]&ifq[2]&ifq[3]&ifq[4]&ifq[5]&nso) : 1'b1;
	assign ack[7] = CLK6 ? ~(ifnq[7]&ifq[0]&ifq[1]&ifq[2]&ifq[3]&ifq[4]&ifq[5]&ifq[6]&nso) : 1'b1;

	// Interrupt address
	assign bro[3] = ~(CLK6 ? (~(CPU_IRQ_ACK[1]|CPU_IRQ_ACK[3]|CPU_IRQ_ACK[5]|CPU_IRQ_ACK[7])) : 1'b1);
	assign bro[4] = ~(CLK6 ? (~(CPU_IRQ_ACK[2]|CPU_IRQ_ACK[3]|CPU_IRQ_ACK[6]|CPU_IRQ_ACK[7])) : 1'b1);
	assign bro[5] = ~(CLK6 ? (~(CPU_IRQ_ACK[4]|CPU_IRQ_ACK[5]|CPU_IRQ_ACK[6]|CPU_IRQ_ACK[7])) : 1'b1);
	assign bro[6] = ~sc2 & d93;
	assign bro[7] = ~nso & d93;

	assign SeqControl_1 = ~sc1;
	assign SeqControl_2 = ~sc2;
	assign CPU_IRQ_ACK = ack & {8{d93}};

endmodule // IRQ_Logic

module module7 ( clk, cclk, d, ld, res, q, nq );

	input clk;
	input cclk;
	input d;
	input ld;
	input res;
	output q;
	output nq;

	// Latch (no edge detection) with reset.

	reg val;
	initial val <= 1'b0;

	always @(*) begin
		if (clk & ld)
			val <= d;
		if (res)
			val <= 1'b0;
	end

	assign q = val;
	assign nq = ~q;

endmodule // module7

module module8 ( clk, cclk, d, q, nq );

	input clk;
	input cclk;
	input d;
	output q;
	output nq;

	// Regular (transparent) latch (no edge detection), to store the interrupt flag.

	reg val;
	initial val <= 1'b0;

	always @(*) begin
		if (clk)
			val <= d;
	end

	assign q = val;
	assign nq = ~q;

endmodule // module8
