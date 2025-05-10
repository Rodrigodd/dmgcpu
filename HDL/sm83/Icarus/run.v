`timescale 1ns/1ns

module SM83_Run();
	reg [32*8:0] WAVE_FILE = "dmg_wave.vcd";
	integer CYCLES = 100000;

	reg CLK;
	/* verilator lint_off UNOPTFLAT */
	wire [7:0] dbus;
	wire [15:0] abus;
	wire [7:0] irq_ack;
	reg ExternalRESET;

	wire M1; 		// T1
	wire OSC_STABLE;		// T15
	wire OSC_ENA;		// T14
	wire CLK_ENA;		// T11
	
	wire RD;
	wire WR;
	wire MemReq;

	// The original GameBoy run at 4.194304 MHz (2^22 Hz), or a period of
	// 238.418ns, or a half period of 119.209ns. We round that to 120ns, or
	// a frequency of 4.1666MHz (a error of ~0.7%)
	always #120 CLK = ~CLK;

	wire ADR_CLK_N;
	wire ADR_CLK_P;
	wire DATA_CLK_N;
	wire DATA_CLK_P;
	wire INC_CLK_N;
	wire INC_CLK_P;
	wire LATCH_CLK;
	wire MAIN_CLK_N;
	wire MAIN_CLK_P;

	wire ASYNC_RESET;
	wire SYNC_RESET;

	wire [7:0] CPU_IRQ_TRIG;

	Bogus_HW hw (
		.CLK(CLK),
		.DATA_CLK(DATA_CLK_N),
		.RESET(ExternalRESET),
		.MREQ(MemReq),
		.RD(RD),
		.WR(WR),
		.databus(dbus),
		.addrbus(abus),
		.CPU_IRQ_TRIG(CPU_IRQ_TRIG),
		.CPU_IRQ_ACK(irq_ack) );

	// The core requires a rather sophisticated CLK generation circuit.

	External_CLK clkgen (
		.CLK(CLK),
		.RESET(ExternalRESET),
		.ADR_CLK_N(ADR_CLK_N),
		.ADR_CLK_P(ADR_CLK_P),
		.DATA_CLK_N(DATA_CLK_N),
		.DATA_CLK_P(DATA_CLK_P),
		.INC_CLK_N(INC_CLK_N),
		.INC_CLK_P(INC_CLK_P),
		.LATCH_CLK(LATCH_CLK),
		.MAIN_CLK_N(MAIN_CLK_N),
		.MAIN_CLK_P(MAIN_CLK_P),
		.CLK_ENA(CLK_ENA),
		.OSC_ENA(OSC_ENA),
		.OSC_STABLE(OSC_STABLE),
		.ASYNC_RESET(ASYNC_RESET),
		.SYNC_RESET(SYNC_RESET) );

	SM83Core dmgcore (
		.CLK1(ADR_CLK_N),
		.CLK2(ADR_CLK_P),
		.CLK3(DATA_CLK_P),
		.CLK4(DATA_CLK_N),
		.CLK5(INC_CLK_N),
		.CLK6(INC_CLK_P),
		.CLK7(LATCH_CLK),
		.CLK8(MAIN_CLK_N),
		.CLK9(MAIN_CLK_P),
		.M1(M1),
		.OSC_STABLE(OSC_STABLE),
		.OSC_ENA(OSC_ENA),
		.RESET(ASYNC_RESET),
		.SYNC_RESET(SYNC_RESET),
		.CLK_ENA(CLK_ENA),
		.NMI(1'b0),
		.WAKE(1'b0),
		.RD(RD),
		.WR(WR),
		.BUS_DISABLE(1'b0),
		.MMIO_REQ(1'b0),
		.IPL_REQ(1'b0),
		.IPL_DISABLE(1'b0),
		.MREQ(MemReq),
		.D(dbus),
		.A(abus),
		.CPU_IRQ_TRIG(CPU_IRQ_TRIG),
		.CPU_IRQ_ACK(irq_ack) );

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
		$writememh ("out.mem", hw.mem);
		$finish;
	end	

endmodule // SM83_Run

module Bogus_HW (CLK, DATA_CLK, RESET, MREQ, RD, WR, databus, addrbus, CPU_IRQ_TRIG, CPU_IRQ_ACK );

	reg [32*8:0] ROM = "roms/bogus_hw.mem";
	reg [32*8:0] BOOT = "roms/boot.mem";
	integer ret;
	initial begin 
	end

	input CLK, DATA_CLK;
	input RESET;
	input MREQ;
	input RD;
	input WR;
	inout [7:0] databus;
	input [15:0] addrbus;
	output [7:0] CPU_IRQ_TRIG;
	input [7:0] CPU_IRQ_ACK;

	localparam REG_SERIAL_DATA = 16'hFF01;
	localparam REG_SERIAL_CONTROL = 16'hFF02;
	localparam REG_IF = 16'hFF0F;
	localparam REG_DIV = 16'hFF04;
	localparam REG_TIMA = 16'hFF05;
	localparam REG_TMA = 16'hFF06;
	localparam REG_TAC = 16'hFF07;
	localparam REG_STAT = 16'hFF40;

	// Simulate memory banking just enough for running cpu_instrs.gb
	reg [1:0] BANK_SELECTED = 1'b1;

	// Timer registers
	reg [15:0] DIV = 16'haba9; // magic value that matches the reference emulator
	reg [7:0] TIMA = 0;
	reg [7:0] TMA = 0;
	reg [2:0] TAC = 0;

	reg [7:0] STAT = 8'h00;

	reg [4:0] IF = 0;
	reg tima_overflow = 0;

	wire counter_bit = TAC[2] && (TAC[1:0] == 2'b00 ? DIV[9] : TAC[1:0] == 2'b01 ? DIV[3] : TAC[1:0] == 2'b10 ? DIV[5] : DIV[7]);

	reg [7:0] bootrom[0:255];

	reg [7:0] rom[0:65535];
	reg [7:0] mem[0:65535];
	wire [7:0] value;

	reg in_boot = 1'b1;

	assign CPU_IRQ_TRIG = IF;

	integer j;
	initial begin
		ret = $value$plusargs("ROM=%s", ROM);
		ret = $value$plusargs("BOOT=%s", BOOT);

		$display("BOOT file '%s'", BOOT);
		$display("ROM file '%s'", ROM);

		// Pre-fill the memory with some value so we don't run into `xx`
		for(j = 0; j < 65536; j = j+1) begin
			mem[j] = 0;
			rom[j] = 0;
		end

		$readmemh(ROM, rom);
		$readmemh(BOOT, bootrom);
	end

	// Timer simulation

	always @(negedge CLK) begin
		DIV <= DIV + 1;
	end

	always @(negedge counter_bit) begin
		if (RESET)
			TIMA <= 0;
		else if (TIMA == 255) begin
			TIMA <= 0;
			tima_overflow = 1'b1;
		end else 
			TIMA <= TIMA + 1;
	end

	wire tima_reload_delay = DIV[1] && ~counter_bit;
	always @(posedge tima_reload_delay) begin
		if (tima_overflow) begin
			TIMA <= TMA;
			IF[2] <= 1'b1;
			tima_overflow = 1'b0;
		end
	end

	// "Simulate" the LCDC status register. The implementation here does not
	// resembles the real hardware at all, we only want to see if changes to
	// this register while the CPU is reading it will make the CPU read a AND
	// of all different values driven in the bus.
	reg [3:0] stat_counter = 0;
	always @(posedge CLK) begin
		// just change the STAT register with a period non-multiple of 4 or 3
		if (stat_counter == 11-1) begin
			STAT[1:0] <= STAT[1:0] + 1;
			stat_counter <= 0;
		end else begin
			stat_counter <= stat_counter + 1;
		end
	end


	always @(posedge RD) begin
		// disable bootrom after entering ROM
		if (in_boot && addrbus >= 16'h0100) begin
			in_boot = 1'b0;
		end
	end

	assign value = in_boot ? bootrom[addrbus[7:0]]
		: (addrbus == REG_DIV) ? DIV[15:8]
		: (addrbus == REG_TIMA) ? TIMA
		: (addrbus == REG_TMA) ? TMA
		: (addrbus == REG_TAC) ? {5'h1f, TAC}
		: (addrbus == REG_IF) ? {3'h7, IF}
		: (addrbus == REG_STAT) ? STAT
		: (addrbus >= 16'hff00 && addrbus <= 16'hff7f) ? 8'hff // IO registers
		: (addrbus <= 16'h3fff) ? rom[addrbus]
		: (addrbus <= 16'h7fff) ? rom[{BANK_SELECTED[1:0], addrbus[13:0]}]
		: mem[addrbus];

	wire [7:0] serial_data = mem[REG_SERIAL_DATA];
	wire serial_write = (addrbus == REG_SERIAL_CONTROL);

	always @(posedge DATA_CLK) if (WR) begin
		if (addrbus == REG_DIV) DIV <= 0;
		else if (addrbus == REG_TIMA) TIMA <= databus;
		else if (addrbus == REG_TMA) TMA <= databus;
		else if (addrbus == REG_TAC) TAC <= databus[2:0];
		else if (addrbus == REG_IF) IF <= databus[4:0];
		else if (addrbus == REG_STAT) STAT <= databus;
		else if (addrbus <= 16'h7fff) begin
			// ROM area, switch banks
			BANK_SELECTED <= databus[1:0];
		end
		else
			mem[addrbus] <= databus;

		if (serial_write) begin
			$write("%c", mem[REG_SERIAL_DATA]);
			$fflush();
		end
	end

	always @(CPU_IRQ_ACK) begin
		IF <= IF & ~CPU_IRQ_ACK;
	end
	

	assign databus = (MREQ & RD) ? value : 8'hZZ;

endmodule // Bogus_HW
