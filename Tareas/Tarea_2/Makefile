all: correr1 correr2 correr3 sintesis

correr1:
	iverilog -o tb.vvp tb_Counter_synth_rtlil.v
	vvp tb.vvp
	gtkwave tb.vcd

correr2:
	iverilog -o tb.vvp tb_Counter_full_synth.v
	vvp tb.vvp
	gtkwave tb.vcd
	
correr3:
	iverilog -o tb.vvp tb_Counter_synth_delay.v
	vvp tb.vvp
	gtkwave tb.vcd

sintesis:
	yosys -s Counter16.ys


