module DECODE_10B8B;



        if (RX_DATA) begin

//Aquí inicia la decodificación:
            if (SUDI == `D00_0_dec) begin    
	        	RXD <= 8'h00;
            end
    
	        else if (SUDI == `D01_0_dec) begin
                RXD <= 8'h01;
            end

            else if (SUDI == `D01_0_dec) begin
                RXD <= 8'h01;
            end

            else if (SUDI == `D02_0_dec) begin
                RXD <= 8'h02;
            end

            else if (SUDI == `D03_0_dec) begin
                RXD <= 8'h03;
            end

            else if (SUDI == `D02_2_dec) begin
                RXD <= 8'h42;
            end

            else if (SUDI == `D16_2_dec) begin
                RXD <= 8'h50;
            end

            else if (SUDI == `D26_4_dec) begin
                RXD <= 8'h9A;
            end

            else if (SUDI == `D06_5_dec) begin
                RXD <= 8'hA6;
            end
    
            else if (SUDI == `D21_5_dec) begin
                RXD <= 8'hB5;
            end

            else if (SUDI == `D05_6_dec) begin
                RXD <= 8'hC5;
            end   
            state <= Receive; //Se regresa al estado receive para ver si hay más datos válidos.
        end

endmodule