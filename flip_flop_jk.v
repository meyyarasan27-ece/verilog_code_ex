`timescale 1ns / 1ps
module flip_flop_jk(j,k,q,clk,reset);
input wire j,k,clk,reset;
output reg q ;

always @(posedge clk)begin
if (reset)
       q <= 1'b0;
else if(j && !k)
    q <= 1'b1 ;

else if(!j && k)
    q <= 1'b0 ;

else if(j && k)
    q <= ~q ;

else
   q <= q ;

end
endmodule
