`timescale 1ns / 1ps
module flip_flop_t(t,q,clk,reset);
input t ,clk,reset ;
output reg q ;

always @(posedge clk or posedge reset)begin

if(reset)
   q <= 1'b0 ;

else if(t) 
   q <= ~q ;

else
   q <= q;
end

endmodule
