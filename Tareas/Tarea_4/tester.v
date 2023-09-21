module tester (
    input SCL,
    input SDA_OUT,
    input SDA_OE,
    input [15:0] RD_DATA,
    output reg START_STB,
    output reg [15:0] WR_DATA,
    output reg [6:0]I2C_ADDR,
    output reg clk,
    output reg reset,
    output reg RNW,
    output reg SDA_IN
);


always begin
    clk = 0; #1;
    clk = 1; #1;
end

initial begin
    // Prueba 1: reiniciar los registros y salidas
    reset = 0; #1; #1; 
    #1; #1; #1;
    #1; #1; #1;
    reset = 1; #1; #1;
end

// Instrucciones para el generador de transacciones

initial begin

  
     // Initialize reset
    reset = 0;
    WR_DATA = 15'b000000000000000;
    I2C_ADDR = 7'b0000000;
    RNW = 0;
    SDA_IN = 0;
    START_STB = 0;
    #8;

    // Prueba Prueba de escritura.
    reset = 1;
    START_STB = 1;
    #2; 
    START_STB = 0;
    I2C_ADDR = 7'b0111111;
    RNW = 0;
    #80;  
    WR_DATA = 15'b000010001010111;
    #500;

    // Se resetea la senal 
    reset = 0;
    START_STB = 0;
    I2C_ADDR = 7'b0000000;
    #8;

    // Prueba de lectura
    reset = 1;
    START_STB = 1;
    #2;
    START_STB = 0;
    I2C_ADDR = 7'b0111111;
    RNW = 1;
    #100;  
    #2;

    SDA_IN = 1; #40;
    SDA_IN = 1; #40;
    SDA_IN = 1; #40;
    SDA_IN = 1; #40;
    SDA_IN = 0; #40;
    SDA_IN = 0; #40;
    SDA_IN = 1; #40;
    SDA_IN = 1; #40;
    SDA_IN = 0; #40;
    SDA_IN = 0; #40;
    SDA_IN = 1; #40;
    SDA_IN = 0; #40;
    SDA_IN = 1; #40;
    SDA_IN = 1; #40;
    SDA_IN = 0; #40;
    SDA_IN = 1; #40;

    #1000;
    $finish;
end

endmodule