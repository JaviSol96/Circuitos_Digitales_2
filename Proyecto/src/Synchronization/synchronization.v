`ifndef SYNCH_H
`define SYNCH_H
`include "/home/tetra/Documents/UCR/Digitales_II/Grupo-1-Digitales-II-2-2022/src/Synchronization/rx_considerations.v"
`include "/home/tetra/Documents/UCR/Digitales_II/Grupo-1-Digitales-II-2-2022/src/Synchronization/mstates_define.v"
`include "../../codegroups.v"

module SYNCH
#(
    parameter WIDTH = 10, num_states = 13
    
)
(
    //INPUTS
    input clk       , 
    input mr_loopback       ,
    input mr_main_reset     ,
    input signal_detect     , 
    input [WIDTH-1:0] code_group    ,

    //OUTPUTS
    output reg code_sync_status     ,
    output reg [WIDTH-1:0] SUDI     ,
    output reg rx_even

);

//WIRES and REGS
wire signal_detectCHANGE    ;
reg [num_states-1:0] state  ;
reg [num_states-1 :0] nxt_state   ;
reg [1:0] good_cgs  ;


//Function from mstates_define.v
signal_detect_CHANGE signal (
    .clk(clk) ,
    .signal_detect(signal_detect)   ,
    .signal_detectCHANGE(signal_detectCHANGE) 
);

always @(posedge clk)
begin
	if (!mr_main_reset || (signal_detectCHANGE && !mr_loopback))
	begin
		state  = `LOSS_OF_SYNC;
		code_sync_status = `FAIL;
		good_cgs = 2'b00;
		rx_even = `FALSE;
	end
	else begin
		SUDI <= code_group;
		state  = nxt_state;
		if (`COMMA_DETECT(state)) rx_even = `TRUE;
		else rx_even = !rx_even;
	end
end

always @(*) begin
  nxt_state = state;

	case(state) 
		//Lost of sync
		`LOSS_OF_SYNC: begin
			code_sync_status <= `FAIL;

			if (!`IS_COMMA(code_group) || (!signal_detect && !mr_loopback))
				nxt_state = `LOSS_OF_SYNC;
			
			else if (`IS_COMMA(code_group) && (signal_detect || mr_loopback))
				nxt_state = `COMMA_DETECT_1;
		end

		// COMMA_DETECT_1
		`COMMA_DETECT_1: begin
			if (`IS_DATA(code_group))
				nxt_state = `ACQUIRE_SYNC_1;
			
			else
				nxt_state = `LOSS_OF_SYNC;
		end

		//ACQUIRE_SYNC_1
		`ACQUIRE_SYNC_1: begin
			if (!rx_even && `IS_COMMA(code_group))
				nxt_state = `COMMA_DETECT_2;

			else if (!`IS_COMMA(code_group) && `IS_VALID(code_group))
				nxt_state = `ACQUIRE_SYNC_1;
			
			else if (`cgbad(code_group, rx_even))
				nxt_state = `LOSS_OF_SYNC;
		end

		// COMMA_DETECT_2
		`COMMA_DETECT_2: begin
			if (`IS_DATA(code_group))
				nxt_state = `ACQUIRE_SYNC_2;
			
			else
				nxt_state = `LOSS_OF_SYNC;
		end

		// ACQUIRE_SYNC_2
		`ACQUIRE_SYNC_2: begin
			if (!rx_even && `IS_COMMA(code_group))
				nxt_state = `COMMA_DETECT_3;
			
			else if (!`IS_COMMA(code_group) && `IS_VALID(code_group))
				nxt_state = `ACQUIRE_SYNC_2;

			else if (`cgbad(code_group, rx_even))
				nxt_state = `LOSS_OF_SYNC;
		end

		// COMMA_DETECT_3
		`COMMA_DETECT_3: begin
			if (`IS_DATA(code_group))
				nxt_state = `SYNC_ACQUIRED_1;

			else
				nxt_state = `LOSS_OF_SYNC;
		end

		// SYNC_ACQUIRE_1
		`SYNC_ACQUIRED_1: begin
			code_sync_status = `OK;

			if (`cggood(code_group, rx_even))
				nxt_state = `SYNC_ACQUIRED_1;
			
			else
				nxt_state = `SYNC_ACQUIRED_2;
		end

		// SYNC_ACQUIRE_2
		`SYNC_ACQUIRED_2: begin
			good_cgs = 0;

			if (`cggood(code_group, rx_even))
				nxt_state = `SYNC_ACQUIRED_2A;

			else
				nxt_state = `SYNC_ACQUIRED_3;
		end

		// SYNC_ACQUIRE_2A
		`SYNC_ACQUIRED_2A: begin
			good_cgs = good_cgs + 1;

			if (`cggood(code_group, rx_even)) begin
				if (good_cgs == 3)
					nxt_state = `SYNC_ACQUIRED_1;
				else
					nxt_state = `SYNC_ACQUIRED_2A;
			end 
			else
				nxt_state = `SYNC_ACQUIRED_3;
		end

		// SYNC_ACQUIRE_3
		`SYNC_ACQUIRED_3: begin
			good_cgs = 0;

			if (`cggood(code_group, rx_even))
				nxt_state = `SYNC_ACQUIRED_3A;
			
			else
				nxt_state = `SYNC_ACQUIRED_3;
		end

		// SYNC_ACQUIRE_3A
		`SYNC_ACQUIRED_3A:  begin
			good_cgs = good_cgs + 1;

			if (`cggood(code_group, rx_even)) begin
				if (good_cgs == 3)
					nxt_state = `SYNC_ACQUIRED_2;

				else
					nxt_state = `SYNC_ACQUIRED_3A;
			end
			else
				nxt_state = `SYNC_ACQUIRED_4;
		end

		// SYNC_ACQUIRE_4
		`SYNC_ACQUIRED_4:  begin 
			good_cgs = 0;

			if (`cggood(code_group, rx_even))
				nxt_state = `SYNC_ACQUIRED_4A;
			
			else
				nxt_state = `LOSS_OF_SYNC;
		end

		// SYNC_ACQUIRE_4A
		`SYNC_ACQUIRED_4A:  begin
			good_cgs = good_cgs + 1;

			if (`cggood(code_group, rx_even)) begin
				if (good_cgs == 3)
					nxt_state = `SYNC_ACQUIRED_3;

				else
					nxt_state = `SYNC_ACQUIRED_4A;
			end
			else
				nxt_state = `LOSS_OF_SYNC;
		end

		default: nxt_state = `LOSS_OF_SYNC; 
	endcase
end 

endmodule

`endif