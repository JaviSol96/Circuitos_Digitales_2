`ifndef MACROS_SYNC_MACH
`define MACROS_SYNC_MACH

`include "/home/tetra/Documents/UCR/Digitales_II/Grupo-1-Digitales-II-2-2022/src/Synchronization/rx_considerations.v"
`include "../../codegroups.v"


`define shift_left(BITS , x) (BITS << x)
`define STATES_sync    `num_states_sync'h1


`define num_states_sync 13 //Thirteen states in total
`define LOSS_OF_SYNC        `shift_left(`STATES_sync , 0)
`define COMMA_DETECT_1      `shift_left(`STATES_sync , 1)
`define ACQUIRE_SYNC_1      `shift_left(`STATES_sync , 2)
`define COMMA_DETECT_2      `shift_left(`STATES_sync , 3)
`define ACQUIRE_SYNC_2      `shift_left(`STATES_sync , 4)
`define COMMA_DETECT_3      `shift_left(`STATES_sync , 5)
`define SYNC_ACQUIRED_1     `shift_left(`STATES_sync , 6)
`define SYNC_ACQUIRED_2     `shift_left(`STATES_sync , 7)
`define SYNC_ACQUIRED_2A    `shift_left(`STATES_sync , 8)
`define SYNC_ACQUIRED_3     `shift_left(`STATES_sync , 9)
`define SYNC_ACQUIRED_3A    `shift_left(`STATES_sync , 10)
`define SYNC_ACQUIRED_4     `shift_left(`STATES_sync , 11)
`define SYNC_ACQUIRED_4A    `shift_left(`STATES_sync , 12)

`define OK 1'b1
`define FAIL 1'b0

//
`define COMMA_DETECT(state) (\ 
	(state == `COMMA_DETECT_1) || \ 
	(state == `COMMA_DETECT_2) || \ 
	(state == `COMMA_DETECT_3) )

//36.2.5.1.3 Variables
//cgbad = ((rx_code-group/INVALID/) + (rx_code-group=/COMMA/*rx_even=TRUE)) * PMA_UNITDATA.indication
`define cgbad(RX_CG, RX_EVEN) ((!`IS_VALID(RX_CG) || (`IS_COMMA(RX_CG) && RX_EVEN)))

//cggood =  !((rx_code-group/INVALID/) + (rx_code-group=/COMMA/*rx_even=TRUE)) * PMA_UNITDATA.indication
`define cggood(RX_CG, RX_EVEN) ((!`cgbad(RX_CG, RX_EVEN)))

//36.2.5.1.4 Functions
module signal_detect_CHANGE (
    input clk,
    input signal_detect,
    output reg signal_detectCHANGE
);
    reg signal_detect_old;

    always @(posedge clk ) begin
            signal_detect_old <= signal_detect;
    end

    always @(*) begin
        if (signal_detect == signal_detect_old)
            signal_detectCHANGE = `FALSE;
        else
            signal_detectCHANGE = `TRUE;
    end
endmodule


`endif