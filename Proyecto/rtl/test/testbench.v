`ifndef TESTBENCH_H
`define TESTBENCH_H
`include "./tester.v"
`include "../../src/Transmit/encode_transmission.v"
`include "../../src/Transmit/transmit.v"
`include "../../src/Synchronization/synchronization.v"
`include "../../codegroups.v"
`include "../../src/Receive/receive.v"

module testbench;
wire [9:0] tx_code_group;
wire [9:0] SUDI;
wire COL;
wire transmitting;
wire [7:0] TXD;
wire TX_EN;
wire TX_ER;
wire GTX_CLK;
wire receiving;
wire RESET;
wire mr_main_reset;
wire power_on;
wire [7:0] tx_o_set;
wire [7:0] tx_o_set_tx;
wire [7:0] RXD;
wire xmit;
wire mr_loopback;
wire signal_detect;
wire code_sync_status;
wire RX_CLK;
wire RX_DV;
wire rx_lpi_active;
initial begin
    $dumpfile("testbench.vcd");
    $dumpvars;
end


/* Modulos de transmision */
transmit dut_tx(
    .mr_main_reset(mr_main_reset),
    .GTX_CLK(GTX_CLK),
    .TX_EN(TX_EN),
    .receiving(receiving),
    .xmit(xmit),
    .TXD(TXD),
    .COL(COL),
    .transmitting(transmitting),
    .tx_o_set(tx_o_set)
);
TX_ tx_dut(
    .tx_code_group(tx_code_group),
    .COL(COL),
    .transmitting(transmitting),
    .TX_EN(TX_EN),
    .TX_ER(TX_ER),
    .GTX_CLK(GTX_CLK),
    .receiving(receiving),
    .RESET(RESET),
    .power_on(power_on),
    .mr_main_reset(mr_main_reset),
    .tx_o_set(tx_o_set)
);



tester_tx tester_dut(
    .tx_code_group(tx_code_group),
    .COL(COL),
    .transmitting(transmitting),
    .TXD(TXD),
    .TX_EN(TX_EN),
    .TX_ER(TX_ER),
    .GTX_CLK(GTX_CLK),
    .receiving(receiving),
    .RESET(RESET),
    .power_on(power_on),
    .mr_main_reset(mr_main_reset),
    .tx_o_set(tx_o_set),
    .xmit(xmit),
    .mr_loopback(mr_loopback),
    .signal_detect(signal_detect)
);


/* Modulos de Sincronizacion */
SYNCH SYNC (
	.clk                (GTX_CLK),
	.mr_main_reset      (mr_main_reset),
	.mr_loopback        (mr_loopback),
	.signal_detect      (signal_detect),
	.code_group         (tx_code_group),
	.SUDI               (SUDI),
	.code_sync_status   (code_sync_status),
	.rx_even            (rx_even)
);


/* Modulo de Receive */
RECEIVE recp_dut(
    .mr_main_reset(mr_main_reset),
    .clk(GTX_CLK),
    .SUDI(SUDI),
    .EVEN(rx_even),
    .xmit(xmit),
    .RXD(RXD),
    .RX_DV(RX_DV),
    .RX_CLK(RX_CLK),
    .rx_lpi_active(rx_lpi_active)
    
);
endmodule
`endif 