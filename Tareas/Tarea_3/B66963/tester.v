module tester (
    input MDC,
    input MDIO_OE,
    input MDIO_OUT,
    input [15:0] RD_DATA,
    input DATA_RDY,
    output reg MDIO_START,
    output reg [31:0] T_DATA,
    output reg clk,
    output reg reset,
    output reg MDIO_IN
);


always begin
    clk = 1'b0; #0.5;
    clk = 1'b1; #0.5;

end

initial begin
    // Prueba 1: reiniciar los registros y salidas
    reset = 1'b0; #1; #1; 
    #1; #1; #1;
    reset = 1'b1; #1; #1;
end

// Instrucciones para el generador de transacciones

initial begin
    MDIO_START = 1'b0;
    MDIO_IN = 1'b0;

    // Prueba 2: Palabra que no cumple con ST = 01 (start of frame)
    T_DATA = 32'b11101001100110100101110101101111; #1; #1; 
    #8;
    MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    #160;



    // Prueba 3: lectura
    MDIO_START = 1'b0; #1; #1;
    T_DATA = 32'b01101001100110100101110101101111; 
    MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    #160;
 



    MDIO_START = 1'b0; #1; #1;
    T_DATA = 32'b01011001100110100101110101101111; // Escritura
    MDIO_START = 1'b1; #1; #1; // pulso MDIO_START: indica el inicio de transmisión de datos
    #160;

end


initial begin
    #175;
    MDIO_IN = 1'b0; #1; #1; #1; #1; 
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1; 
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    MDIO_IN = 1'b1; #1; #1; #1; #1;
    MDIO_IN = 1'b0; #1; #1; #1; #1;
    #610;
    $finish;
end

endmodule