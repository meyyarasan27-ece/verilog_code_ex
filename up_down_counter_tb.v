`timescale 1ns / 1ps
module up_down_counter_tb( );
reg clk,reset,mode ;
wire [3:0]count ;

up_down_counter uut(.clk(clk), .reset(reset), .count(count), .mode(mode));
initial begin
        clk = 0 ;
        forever #5 clk = ~clk ;
        end

initial begin
        mode = 1 ;
        reset = 1 ;
        #10 reset = 0 ;
        
        #150 mode = 0  ;
        
        #150 $finish ;
        end        
        
   initial begin 
           $monitor("time = %0t || clk = %b || reset = %b || mode = %b || count = %d",$time,clk,reset,mode ,count);
      
   end
endmodule
