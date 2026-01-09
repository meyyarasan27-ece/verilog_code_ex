`timescale 1ns / 1ps
module flip_flop_d(d,q,clk,reset);
input wire d ,clk,reset;
output reg q ;

always @(posedge clk)begin
    if(reset)
      q <= 1'b0 ;
    else
       q <= d ;
end
endmodule
