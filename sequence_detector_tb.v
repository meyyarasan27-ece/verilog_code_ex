`timescale 1ns / 1ps
module sequence_detector_tb();
reg clk,din,reset ;
wire y ;

sequence_detector uut(.clk(clk), .din(din), .reset(reset), .y(y));

initial begin 
        clk = 0 ;
        forever #5 clk = ~clk ;
        end
        
initial begin
       // clk = 1 ;
        reset = 1 ;
        din = 0 ;
        
        #10 reset = 0 ;
         din = 0 ;
        #9 din = 1 ;
        #10 din = 1 ;
        #10 din = 1 ;
        #10 din = 1 ;
        #10 din = 0 ;
        #10 din = 1 ;
        #10 din = 0 ;
        #10 din = 1 ;
        #10 din = 1 ;
        #10 din = 1 ;
        
          $finish ;
        end
        
initial begin
        $monitor("time = %0t || clk = %b || reset = %b || din = %b || y = %b ",$time,clk,reset,din,y);
        end
endmodule
