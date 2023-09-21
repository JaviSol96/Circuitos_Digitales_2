`include "Maquina_Estado.v"
`include "tester.v"

module testbench();

    wire MDC;
    wire MDIO_OE;
    wire MDIO_OUT;
    wire [15:0] RD_DATA;
    wire DATA_RDY;
    wire MDIO_START;
    wire [31:0] T_DATA;
    wire clk;
    wire reset;
    wire MDIO_IN;

    maquina_estado dut (.MDC(MDC), 
                    .MDIO_OE(MDIO_OE), 
                    .MDIO_OUT(MDIO_OUT), 
                    .RD_DATA(RD_DATA), 
                    .DATA_RDY(DATA_RDY), 
                    .MDIO_START(MDIO_START), 
                    .T_DATA(T_DATA), 
                    .clk(clk), 
                    .reset(reset), 
                    .MDIO_IN(MDIO_IN));

    tester test (.MDC(MDC), 
                    .MDIO_OE(MDIO_OE), 
                    .MDIO_OUT(MDIO_OUT), 
                    .RD_DATA(RD_DATA), 
                    .DATA_RDY(DATA_RDY), 
                    .MDIO_START(MDIO_START), 
                    .T_DATA(T_DATA), 
                    .clk(clk), 
                    .reset(reset), 
                    .MDIO_IN(MDIO_IN));

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(-1, testbench);
        //$monitor("clk = %b, MDC = %b, MDIO_START = %b", clk, MDC, MDIO_START);
    end


endmodule
