`timescale 1ns/1ns

module TestRegbit();

	reg CLK;
	always #25 CLK = ~CLK;

	wire q1;
	wire q2;

	reg reg_d;
	reg Load;

	regbit reg1 ( .clk(CLK), .cclk(~CLK), .d(reg_d), .ld(Load), .q(q1) );
	Fair_regbit reg2 ( .clk(CLK), .cclk(~CLK), .d(reg_d), .ld(Load), .q(q2) );

	always @(posedge CLK) begin
	end

	initial begin

		$display("Check the waves for different implementations of regbit. We need to understand the `ld` signal negedge effect.");

		CLK <= 1'b0;

		$dumpfile("TestRegbit.vcd");
		$dumpvars(0, reg1);
		$dumpvars(1, reg2);

		// Keep

		reg_d <= 0;
		Load <= 0;
		repeat (2) @ (posedge CLK);

		// Load 1

		reg_d <= 1;
		Load <= 1;
		repeat (1) @ (posedge CLK);
		Load <= 0;
		repeat (1) @ (posedge CLK);

		// Load 0

		reg_d <= 0;
		Load <= 1;
		repeat (1) @ (posedge CLK);
		Load <= 0;
		repeat (1) @ (posedge CLK);		

		$finish;
	end

endmodule // TestRegbit

module Fair_regbit ( clk, cclk, d, ld, q, nq );

	input clk;
	input cclk;
	input d;
	input ld;
	output q;
	output nq;

	// Latch with complementary set enable, complementary CLK.

	reg val;
	initial val <= 1'b0;

	always @(negedge ld) begin
		if (clk)
			val <= d;
	end

	assign q = val;
	assign nq = ~q;

endmodule // Fair_regbit
