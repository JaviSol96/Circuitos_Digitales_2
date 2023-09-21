`ifndef TESTBENCH_H
`define TESTBENCH_H
`include "./tester.v"
`include "./encode_transmission.v"
`include "./transmit.v"
`include "./codegroups.v"
module testbench;
wire [9:0] tx_code_group;
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
wire xmit;
initial begin
    $dumpfile("testbench.vcd");
    $dumpvars;
end
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
    .xmit(xmit)
);

endmodule
`endif 