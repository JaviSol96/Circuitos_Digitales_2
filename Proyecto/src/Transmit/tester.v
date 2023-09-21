`ifndef TESTER_TX_H
`define TESTER_TX_H
`include "../../codegroups.v"
module tester_tx (
    // INPUTS
    tx_code_group,
    COL,
    transmitting,
    // OUTPUTS
    TXD,
    TX_EN,
    TX_ER,
    GTX_CLK,
    receiving, // Boolean set by the PCS Receive process. 
               // Also used in transmit process for indicating collision.
    RESET,
    power_on,
    signal_detect,
    tx_config_reg,
    mr_main_reset,
    tx_o_set,
    xmit
);
input [9:0] tx_code_group;
input COL;
input transmitting;
input [7:0] tx_o_set;

output reg [7:0] TXD;
output reg TX_EN;
output reg TX_ER;
output reg GTX_CLK;
output reg receiving;
output reg RESET;
output reg signal_detect;
output reg [15:0] tx_config_reg;
output reg mr_main_reset;
output reg power_on;
output reg xmit;

always begin
    GTX_CLK = 1'b0; #1;
    GTX_CLK = 1'b1; #1;
end

initial begin
    TX_EN = 1'b0;
    #1; #1;
    #1; #1;
    #1; #1;
    #1; #1;
    RESET = 1'b0;
    power_on = 1'b0;
    mr_main_reset = 1'b0;
    TX_EN = 1'b1;
    xmit = 1'b1;
    #1; #1; 
    power_on = 1'b1;
    mr_main_reset = 1'b1;
    TXD = `K28_5_oct;
    #48;
    TXD = `D16_2_oct;
    #48; 
    TXD = `K28_5_oct;
    #48;
    TXD = `D16_2_oct;
    #48;
    TXD = `K28_5_oct;
    #48;
    TXD = `D16_2_oct;
    #48;

    // \S\ Start of transaction
    TXD = `K27_7_oct;
    #48;
    TXD = `D03_0_oct;
    #48;
    TXD = `D02_0_oct;
    #48;
    TXD = `D02_2_oct;
    #48;
    TXD = `D01_0_oct;
    #48;
    TXD = `D00_0_oct;
    #48;
    TX_EN = 1'b0;
    TXD = `K29_7_oct;  // /T/

    TXD = `K23_7_oct; 
    #48;
    #400;
    TX_EN = 1'b0;
    RESET = 1'b0;
    #1; #1;
    #1; #1;
    #1; #1;
    $finish;
end
    
endmodule
`endif