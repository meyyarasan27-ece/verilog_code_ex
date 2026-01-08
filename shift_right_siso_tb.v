`timescale 1ns / 1ps
module shift_right_siso_tb();
reg clk,reset,din ;
wire data_out ;

shift_right_siso uut(.clk(clk), .reset(reset), .din(din), .data_out(data_out)) ;

always #5 clk = ~clk ;

initial begin
        clk = 0 ;
        din = 0 ;
        reset = 1 ;
        
        
        #20 
        reset = 0 ;  //release reset
        #10 din = 1 ;
        #10 din = 0 ;
        #10 din = 1 ;
        #10 din = 1 ;
        #10 $finish ;
        end
        
initial begin 
        $monitor("time = %0t || clk = %b || reset = %b || din = %b || data_out = %b  "
        ,$time,clk,reset,din,data_out);
        end
endmodule
