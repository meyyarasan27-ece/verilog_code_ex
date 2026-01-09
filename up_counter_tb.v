`timescale 1ns / 1ps
module up_counter_tb( );
reg clk,reset ;
wire [3:0]count ;

up_counter uut(.clk(clk), .reset(reset), .count(count));
initial begin
        clk = 0 ;
        forever #5 clk = ~clk ;
        end

initial begin
        
        reset = 1 ;
        #8 reset = 0 ;
        
        
        
        #150 $finish ;
        end        
        
   initial begin 
           $monitor("time = %0t || clk = %b || reset = %b  || count = %d"
           ,$time,clk,reset ,count);
      
   end
endmodule
