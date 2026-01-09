`timescale 1ns / 1ps
module down_counter_tb();
reg clk,reset ;
wire [3:0]count ;


down_counter uut(.clk(clk), .reset(reset), .count(count));
always  #5 clk = ~clk ;

initial begin 
      clk = 0 ;
      reset = 1 ;
      
      #6 reset = 0 ;
      
      
      #150 $finish ;
       end
       
initial begin
        $monitor("time = %0t || clk = %b || reset = %b || count = %d"
        ,$time,clk,reset,count);
        end
endmodule
