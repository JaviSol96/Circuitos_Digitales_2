`timescale 1ns/1ns


module tester (
    output reg clk, // se asigna el clk como una salida 
    output reg [3:0]D, // se asigna el D como una salida de 4 bits
    output reg [1:0]modo, // se asigna el modo como una salida como salida 2 bits 
    output reg enb, // se asigna el enb como una salida 
    input rco, // se asigna el rco como una entrada 
    input [3:0] Q // se asigna el Q como una entrada de 4 bits 
);

// Creacion del reloj
always begin
    #5 clk =! clk;  // Cada 10 unidades de tiempo vuelve el flanco positivo del reloj
end


/*
    En el siguiente inicial, se inicializan las entradas del contador de 4 bits, tambien se ejecutan las pruebas con el fin de poner 
    en funcionamiento el contador. Cada 10ns representa un cilco positivo del reloj.
*/
/*initial begin  

    $display("Caso Modo 00, Cuenta Ascendente");
    $display("ENB    MODO   D       Q    rco");
    clk = 0; 
    enb = 1'b1; 
    modo = 2'b11;
    D[3:0] = 4'b0000;

    #5; #5;
    
    modo = 2'b00;  // Define el modo cuenta ascendente 
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;

    
    // Vuelve a inicializar las variables para hacer el cambio de modo
    

    $display("Caso Modo 01, Cuenta Descendente");
    $display("ENB    MODO   D       Q    rco");
    enb = 1'b1; 
    modo = 2'b11;
    D[3:0] = 4'b1111;

    #5; #5;

    modo = 2'b01; // Define el modo cuenta descendente 
    
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;

    // Vuelve a inicializar las variables para hacer el cambio de modo

    $display("Caso Modo 10, Cuenta Descendente de 3 en 3");
    $display("ENB    MODO   D       Q    rco");
    enb = 1'b1; 
    modo = 2'b11;
    D[3:0] = 4'b1111;

    #5; #5;


    modo = 2'b10; // Define el modo cuenta descendente de 3 en 3 
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;
    #5; #5;


    // Vuelve a inicializar las variables para hacer el cambio de modo
    $display("Caso Modo 11, Cuenta Paralela");
    $display("ENB    MODO   D       Q    rco");
    enb = 1'b1; 
    modo = 2'b11;
    D[3:0] = 4'bXXXX;

    #5; #5;


    modo = 2'b11; // Define el modo cuenta ascendente carga en paralelo
    D[3:0] = 1'b1; 
    #5; #5;
    D[3:0] = 4'b0000; 
    #5; #5;
    D[3:0] = 4'b0001;
    #5; #5;
    D[3:0] = 4'b0010;
    #5; #5;
    D[3:0] = 4'b0011;
    #5; #5;
    D[3:0] = 4'b0100;
    #5; #5;
    D[3:0] = 4'b0101;
    #5; #5;
    D[3:0] = 4'b0110;
    #5; #5;
    D[3:0] = 4'b0111;
    #5; #5;
    D[3:0] = 4'b1000;
    #5; #5;
    D[3:0] = 4'b1001;
    #5; #5;
    D[3:0] = 4'b1010;
    #5; #5;
    D[3:0] = 4'b1011;
    #5; #5;
    D[3:0] = 4'b1100;
    #5; #5;
    D[3:0] = 4'b1101;
    #5; #5;
    D[3:0] = 4'b1110;
    #5; #5;
    D[3:0] = 4'b1111;
    #5; #5;
    D[3:0] = 4'b0000;


    #20 $finish;  
end  */

endmodule

module tester_16Bits(
                    output reg clk,
                    output reg [1:0]modo,
                    output reg enb,
                    output reg [15:0]D2,
                    input rco1,
                    input rco2,
                    input rco3,
                    input rco4,
                    input [15:0] Q2);


     
    // Creacion del reloj
    always begin
    #5 clk =! clk;  // Cada 10 unidades de tiempo vuelve el flanco positivo del reloj
    end


    //   En el siguiente inicial, se inicializan las entradas del contador de 4 bits, tambien se ejecutan las pruebas con el fin de poner 
    // en funcionamiento el contador. Cada 10ns representa un cilco positivo del reloj.
    initial begin



        $display("Caso Modo 00, Cuenta ascendente");
        $display("ENB    MODO           D                    Q           rco");
        clk = 1'b0; 
        enb = 1'b1; 
        modo = 2'b11;
        D2[15:0] = 16'b0000_0000_0000_1111;
    
        
        #5; #5;
        
        
        modo = 2'b00; // Define el modo cuenta ascendente 
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;


  


        // Vuelve a inicializar las variables para hacer el cambio de modo
        $display("Caso Modo 01, Cuenta Descendente");
        $display("ENB    MODO           D                    Q           rco");
        clk = 0; 
        enb = 1'b1; 
        modo = 2'b11;
        D2[15:0] = 16'hffff;
    
        #5; #5;
        
        
        modo = 2'b01;  // Define el modo cuenta descendente 
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;



        // Vuelve a inicializar las variables para hacer el cambio de modo
        $display("Caso Modo 10, Cuenta Descendente de 3 en 3");
        $display("ENB    MODO           D                    Q           rco");
        clk = 0; 
        enb = 1'b1; 
        modo = 2'b11;
        D2[15:0] = 16'hffff;

        #5; #5;
        
        
        modo = 2'b10;  // Define el modo cuenta descendente 3 en 3 
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;
        #5; #5;



        // Vuelve a inicializar las variables para hacer el cambio de modo
        $display("Caso Modo 11, Cuenta Paralela");
        $display("ENB    MODO           D                    Q           rco");
        clk = 0; 
        enb = 1'b1; 
        modo = 2'b11;
        D2[15:0] = 16'bXXXX_XXXX_XXXX_XXXX;
    
        #5; #5;

        modo = 2'b11;  // Define el modo carga en paralelo
        D2[15:0] = 16'h0001;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
        D2[15:0] += 1'b1;  
        #5; #5;
  

        #20 $finish; 
    end

endmodule   
           
