`ifndef codegroups
`define codegroups

//valid data code group
// define code_group_name octet_value
`define D00_0_oct 8'h00
`define D01_0_oct 8'h01
`define D02_0_oct 8'h02
`define D03_0_oct 8'h03
`define D02_2_oct 8'h42
`define D16_2_oct 8'h50
`define D26_4_oct 8'h9A
`define D06_5_oct 8'hA6
`define D21_5_oct 8'hB5
`define D05_6_oct 8'hC5

`define D00_0_dec 10'b01_1000_1011
`define D01_0_dec 10'b10_0010_1011
`define D02_0_dec 10'b01_0010_1011
`define D03_0_dec 10'b11_0001_0100
`define D02_2_dec 10'b01_0010_0101
`define D16_2_dec 10'b10_0100_0101
`define D26_4_dec 10'b01_0110_0010
`define D06_5_dec 10'b01_1001_1010
`define D21_5_dec 10'b10_1010_1010
`define D05_6_dec 10'b10_1001_0110


//valid special group
// define code_group_name octet_value
`define K28_0_oct 8'h1C
`define K28_1_oct 8'h3C
`define K28_2_oct 8'h5C
`define K28_3_oct 8'h7C
`define K28_4_oct 8'h9C
`define K28_5_oct 8'hBC
`define K28_6_oct 8'hDC
`define K28_7_oct 8'hFC
`define K23_7_oct 8'hF7 // /R/
`define K27_7_oct 8'hFB // /S/
`define K29_7_oct 8'hFD // /T/
`define K30_7_oct 8'hFE // /V/

`define K28_0_dec 10'b11_0000_1011
`define K28_1_dec 10'b11_0000_0110
`define K28_2_dec 10'b11_0000_1010
`define K28_3_dec 10'b11_0000_1100
`define K28_4_dec 10'b11_0000_1101
`define K28_5_dec 10'b11_0000_0101 
`define K28_6_dec 10'b11_0000_1001
`define K28_7_dec 10'b11_0000_0111
`define K23_7_dec 10'b00_0101_0111 
`define K27_7_dec 10'b00_1001_0111 
`define K29_7_dec 10'b01_0001_0111 
`define K30_7_dec 10'b10_0001_0111 

`endif