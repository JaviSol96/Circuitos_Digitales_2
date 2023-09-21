
`ifndef FUNCTIONS
`define FUNCTIONS

//Including useful files
`include "../../codegroups.v"

//Define true and false values for acepting
`define TRUE 1'b1 
`define FALSE 1'b0

//36.2.4.8 /K28.5/ code-group considerations
`define IS_K28_5(RX_CG) ((RX_CG == `K28_5_dec))

//36.2.4.9 Comma Considerations
`define IS_COMMA(RX_CG) ( \ 
	(RX_CG == `K28_1_dec) || \ 
	(RX_CG == `K28_5_dec) || \ 
	(RX_CG == `K28_7_dec) )

//36.2.4.11 DATA 
`define IS_DATA(RX_CG) ( \ 
	(RX_CG == `D00_0_dec) || \ 
	(RX_CG == `D01_0_dec) || \ 
	(RX_CG == `D02_0_dec) || \ 
	(RX_CG == `D03_0_dec) || \ 
	(RX_CG == `D02_2_dec) || \ 
	(RX_CG == `D16_2_dec) || \ 
	(RX_CG == `D26_4_dec) || \ 
	(RX_CG == `D06_5_dec) || \ 
	(RX_CG == `D21_5_dec) || \ 
	(RX_CG == `D05_6_dec) )

//CONTROL
`define IS_KONTROL(RX_CG) (\ 
	(RX_CG == `K28_0_dec) || \ 
	(RX_CG == `K28_1_dec) || \ 
	(RX_CG == `K28_2_dec) || \ 
	(RX_CG == `K28_3_dec) || \ 
	(RX_CG == `K28_4_dec) || \ 
	(RX_CG == `K28_5_dec) || \ 
	(RX_CG == `K28_6_dec) || \ 
	(RX_CG == `K28_7_dec) || \ 
	(RX_CG == `K23_7_dec) || \ 
	(RX_CG == `K27_7_dec) || \ 
	(RX_CG == `K29_7_dec) || \ 
	(RX_CG == `K30_7_dec) )

`define IS_VALID(RX_CG) ((`IS_DATA(RX_CG)) || (`IS_KONTROL(RX_CG)))

`endif 