module maquina_estado  (input clk,
                        input reset, 
                        input MDIO_START,
                        input MDIO_IN, 
                        input [31:0]T_DATA, 
                        output reg MDC, 
                        output reg MDIO_OUT, 
                        output reg MDIO_OE, 
                        output reg [15:0]RD_DATA,
                        output reg DATA_RDY);

    // Los estados de la Maquina de estados
    // Estado ST        --> 000
    // Estado OP        --> 001
    // Estado PHYADR    --> 010
    // Estado REGADR    --> 011
    // Estado TA        --> 100
    // Estado DATA lec  --> 101
    // Estado DATA esc  --> 110



    reg [1:0] ST;
    reg [1:0] OP;
    reg [4:0] PHYADR;
    reg [4:0] REGADR;
    reg [1:0] TA;
    reg [15:0] DATA_read;
    reg [15:0] DATA_write;

    reg [31:0] q;
    reg [15:0] temp;
    reg [5:0] counter;
    reg [2:0] state; 
    reg [4:0] count;



    // Clock Divider
    always @ (posedge(clk))
    begin
        if (~reset) begin   
            MDC <= 0;
        end else begin 
            MDC <= !MDC;
        end
    end

    // Si reset no es igual a 1, pone las salidas en 0.
    always @(posedge clk) begin
        if (~reset) begin
            RD_DATA <= 16'h0000;
            MDIO_OE <= 1'b0;
            MDIO_OUT <= 1'b0;
            DATA_RDY <= 1'b0;
            temp = 16'h0000;
        end

    end

    always @(posedge MDC) begin

        ST = T_DATA [31:30];
        OP = T_DATA [29:28];
        PHYADR = T_DATA [27:23];
        REGADR = T_DATA [22:18];
        TA = T_DATA [17:16];
        q <= 32'b00000000000000000000000000000000;
        state = 3'b000;

        if (reset == 1) begin

            counter <= 32'b00000;
            q <= T_DATA;

            if (MDIO_START) begin

                counter <= counter+1;
                MDIO_OUT <= q[0];
                q<=q>>1;

                
                    
                    //Primer Estado ST
                if (state == 3'b000)begin 
                    if (ST == 2'b01) begin
                        state = 3'b001;
                    end else begin
                        state = 3'b000;
                    end
                end

                    // Segundo Estado OP
                if (state == 3'b001) begin
                    if (OP == 2'b01 || OP == 2'b10) begin
                        state = 3'b010;
                    end 
                end else begin
                    state = 3'b000;
                end
                
                    // Tercer Estado PHYADR
                if (state == 3'b010) begin 
                    state = 3'b011;
                end

                    // Cuarto Estado REGADR
                if (state == 3'b011) begin 
                    state = 3'b100;
                end

                    // Quinto Estado TA y se divide en Escritura o Lectura
                if (state == 3'b100) begin
                    if (OP == 2'b01) begin
                    // Caso para escribir
                        state = 3'b101;
                    end else if (OP == 2'b10) begin
                    // Caso para lectura
                        state = 3'b110;
                        end
                    end
                            

                    // Sexto Estado, Escritura
                if (state == 3'b101) begin
                    DATA_write = T_DATA [15:0];          
                    MDIO_OE = 1'b1;
            
                    if (counter > 31) begin
                        MDIO_OE <= 1'b0;
                    end
                end                
                

                    // Septimo Estado, Lectura
                if (state == 3'b110) begin
                    DATA_read = T_DATA [15:0];
                    MDIO_OE <= 1'b1;
                    DATA_RDY <=1'b0;
                    if (counter >= 5'b01111) begin
                        MDIO_OE <= 1'b0;
                    end

                    if (counter >= 5'b01111 && counter < 5'b11111) begin
                            DATA_RDY <=1'b1;
                    end

                    // Se hace la carga de paralelo a serie
                    temp <= temp << 1;
                    temp[0] <= MDIO_IN;

                    if (MDIO_OE == 1'b0 && DATA_RDY == 1) begin
                       RD_DATA <= temp;
                    end
                            
                    if (count >= 31) begin
                    // transaccion se ha realizado exitosamente.
                        MDIO_OE <= 1'b0;                
                    end
                end
            end
        end    
    end
endmodule
