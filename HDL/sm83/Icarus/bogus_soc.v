`timescale 1ns/1ns

module Bogus_SoC(CLK, WAVE_FILE, ExternalRESET);
	input CLK;
	input [32*8:0] WAVE_FILE;
	input ExternalRESET;

	/* verilator lint_off UNOPTFLAT */
	wire [7:0] dbus;
	wire [15:0] abus;
	wire [7:0] irq_ack;

	wire M1; 		// T1
	wire OSC_STABLE;		// T15
	wire OSC_ENA;		// T14
	wire CLK_ENA;		// T11
	
	wire RD;
	wire WR;
	wire MemReq;

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
		.DATA_CLK(INC_CLK_P),
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
endmodule // Bogus_SoC

module Bogus_HW (CLK, DATA_CLK, RESET, MREQ, RD, WR, databus, addrbus, CPU_IRQ_TRIG, CPU_IRQ_ACK );

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
	localparam REG_DIV = 16'hFF04;
	localparam REG_TIMA = 16'hFF05;
	localparam REG_TMA = 16'hFF06;
	localparam REG_TAC = 16'hFF07;
	localparam REG_IF = 16'hFF0F;
	localparam REG_STAT = 16'hFF40;

	// Timer registers
	reg [15:0] DIV = 16'haba9; // magic value that matches the reference emulator
	reg [7:0] TIMA = 0;
	reg [7:0] TMA = 0;
	reg [2:0] TAC = 0;

	reg [7:0] STAT = 8'h00;

	reg [4:0] IF = 0;
	reg tima_overflow = 0;

	wire [15:0] nDIV = DIV + 16'b1;
	wire next_counter_bit = TAC[2] && (TAC[1:0] == 2'b00 ? nDIV[9]
	                            : TAC[1:0] == 2'b01 ? nDIV[3]
								: TAC[1:0] == 2'b10 ? nDIV[5]
								:                     nDIV[7]);

	reg [7:0] mem[0:65535];
	integer j;
	// Pre-fill the memory with some value so we don't run into `xx`
	initial begin
		// for(j = 0; j < 65536; j = j+1) begin
		// 	mem[j] = 0;
		// end
	end

	wire [7:0] value;
	wire [7:0] rom_value;

	wire [7:0] dbus;
	BusKeeper data_latch [7:0] ( .d(databus), .q(dbus) );

	MBC mbc(.RESET(RESET), .DATA_CLK(DATA_CLK), .WR(WR), .addrbus(addrbus), .databus(dbus), .value(rom_value));

	assign CPU_IRQ_TRIG = IF;

	// Timer simulation

	reg [1:0] reload_delay = 0;
	reg counter_bit = 0;
	reg timer_int = 0;

	always @(negedge CLK) begin
		if (WR && addrbus == REG_DIV) DIV <= 0;
		else DIV <= nDIV;

		counter_bit <= next_counter_bit;

		// on counter_bit negedge
		if (counter_bit && ~next_counter_bit) begin
			if (RESET)
				TIMA <= 0;
			else if (TIMA == 255) begin
				TIMA <= 0;
				reload_delay <= 2'b10;
			end else 
				TIMA <= TIMA + 8'b1;
		end

		if (reload_delay > 0) begin
			reload_delay <= reload_delay - 2'b1;
			if (reload_delay == 1) begin
				tima_overflow = 1'b1;
				TIMA <= TMA;
				timer_int <= 1'b1;
			end
		end else timer_int <= 1'b0;
	end

	// "Simulate" the LCDC status register. The implementation here does not
	// resembles the real hardware at all, we only want to see if changes to
	// this register while the CPU is reading it will make the CPU read a AND
	// of all different values driven in the bus.
	reg [3:0] stat_counter = 0;
	always @(posedge CLK) begin
		// just change the STAT register with a period non-multiple of 4 or 3
		if (WR && addrbus == REG_STAT) STAT <= dbus;
		else if (stat_counter == 11-1) begin
			STAT[1:0] <= STAT[1:0] + 2'b1;
			stat_counter <= 0;
		end else begin
			stat_counter <= stat_counter + 4'b1;
		end

		if (WR && addrbus == REG_IF) IF <= dbus[4:0];
		else IF <= (IF | {5'b0, timer_int, 2'b0}) & ~CPU_IRQ_ACK;
	end

	assign value = (addrbus == REG_DIV) ? DIV[15:8]
		: (addrbus == REG_TIMA) ? TIMA
		: (addrbus == REG_TMA) ? TMA
		: (addrbus == REG_TAC) ? {5'h1f, TAC}
		: (addrbus == REG_IF) ? {3'h7, IF}
		: (addrbus == REG_STAT) ? STAT
		: (addrbus >= 16'hff00 && addrbus <= 16'hff7f) ? 8'hff // IO registers
		: (addrbus <= 16'h7fff) ? rom_value
		: mem[addrbus];

	wire [7:0] serial_data = mem[REG_SERIAL_DATA];
	wire serial_write = (addrbus == REG_SERIAL_CONTROL);

	always @(posedge DATA_CLK) begin
		if (WR) begin
			if (addrbus == REG_DIV);
			else if (addrbus == REG_TIMA) TIMA <= dbus;
			else if (addrbus == REG_TMA) TMA <= dbus;
			else if (addrbus == REG_TAC) TAC <= dbus[2:0];
			// else if (addrbus == REG_IF) IF <= dbus[4:0];
			// else if (addrbus == REG_STAT) STAT <= dbus;
			else if (addrbus <= 16'h7fff) begin end
			else mem[addrbus] <= dbus;

			if (serial_write) begin
				$write("%c", mem[REG_SERIAL_DATA]);
				// $fflush();
			end
		end
	end
	

	assign databus = (MREQ & RD) ? value : 8'hZZ;

endmodule // Bogus_HW
