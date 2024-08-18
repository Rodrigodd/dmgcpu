CPU =\
 ../_GekkioNames.v\
 ../ALU.v\
 ../Bottom.v\
 ../DataMux.v\
 ../Decoder1.v\
 ../Decoder2.v\
 ../Decoder3.v\
 ../IDU.v\
 ../IRNots.v\
 ../IRQ.v\
 ../Regs.v\
 ../SeqCells.v\
 ../Seq.v\
 ../Thingy.v\
 ../Top.v\

SOURCES =\
 $(CPU)\
 external_clk.v\
 run.v

ROM=roms/bogus_hw.mem
WAVE_FILE=dmg_waves.fst

YOSYS = ~/repos/yosys/yosys

run:
	iverilog -Wall -D ICARUS -s SM83_Run -o sm83.run $(SOURCES) -DROM=\"$(ROM)\" -DWAVE_FILE=\"$(WAVE_FILE)\"
	vvp sm83.run -fst

low:
	/bin/iverilog -Wall -D ICARUS -s SM83_Run -o sm83.run $(SOURCES) -DROM=\"$(ROM)\" -DWAVE_FILE=\"$(WAVE_FILE)\"
	/bin/vvp sm83.run -fst

verbose:
	iverilog -v -Wall -D ICARUS -s SM83_Run -o sm83.run $(SOURCES) -DROM=\"$(ROM)\" -DWAVE_FILE=\"$(WAVE_FILE)\"
	vvp -v sm83.run -fst

VERILATOR_OPTS=\
 -DROM=\"$(ROM)\"\
 -DWAVE_FILE=\"dmg_waves3.fst\"\
 --top-module SM83_Run\
 --cc\
 sm83.yosys.v\
 --timing\
 --trace-fst\
 --no-trace-top\
 --Wno-fatal\
 --Wno-LATCH

verilator:
	verilator $(VERILATOR_OPTS) --binary -j 0
	obj_dir/VSM83_Run

check:
	verilator $(VERILATOR_OPTS) --lint-only --report-unoptflat

clean:
	rm -f sm83.run
	rm -rf obj_dir
	rm -rf *.rtlil
	rm -f sm831.yosys.v
	rm -f sm83.yosys.run
	rm -f dmg_waves.fst
	rm -f dmg_waves2.fst

# Use yosys to optmize the code, and write back as verilog
yosys: yosys.ys
	$(YOSYS) -s yosys.ys

run_yosys:
	iverilog -Wall -D ICARUS -s SM83_Run -o sm83.yosys.run sm83.yosys.v external_clk.v run.v -DROM=\"$(ROM)\" -DWAVE_FILE=\"dmg_waves2.fst\"
	vvp sm83.yosys.run -fst
