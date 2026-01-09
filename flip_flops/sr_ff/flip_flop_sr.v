`timescale 1ns / 1ps

module flip_flop_sr(s,r,q,clk,reset);
input wire s,r,clk ,reset;
output reg q ;

always @(posedge clk)begin
if(reset)
  q <= 1'b0 ;
else if(s && !r)
   q <= 1'b1 ;

else if(!s && r)
   q <= 1'b0 ;

else if(!s && !r)
    q <= q ;

else
   q <= 1'bx ;
end 
endmodule
