module tester_SYNC(
	output reg clk, mr_main_reset,mr_loopback,signal_detect,
	output reg [9:0] code_group, 
    input	[9:0] SUDI,
	input code_sync_status,rx_even
	);
always #1 clk<=~clk; //switch del reloj
 //condiciones iniciales
 
initial begin
	  clk<=1;
	  mr_main_reset = 1'b0; 
	     //-------------iniciamos la maquina-----------------
      #2 mr_main_reset <= 1'b1; 
      signal_detect<=1'b1;
      mr_loopback<=1; 
      //Estado 1 a 2
      code_group<=10'b1100000101; 
      //Estado 2 a 3
      #2 code_group<=10'b1010010110;
          //Estado 3 a 4
      #2 code_group<=10'b1100000101; 
          //Estado 4 a 5
      #2 code_group<=10'b1010010110; 
          //Estado 5 a 6 
      #2 code_group<=10'b1100000101;
	  //Estado 6 a 7
      #2 code_group<=10'b1010010110; 
	  // ciclo 7                   
      #2 code_group<=10'b1010010110; 
      // Estado 7 a 8                  
      #2 code_group<=10'b1111111111; 
       // Estado 8 a 9                 
      #2 code_group<=10'b1010010110; 
       // Estado 9 a 10                  
      #2 code_group<=10'b1111111111; 
       // Estado 10 a 11                   
      #2 code_group<=10'b1010010110;  
      // Estado 11 a 12                  
      #2 code_group<=10'b1111111111;
      #2 code_group<=10'b1010010110;  
       // Estado 12 a 13                    
     #2 code_group<=10'b1111111111;
        #50;
      #4 $finish; 
	  end
endmodule