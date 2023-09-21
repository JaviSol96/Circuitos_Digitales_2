`include "Counter_synth_rtlil.v"
`include "tester.v"




//  Banco de pruebas para el contador de 4 bits


module tb_Counter; // Modulo para el contador de 4 Bits

    wire clk;                     
    wire [3:0]D;                     
    wire [3:0] Q;
    wire [1:0] modo;
    wire enb;
    wire rco;             
 

    // se instancia el contador de 4 bits que se encuentra en el archivo Counter.v
    tester prueba (.clk(clk), .D(D), .Q (Q), .modo (modo), .enb (enb), .rco(rco));
    // se instancia el probador de 4 bits que se encuentra en el archivo tester.v
    counter DUT4 (.clk(clk), .D(D), .Q (Q), .modo (modo), .enb (enb), .rco(rco)); 


  //  Para imprimir en consola los valores de enb, modo, D2, Q2. rco1
 
    always @(posedge clk) begin
    $display(" %b     %b   %b    %b     %b", enb, modo, D, Q, rco);
    end




 //   Para visualizar el gtkwave del contador de 4 bits

    /*initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end*/

endmodule 



 // Banco de pruebas para el contador de 16 bits


module tb_Counter_16Bit; // Modulo para el contador de 16 Bits

    wire clk;                     
    wire [15:0]D2;                    
    wire [1:0] modo;
    wire [15:0] Q2;
    wire enb;
    wire rco1;
    wire rco2;
    wire rco3;
    wire rco4; 



    // se instancia el contador de 16 bits que se encuentra en el archivo Counter.v
    Counter16 DUT16 (.clk(clk),.D2(D2),.Q2(Q2),.modo(modo),.enb(enb),.rco1(rco1),.rco2(rco2),.rco3(rco3),.rco4(rco4)); 

    // se instancia el Probador de 16 bits que se encuentra en el archivo tester.v
    tester_16Bits prueba16 (.clk(clk), .D2(D2), .Q2(Q2), .modo(modo), .enb(enb),.rco1(rco1),.rco2(rco2),.rco3(rco3),.rco4(rco4));


    //Para imprimir en consola los valores de enb, modo, D2, Q2. rco1

    always @(posedge clk) begin
    $display(" %b     %b      %b    %b     %b ", enb, modo, D2, Q2, rco1);
    end



   // Para visualizar el gtkwave del contador de 16 bits

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end


endmodule    