`include "../../codegroups.v"
// `include "/home/tetra/Documents/UCR/Digitales_II/Grupo-1-Digitales-II-2-2022/src/Receive/DECODE_10B8B.v"
//`include "synchronization.v"
module RECEIVE (
    // Entradas
    input mr_main_reset,
	input clk,
    input [9:0] SUDI,
	input EVEN,
    input xmit,
    // Salidas
    output reg [7:0] RXD,
    output reg RX_DV,
    output reg RX_CLK,
    output reg rx_lpi_active

);


    //definiendo variables internas

    
parameter Wait_for_k = 3'b000;
parameter RX_K   = 3'b001;
parameter IDLE_D  = 3'b010;
parameter Carrier_detect =3'b011;
parameter Start_of_packet = 3'b100;
parameter Receive = 3'b101;
parameter RX_DATA = 3'b110;   
parameter TRI_RRI = 3'b111;   
reg [7:0] nxt_state;
//Final del paquete: check_end = /T/R/K28.5/.
reg check_end_TR_K28_5;
   always @(posedge clk) begin
     if (~mr_main_reset) begin
       check_end_TR_K28_5 <= 0;
       nxt_state <= Wait_for_k;
     end else begin
       check_end_TR_K28_5 <= ((SUDI  == `K29_7_dec)  &&
			       (SUDI == `K23_7_dec) &&
			       (SUDI == `K28_5_dec) && EVEN);
       // nxt_state <= nxt_state;
     end
   end
always @(*) begin
        
        // Estado Wait_for_k  (LISTO)
        if (nxt_state == Wait_for_k)begin
            RX_DV <= 0;
            if (SUDI == `K28_5_dec && EVEN) begin
                nxt_state <= RX_K;
            end
        end

        // Estado RX_K   (LISTO)
        if (nxt_state == RX_K) begin
            RX_DV <= 0;
            if (SUDI==`K28_5_dec && xmit==1'b1) begin
                
            end
            nxt_state <= IDLE_D;
        end

        // Estado IDLE_D (LISTO)
        if (nxt_state == IDLE_D) begin
            $display("Funca");
            RX_DV <= 0;
            //rx_lpi_active <= 0;
            nxt_state = Carrier_detect;
        end

        // Estado CARRIER_DETECT (LISTO)
        //Tener en cuenta lo de /S/: K27.7, caracter de inicio.
        if (nxt_state == Carrier_detect) begin
            nxt_state <= Start_of_packet; // Pasa directo a Start_of_packet.

        end
//Parte b).
        // Estado Start_of_packet  (LISTO)
        if (nxt_state == Start_of_packet) begin
            RX_DV <= 1;
            RXD <= 8'b0101_0101;
            nxt_state <= Receive;
        end

        // RECEIVE (REVISAR)
        if (nxt_state == Receive) begin
//Se busca si hay datos válidos.
            if (SUDI == `K28_5_dec) begin
                    nxt_state <= RX_DATA;
                    
                end

//Como no hay más datos, entonces aquí se hace el check_end 
// y luego se pasa al estado 111.
            else if (check_end_TR_K28_5) begin
                
                nxt_state <= TRI_RRI;
            end

        end

//Como no hay más datos, entonces aquí se hace el check_end 
// y luego se pasa al estado 111.
            else if (check_end_TR_K28_5) begin
                nxt_state <= TRI_RRI;
            end

       

        // Aquí se reciben los códigos de 10 bits
        if (nxt_state==RX_DATA) begin
            nxt_state <= Receive;
            case (SUDI)
            `D00_0_dec : begin RXD <= `D00_0_oct;end 

            `D01_0_dec : begin RXD <= `D01_0_oct;end

            `D02_0_dec : begin RXD <= `D02_0_oct;end

            `D03_0_dec : begin RXD <= `D03_0_oct;end

            `D02_2_dec :begin  RXD <= `D02_2_oct;end

            `D16_2_dec : begin RXD <= `D16_2_oct;end
            
            `D26_4_dec : begin RXD <= `D26_4_oct;end

            `D06_5_dec : begin RXD <= `D06_5_oct;end

            `D21_5_dec :begin RXD <= `D21_5_oct;end

            `D05_6_dec : begin RXD <= `D05_6_oct;end
            //default : nxt_state <= Receive;
        endcase

        end
//Aquí inicia la decodificación:
        /*    if (SUDI == `D00_0_dec) begin    
	        	RXD <= `D00_0_oct;
            end
    
	        else if (SUDI == `D01_0_dec) begin
                RXD <= `D01_0_oct;
            end

            // else if (SUDI == `D01_0_dec) begin
            //     RXD <= `D01_0_oct;
            // end

            else if (SUDI == `D02_0_dec) begin
                RXD <= `D02_0_oct;
            end

            else if (SUDI == `D03_0_dec) begin
                RXD <= `D03_0_oct;
            end

            else if (SUDI == `D02_2_dec) begin
                RXD <= `D02_2_oct;
            end

            else if (SUDI == `D16_2_dec) begin
                RXD <= `D16_2_oct;
                nxt_state <= Receive;
            end

            else if (SUDI == `D26_4_dec) begin
                RXD <= `D26_4_oct;
            end

            else if (SUDI == `D06_5_dec) begin
                RXD <= `D06_5_oct;
            end
    
            else if (SUDI == `D21_5_dec) begin
                RXD <= `D21_5_oct;
            end

            else if(SUDI == `D05_6_dec) begin
                RXD <= `D05_6_oct;
            end*/
            
        //Esto es la terminación del paquete. Por lo que se debe recibir una coma 
        //-para poder ir de nuevo a la etiqueta B: RX_K. 
        if (nxt_state==TRI_RRI) begin
            RX_DV <= 0;
            nxt_state <= RX_K;
            //if (nxt_state == `K28_5_oct) begin 
              
            //end

        end
        
end


endmodule

