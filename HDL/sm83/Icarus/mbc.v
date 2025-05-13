`timescale 1ns/1ns

module MBC(RESET, DATA_CLK, WR, addrbus, databus, value);
	reg [32*8:0] ROM = "roms/bogus_hw.mem";
	reg [32*8:0] BOOT = "roms/boot.mem";
	integer ret;

	input RESET;
	input DATA_CLK;
	input WR;
	input [15:0] addrbus;
	input [7:0] databus;
	output [7:0] value;

	reg [7:0] bootrom[0:255];
	reg [7:0] rom[0:65535];

	reg in_boot = 1'b1;

	// Simulate memory banking just enough for running cpu_instrs.gb
	reg [1:0] BANK_SELECTED = 1'b1;

	assign value = (in_boot && addrbus < 16'h0100) ? bootrom[addrbus]
		: (addrbus <= 16'h3fff) ? rom[addrbus]
		: (addrbus <= 16'h7fff) ? rom[{BANK_SELECTED[1:0], addrbus[13:0]}]
		: 16'hffff;

	integer j;
	initial begin
		ret = $value$plusargs("ROM=%s", ROM);
		ret = $value$plusargs("BOOT=%s", BOOT);

		$display("BOOT file '%s'", BOOT);
		$display("ROM file '%s'", ROM);

		// Pre-fill the memory with some value so we don't run into `xx`
		for(j = 0; j < 65536; j = j+1) begin
			rom[j] = 0;
		end

		$readmemh(ROM, rom);
		$readmemh(BOOT, bootrom);
	end
	
	always @(posedge DATA_CLK) begin
		if (WR) begin
			if (addrbus <= 16'h7fff) begin
				// ROM area, switch banks
				BANK_SELECTED <= databus[1:0];
			end
		end
	end

	always @(posedge DATA_CLK, negedge RESET) begin
		// disable bootrom after exiting it
		if (RESET) in_boot = 1'b1;
		else if (addrbus >= 16'h0100) in_boot = 1'b0;
	end

endmodule // MBC
