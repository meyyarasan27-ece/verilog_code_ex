`timescale 1ns / 1ps

module tb_frequency_divider();
reg reset,clk ;
wire clk_output_10 ;

frequency_divider uut( .reset(reset), .clk_output_10(clk_output_10), .clk(clk));

always #5 clk = ~clk;

initial begin
        
        clk = 0 ;
        reset = 1 ;
        
        #18 reset = 0 ;
        
        #200 ;
        $finish ;
        end
endmodule
