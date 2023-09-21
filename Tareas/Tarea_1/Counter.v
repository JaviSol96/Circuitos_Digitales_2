`include "flipflop.v"

module counter (input clk,  //se asigna el clk como una entrada
                input enb,  // se asigna el enb como una entrada
                input [1:0]modo,      // se asigna en modo como una entrada de 2 bits  
                input [3:0]D,      // se asigna el D como una entrada de 4 bits       
                output [3:0] Q,  // se asigna el Q como una salida de 4 bits
                output rco);    // se asigna el rco (Ripple-Carry Out) como una salida
  
    reg [3:0] D_In; // Registro de 4 bits para la salida Q
    reg D_Out; // Registro de 1 bit para la salida rco


    /*
        El siguiete codigo es para poder seleccionar el modo en que se quiere usar el contador
        ya que modo es de 2 bits, se tiene 4 posibilidades de seleccion (00,01,10,11), entonces se 
        dividen por casos, el caso 00 es una cuenta ascendente, para el caso 01 es una cuenta descendente,
        para el caso 10 es una cuenta descendente de 3 en 3 y para el caso 11 es una carga en paralelo.
    */
  
  always @* begin  
    case ({modo[1:0]})

    //  Caso con el modo 00, cuenta ascendente

        2'b00 : begin   if (enb == 1) begin  // Este if se asegura que el codigo funcione siempre que el enb este en 1
                                        D_In = Q + 1;
                                        if (Q == 4'b1111) begin  // Este if se encarga de activar el RCO siempre que haya uno de lo contrario va a estar en 0.
                                        D_Out = 1;
                                        end else begin
                                        D_Out = 0;
                                        end 
                                    end   
                            end     
        
        //  Caso con el modo 01, cuenta Descendente

        2'b01 : begin   if (enb == 1) begin
                                        D_In = Q - 1;
                                        if (Q == 4'b0000) begin  // Este if se encarga de activar el RCO siempre que haya uno de lo contrario va a estar en 0.
                                        D_Out = 1;
                                        end else begin
                                        D_Out = 0;
                                        end  
                                    end
                        end 
          
        //  Caso con el modo 10, cuenta descendente de 3 en 3

        2'b10 : begin   if (enb == 1) begin
                                D_In = Q - 3;
                                if (Q == 4'b0000 || Q == 4'b0001 || Q == 4'b0010) begin //Este if activa el RCO, cuando la resta -3 tiene un rco
                                  D_Out = 1;
                              end else begin
                                  D_Out = 0;
                              end   
                          end
                    end    

        //  Caso con el modo 11

        2'b11 : begin  D_In = D;   // Carga en paralelo.
                if (D == 4'b0000) begin
                    D_Out = 1;    
                end else begin
                    D_Out = 0;
                end
                

        end 
        
        default : begin D_In = D_In; end // Si no hay cambio de modo, se mantiene.

    endcase
  end

  // se intancia 2 flipflops, uno para la salida y otro para el RCO, de manera que el programa funcione siempre que 
  // el enable este en alto.
  DFF_nbits_enb #(.BITS(4)) DFF_4bits(.clk(clk), .enb(enb), .d(D_In[3:0]), .q(Q[3:0])); // Registro de 4 bits para Q[3:0]
  DFF_nbits_enb DFF_1bit(.clk(clk), .enb(enb), .d(D_Out), .q(rco)); // Registro de 1 bits para RCO
 


endmodule  

/*
En el siguiente modulo, se instancia 4 veces el contador de 4 bits, con el fin de construir un contador de 16 bits, de manera que 
se asigna un reloj nuevo a cada uno de los contadores, entonces para el contador 1 este va a tener el reloj normal, para el contador 2, este reloj se
va a activar siempre cuando se active el rco del contador 1, para el reloj del contador 3 se activa cuando el rco del contador 2 se activa y 
para el reloj del contador 4 se activa cuando el rco del contador 3 se activa.
*/

module Counter16( input clk,
                  input enb,
                  input [1:0]modo,      
                  input [15:0]D2,              
                  output [15:0]Q2,
                  output rco1,
                  output rco2,
                  output rco3,
                  output rco4);
    
    wire clk2;
    wire clk3;
    wire clk4;
    wire modo_11;

    assign modo_11 = (modo == 2'b11); 
    assign clk2 = clk && modo_11 || rco1 && !modo_11; // Usa el reloj o usa como reloj el RCO, esto para el contador 2
    assign clk3 = clk && modo_11 || rco2 && !modo_11; // Usa el reloj o usa como reloj el RCO, esto para el contador 3
    assign clk4 = clk && modo_11 || rco3 && !modo_11; // Usa el reloj o usa como reloj el RCO, esto para el contador 4


    //En la siguientes lineas de codigo es donde se instancia el 4 contadores de 4 bits.
    counter contador1(.clk(clk), .enb(enb), .modo(modo[1:0]), .D(D2[3:0]), .Q(Q2[3:0]),.rco(rco1));
    counter contador2(.clk(clk2), .enb(enb), .modo(modo[1:0]), .D(D2[7:4]), .Q(Q2[7:4]),.rco(rco2));
    counter contador3(.clk(clk3), .enb(enb), .modo(modo[1:0]), .D(D2[11:8]), .Q(Q2[11:8]),.rco(rco3));    
    counter contador4(.clk(clk4), .enb(enb), .modo(modo[1:0]), .D(D2[15:12]), .Q(Q2[15:12]),.rco(rco4));


endmodule 
