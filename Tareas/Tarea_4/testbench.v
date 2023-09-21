`include "Maquina_Estados.v"
`include "tester.v"

module testbench();

    wire SCL;
    wire SDA_OE;
    wire SDA_OUT;
    wire [15:0] RD_DATA;
    wire [15:0] WR_DATA;
    wire START_STB;
    wire [6:0]I2C_ADDR;
    wire clk;
    wire reset;
    wire SDA_IN;
    wire RNW;

    maquina_estado dut (.SCL(SCL), 
                    .SDA_OE(SDA_OE), 
                    .SDA_OUT(SDA_OUT), 
                    .RD_DATA(RD_DATA), 
                    .WR_DATA(WR_DATA), 
                    .START_STB(START_STB), 
                    .I2C_ADDR(I2C_ADDR), 
                    .RNW(RNW), 
                    .clk(clk), 
                    .reset(reset), 
                    .SDA_IN(SDA_IN));

    tester test (.SCL(SCL), 
                    .SDA_OE(SDA_OE), 
                    .SDA_OUT(SDA_OUT), 
                    .RD_DATA(RD_DATA),
                    .WR_DATA(WR_DATA), 
                    .START_STB(START_STB), 
                    .I2C_ADDR(I2C_ADDR), 
                    .RNW(RNW), 
                    .clk(clk), 
                    .reset(reset), 
                    .SDA_IN(SDA_IN));

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(-1, testbench);
        //$monitor("clk = %b, SCL = %b, I2C_ADDR = %b", clk, SCL, I2C_ADDR);
    end


endmodule
