`timescale 1ns / 1ps
module shift_reg_pipo_tb();
reg clk,reset ;
reg [3:0]parallel_data_in ;
wire [3:0]parallel_data_out ;

shift_reg_pipo uut(.clk(clk)
     , .reset(reset)
     , .parallel_data_in(parallel_data_in)
     , .parallel_data_out(parallel_data_out));


always #5 clk = ~clk ;

initial begin
    clk = 0 ;
    reset = 1 ;
    parallel_data_in =  4'b0000 ;
   
   #10 reset = 0 ;
   
   #10 parallel_data_in =  4'b1000 ;
   #10 parallel_data_in =  4'b1010 ;
   #10 parallel_data_in =  4'b1100 ;
   #10 parallel_data_in =  4'b1011 ;
   #10 $finish ;
    
        end
        
initial begin
     $monitor("time = %0t || clk = %b || reset = %b || parallel_data_in = %b || parallel_data_out = %b "
     ,$time,clk,reset,parallel_data_in,parallel_data_out);
       end
endmodule
