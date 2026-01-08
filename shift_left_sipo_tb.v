`timescale 1ns / 1ps
module shift_left_sipo_tb();

reg clk,reset ,serial_data_in ;
wire [3:0]parallel_data_out ;

shift_left_sipo uut(.clk(clk)
                 , .reset(reset)
                 , .serial_data_in(serial_data_in)
                 , .parallel_data_out(parallel_data_out));
                 
always #5 clk = ~clk ;

initial begin
        clk = 0 ;
        serial_data_in = 0 ;
        reset = 1 ;
        
        #10 reset = 0 ;
        
        #10 serial_data_in = 1 ;  
        #10 serial_data_in = 1 ;  
        #10 serial_data_in = 0 ;  
        #10 serial_data_in = 1 ; 
        #10 $finish ; 
        end
        
 initial begin
       $monitor("time = %0t || clk = %b || reset = %b || serial_data_in = %b || parallel_data_out = %b "
       ,$time,clk,reset,serial_data_in,parallel_data_out);
         end
endmodule
