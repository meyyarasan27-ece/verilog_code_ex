`timescale 1ns / 1ps
module traffic_light_tb( );
reg clk ,reset  ;
wire [1:0]light ;

traffic_light uut(.clk(clk), .reset(reset), .light(light));

always #5 clk = ~clk ;

initial begin
         clk = 0 ;
         reset = 1 ;
         #10 reset = 0 ;
         
         #160 $finish ;
         
        end
        
initial begin 
        $monitor("time = %0t || clk = %b || reset = %b || light = %b ",
        $time,clk,reset,light);
        end
endmodule
