`timescale 1ns / 1ps

module ring_counter_tb( );
reg clk,reset ;
wire [3:0]data_out ;


ring_counter uut(.clk(clk), .reset(reset), .data_out(data_out));
always #5 clk = ~clk ;

initial begin 
        clk = 0 ;
        reset = 1 ;
        
        #6 reset = 0 ;
       
        
        #80 $finish ;
        end

initial begin
        $monitor("time = %0t || clk = %b || reset = %b || data_out = %b"
        ,$time,clk,reset,data_out);
        end
        
endmodule
