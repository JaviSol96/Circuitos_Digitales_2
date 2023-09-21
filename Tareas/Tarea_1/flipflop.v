/* flip flop tipo D de n bits disparado por flanco
   creciente de clk con entrada de habilitacion enb.
   */
module DFF_nbits_enb #(parameter BITS = 1)
(
    input clk,
    input enb,
    input [BITS-1:0] d,
    output reg [BITS-1:0] q
);

always @(posedge clk) begin
    if (enb == 1'b1)
        q <= d;
end

endmodule