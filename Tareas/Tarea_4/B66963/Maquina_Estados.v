module maquina_estado  (input clk,
                        input reset, 
                        input START_STB,
                        input RNW,
                        input SDA_IN,
                        input [6:0]I2C_ADDR,
                        input [15:0]WR_DATA, 
                        output SCL, 
                        output reg SDA_OUT, 
                        output reg SDA_OE, 
                        output reg [15:0]RD_DATA);

    // Los estados:

    // IDLE             -->     0000
    // START            -->     0001
    // SLAVE ADDRESS    -->     0010 
    // Read/write       -->     0011
    // ACK              -->     0100
    // DATA_W           -->     0101
    // DATA_R           -->     0110
    // A_W              -->     0111
    // A_R              -->     1000
    // DATA_R_2         -->     1001
    // NA               -->     1010
    // P                -->     1111

    
    
    reg [3:0] state;
    reg [15:0] Count;
    reg RW;
    reg [15:0] guardar_data;



    reg [3:0] q = 4'b0000;
    always@(posedge clk) begin
        q = q + 1'b1;
    end
    assign SCL = q[2];

    // Si reset no es igual a 1, pone las salidas en 0.
    always @(posedge clk) begin
        if (~reset) begin
            RD_DATA <= 16'h0000;
            SDA_OUT <= 0;
            SDA_OE <= 1'b0;
            state <= 4'b0000;
            Count <= 7'b0000000;
            Count <= 16'd16;
        end
    end

    always @(posedge SCL)begin

        if (reset) begin


                // Estado #1, IDLE
            if (state == 4'b0000)begin
                SDA_OUT <= 0;
                state <= 4'b0001; 
                SDA_OE <= 0;
            end

                // Estado #2, START
            if (state == 4'b0001) begin
                state <= 4'b0010;
                Count <= 6;    
                SDA_OE <= 0;     // Este contador leer el MSB del I2C_ADDR
                SDA_OUT <= 1;
            end

                // Estado #3, SALVE ADDRESSS
            if (state == 4'b0010)begin
                
                state <= 4'b0010;
                SDA_OUT <= I2C_ADDR[Count]; // Convierte el I2C ADDR en serie y lo pone en SDA OUT
                SDA_OE <= 1;

                if (Count == 0) begin
                    state <= 4'b0011;
                end else begin
                    Count <= Count - 1;
                end
            end

                // Estado #4, Read/write
            if (state == 4'b0011)begin
                SDA_OE <= 0;
                SDA_OUT <= RNW;  // Se pone en alto cuando hay una transaccion de lectura
                state <= 4'b0100;
            end

                // Estado #5, ACK
            if (state == 4'b0100) begin
                RW = RNW;
                SDA_OUT <= 1;
                if (RW == 0)begin   // Modo de Escritura
                    state <= 4'b0101; 
                    Count <= 7;
                    guardar_data <= WR_DATA[15:8];
 
              
                end else if (RW == 1) begin  // Modo de Lectura
                    state <= 4'b0110;
                    Count <= 7;

                end
            end

                // Estado #6, estado de escritura (DATA_WRITE)
            if (state == 4'b0101) begin
                SDA_OUT <= guardar_data[Count];  // Convierte el WR DATA  en serie y lo pone en SDA OUT
                if (Count == 0) begin              // Para los primeros 8 bits
                    state <= 4'b0111;
                end else begin
                    Count <= Count - 1;
                end

            end

                // Estado #7, estado de lectura (DATA_READ)
            if (state == 4'b0110) begin
                RD_DATA[Count] <= SDA_IN;   // Convierte el SDA IN en paralelo y lo pone en RD DATA
                SDA_OUT <= RD_DATA[Count];  // para los primeros 8 bits
                if (Count == 0) begin
                    state <= 4'b1000;
                end else begin
                    Count <= Count - 1;
                end

            end

                // Estado #8, ACK de escritura
            if (state == 4'b0111) begin
                SDA_OUT <= 1;
                SDA_OE <= 0;
                state <= 4'b1001;
                guardar_data <= WR_DATA[7:0];
                Count <= 7;
            end

                // Estado #9, ACK de Lectura
            if (state == 4'b1000) begin
                SDA_OUT <= 1;
                SDA_OE <= 0;
                state <= 4'b1010;
                Count <= 7;
            end

                // Estado #10, DATA_W_COMPLETO
            if(state == 4'b1001) begin
                SDA_OUT <= guardar_data[Count];  // Convierte el WR DATA  en serie y lo pone en SDA OUT
                SDA_OE <= 1;                    // para los ultimos 8 bits, completando los 16 bits

                if (Count == 0) begin
                    state <= 4'b1011;
                end else begin
                    Count <= Count - 1;
                end
            end

                // Estado #11, DATA_R_COMPLETO
            if (state == 4'b1010) begin
                RD_DATA[Count] <= SDA_IN;   // Convierte el SDA IN en paralelo y lo pone en RD DATA
                SDA_OUT <= RD_DATA[Count];  // para los ultimos 8 bits, completando los 16 bits

                if (Count == 0) begin
                    state <= 4'b1011;
                end else begin
                    Count <= Count - 1;
                end
            end

                // Estado #12, ACK_NEG
            if (state == 4'b1011) begin
                SDA_OUT <= 0;
                state <= 4'b1111;
            end

                // Estado #13, STOP
            if (state == 4'b1111) begin
                SDA_OUT <= 1;
                state <= 4'b0000; // Vuelve al estado inicial.
            end 

        end


    end

endmodule