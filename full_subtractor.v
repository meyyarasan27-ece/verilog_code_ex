`timescale 1ns / 1ps
module full_subtractor(a,b,c,diff,borrow);
input wire a,b,c ;
output wire diff,borrow ;

assign diff = a^b^c ;
assign borrow = b&c | (~a)&(b^c) ;
endmodule
