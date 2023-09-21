`include "synchronization.v"
`include "tester_sync.v"

module testbench_SYNC;
	wire clk, mr_main_mr_main_reset,signal_detectCHANGE,mr_loopback,signal_detect;
	wire [9:0] code_group; 
	wire [9:0] SUDI;
	wire code_sync_status,rx_even;
	wire [2:0]  good_cgs;

SYNCH SYNC (
	.clk                (clk),
	.mr_main_reset      (mr_main_reset),
	.mr_loopback        (mr_loopback),
	.signal_detect      (signal_detect),
	.code_group         (code_group[9:0]),
	.SUDI               (SUDI[9:0]),
	.code_sync_status   (code_sync_status),
	.rx_even            (rx_even)
);

tester_SYNC Probador (
	.clk                (clk),
	.mr_main_reset      (mr_main_reset),
	.mr_loopback        (mr_loopback),
	.signal_detect      (signal_detect),
	.code_group         (code_group[9:0]),
	.SUDI               (SUDI[9:0]),
	.code_sync_status   (code_sync_status),
	.rx_even            (rx_even)
);

initial
begin
	$dumpfile("tb_sync.vcd");
	$dumpvars;
end

endmodule