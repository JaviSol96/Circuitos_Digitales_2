`ifndef TRANSMIT_H
`define TRANSMIT_H

`include "../../codegroups.v"

module transmit (
        // Inputs
        input mr_main_reset,
        input GTX_CLK,
        input TX_EN,
        input TX_ER,
        input receiving,
        input xmit,
        input [7:0] TXD,
        // Output
        output reg COL,
        output reg transmitting,
        output reg [7:0] tx_o_set       // 10 bits  
);
// Global variables
localparam FALSE  = 0;
// Definicion de estados
localparam TX_Test_Xmit        = 0;
localparam IDLE                = 1;
localparam XMIT_Data           = 2;
localparam Start_of_Packet     = 3;
localparam TX_Packet           = 4;
localparam TX_Data             = 5;
localparam END_of_Packet_NOEXT = 6;
localparam EPD2_NOEXT          = 7;   

reg [4:0]state;
reg tx_even;
reg TX_OSET_indicate;
reg power_on;
reg [4:0] pcs_tx_state;
always@(posedge GTX_CLK) begin
    if(!mr_main_reset) begin
        state <= TX_Test_Xmit;
        power_on <= 1'b0;
    end else begin
        state <= pcs_tx_state;
    end

end

always @(*) begin
    tx_even <= 0;
    power_on <= 1'b1;
    TX_OSET_indicate <= 1'b1;
    pcs_tx_state = state;
    if(power_on & mr_main_reset & xmit) begin
        if (state == TX_Test_Xmit) begin
            transmitting = FALSE; // FALSE
            COL = FALSE;   // FALSE
            if (xmit == 1'b1 && TX_EN) begin
                pcs_tx_state = IDLE;
            end 
            if (xmit == 1'b1 && !TX_EN) begin
                pcs_tx_state = XMIT_Data;
            end
        end

        // Estado IDLE

        if (state == IDLE) begin
            tx_o_set <= TXD;
            pcs_tx_state = XMIT_Data;
        end

        // Estado XMIT_Data
        if (state == XMIT_Data) begin
            if (TX_EN && TX_OSET_indicate) begin
                pcs_tx_state = Start_of_Packet;
            end

            if (!TX_EN && TX_OSET_indicate) begin
                tx_o_set <= TXD;
                pcs_tx_state = XMIT_Data;
            end
        end

        // Estado Start_of_Packet
        if (state == Start_of_Packet) begin
            transmitting = 1'b1;  // TRUE
            COL = receiving;
            tx_o_set <= TXD;
            pcs_tx_state = TX_Packet;
        end

        // Estado TX_Packet

        if (state == TX_Packet) begin
            if (TX_EN) begin
                pcs_tx_state = TX_Data;
            end

            if (!TX_EN) begin
                pcs_tx_state = END_of_Packet_NOEXT;
            end
        end

        // Estado TX_Data

        if (state == TX_Data) begin
            COL = receiving;
            tx_o_set = TXD; // Aqui iria el VOUID
            pcs_tx_state = TX_Packet;
        end


    // Estado END_of_Packet_NOEXT

    if (state == END_of_Packet_NOEXT) begin
        tx_o_set <= TXD;
        COL = 0;  // FALSE
        pcs_tx_state = EPD2_NOEXT;
    end 

    if (state == EPD2_NOEXT) begin
        transmitting = 0; // FALSE
        tx_o_set = `K23_7_oct;
        pcs_tx_state = XMIT_Data;
    end
    end



end
  
function [7:0] VOID(input [7:0] x);
    if(!TX_EN && TXD != 8'b00001111) begin
        VOID = `K30_7_oct;
    end else if(TX_EN) begin
        VOID = `K30_7_oct;
    end else begin
        VOID = x;
    end

endfunction



endmodule

`endif