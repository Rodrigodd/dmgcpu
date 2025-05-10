`timescale 1ns/1ns

module SM83_Run();
	reg [32*8:0] WAVE_FILE = "dmg_wave.vcd";
	integer CYCLES = 100000;

	reg ExternalRESET;
	reg CLK;

	// The original GameBoy run at 4.194304 MHz (2^22 Hz), or a period of
	// 238.418ns, or a half period of 119.209ns. We round that to 120ns, or
	// a frequency of 4.1666MHz (a error of ~0.7%)
	always #120 CLK = ~CLK;

	Bogus_SoC soc (
		.CLK(CLK),
		.WAVE_FILE(WAVE_FILE),
		.ExternalRESET(ExternalRESET) );

	reg ret;

	initial begin
		ret = $value$plusargs("WAVE_FILE=%s", WAVE_FILE);
		ret = $value$plusargs("CYCLES=%d", CYCLES);

		ExternalRESET = 1'b0;
		CLK = 1'b0;

		$dumpfile(WAVE_FILE);
		$dumpvars(0, SM83_Run);

		ExternalRESET = 1'b1;
		repeat (8) @ (posedge CLK);
		ExternalRESET = 1'b0;

		repeat (CYCLES) @ (posedge CLK);

		$display(""); // breakline after any serial output
		$writememh ("out.mem", soc.hw.mem);
		$finish;
	end	

endmodule // SM83_Run
