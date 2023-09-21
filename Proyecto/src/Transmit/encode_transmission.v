`ifndef TX_H_
`define TX_H_

`include "../../codegroups.v"

module TX_(
    // Outputs
    tx_code_group,
    COL,
    transmitting,
    // Inputs
    // TXD,
    TX_EN,
    TX_ER,
    GTX_CLK,
    receiving, // Boolean set by the PCS Receive process. 
               // Also used in transmit process for indicating collision.
    RESET,
    power_on,
    mr_main_reset,
    tx_o_set
);

output reg [9:0] tx_code_group;
output reg COL;
output reg transmitting;

// input [7:0] TXD;
input TX_EN;
input TX_ER;
input GTX_CLK;
input receiving;
input RESET;
input mr_main_reset;
input power_on;
input [7:0] tx_o_set;
///////////////
// DISPARITY // 
///////////////
reg tx_disparity;

/////////////////////////////////////////////////////////
// States for PCS transmit code-group diagram Fig 36-6 //
/////////////////////////////////////////////////////////
localparam GENERATE_CODE_GROUPS = 1;
localparam SPECIAL_GO           = 2;
localparam DATA_GO              = 3;
localparam IDLE_DISPARITY_TEST  = 4;
localparam IDLE_DISPARITY_OK    = 5;
localparam IDLE_I2B             = 6;
reg [15:0]cg_timer;
reg cg_timer_done; // Checks if cg_timer is cancelled by the synchronization.
// always@(posedge GTX_CLK) begin
//     cg_timer_done <= 1'b0;
//     cg_timer <= cg_timer + 1'b1;
//     // If the GMII is implemented, cg_timer shall expire 
//     // synchronously with the rising edge of GTX_CLK.
//     if(cg_timer == 15'd7) begin
//         cg_timer <= 15'b0; cg_timer_done <= cg_timer;
//     end 
// end
reg [4:0]pcs_tx_state; // Defines states for tracking current transmit process.
reg [4:0] st;
// reg [7:0] tx_o_set;
reg tx_even;
reg tx_oset_indicate;
reg PUDR;
reg encoder_K;
always@(posedge GTX_CLK) begin
    if(!mr_main_reset) begin
        st <= GENERATE_CODE_GROUPS;
        transmitting <= 1'b0;
        cg_timer <= 15'b0;
        tx_even <= 1'b0;
        encoder_K <= 1'b0;
        tx_code_group <= 10'b0;
    end else st <= pcs_tx_state;
end
always@(*) begin
    pcs_tx_state = st;
    case(st) 
        GENERATE_CODE_GROUPS:
            begin
                tx_oset_indicate = 1'b0;
                if(tx_o_set == `K27_7_oct || tx_o_set == `K23_7_oct || tx_o_set == `K29_7_oct) begin
                    pcs_tx_state = SPECIAL_GO;
                end if (tx_o_set ==`D00_0_oct || 
                        tx_o_set == `D01_0_oct|| 
                        tx_o_set == `D16_2_oct|| 
                        tx_o_set == `D02_0_oct|| 
                        tx_o_set == `D03_0_oct|| 
                        tx_o_set == `D02_2_oct) begin
                    pcs_tx_state = DATA_GO;
                end if (tx_o_set == `K28_5_oct) begin
                    pcs_tx_state = IDLE_DISPARITY_TEST;
                end 
            end
        SPECIAL_GO:
            begin
                if(tx_o_set == `K29_7_oct) begin
                    tx_code_group = `K29_7_dec;
                    pcs_tx_state = GENERATE_CODE_GROUPS;
                end else if (tx_o_set == `K27_7_oct) begin
                    tx_code_group = `K27_7_dec;
                    pcs_tx_state = GENERATE_CODE_GROUPS;
                end else if (tx_o_set == `K30_7_oct) begin
                    tx_code_group = `K30_7_dec;
                    pcs_tx_state = GENERATE_CODE_GROUPS;
                end else if(tx_o_set == `K23_7_oct) begin
                    tx_code_group = `K23_7_dec;
                    pcs_tx_state = GENERATE_CODE_GROUPS;
                end
                tx_even = ~tx_even;
                tx_oset_indicate = 1'b1; // Significado de que se ha transmitido un bloque.
                PUDR = 1'b1; // Se ha completado una transmision de ordered sets.
                
            end
        DATA_GO: 
            begin
                tx_code_group = ENCODE(tx_o_set);
                tx_even = ~tx_even;
                tx_oset_indicate = 1'b1;
                PUDR = 1'b1;
                pcs_tx_state = GENERATE_CODE_GROUPS;
                
            end
        IDLE_DISPARITY_TEST:
            begin
                tx_disparity = 1;
                if(tx_disparity) begin
                    pcs_tx_state = IDLE_DISPARITY_OK;
                end else pcs_tx_state = IDLE_DISPARITY_TEST;
            end

/* LI -> LPI */
        IDLE_DISPARITY_OK:
            begin
                tx_code_group = `K28_5_dec;
                tx_even = 1'b1; // tx_even = TRUE
                PUDR = 1'b1;
                pcs_tx_state = IDLE_I2B;
                
            end       
        IDLE_I2B: begin
            if (tx_o_set == `D16_2_oct) begin
                tx_code_group = `D16_2_dec;
                pcs_tx_state = GENERATE_CODE_GROUPS;
            end
            tx_even = 1'b0;
            tx_oset_indicate = 1'b1;
            PUDR = 1'b1;
            
            
        end
    endcase
    end

//////////////////////////////////////////////////////////
// States for PCS transmit ordered set diagram Fig 36-5 //
//////////////////////////////////////////////////////////

// end

function [9:0] ENCODE(input [7:0] GMII_TXD);
    /* Encoding function for valid Data octets. */
    begin
        if(GMII_TXD == `D00_0_oct) begin
            ENCODE = `D00_0_dec;
        end
        else if (GMII_TXD == `D01_0_oct) begin
            ENCODE = `D01_0_dec;
        end
        else if (GMII_TXD == `D02_0_oct) begin
            ENCODE = `D02_0_dec;
        end
        else if (GMII_TXD == `D03_0_oct) begin
            ENCODE = `D03_0_dec;
        end
        else if (GMII_TXD == `D02_2_oct) begin
            ENCODE = `D02_2_dec;
        end
        else if (GMII_TXD == `D16_2_oct) begin
            ENCODE = `D16_2_dec;
        end
        else if (GMII_TXD == `D26_4_oct) begin
            ENCODE = `D26_4_dec;
        end
        else if (GMII_TXD == `D06_5_oct) begin
            ENCODE = `D06_5_dec;
        end
        else if (GMII_TXD == `D21_5_oct) begin
            ENCODE = `D21_5_dec;
        end
        else if(GMII_TXD == `D05_6_oct) begin
            ENCODE = `D05_6_dec;
        end else begin
            ENCODE = 1'b0;
        end
    end
   
endfunction

// assign tx_code_group = ENCODE(TXD);







endmodule







`endif