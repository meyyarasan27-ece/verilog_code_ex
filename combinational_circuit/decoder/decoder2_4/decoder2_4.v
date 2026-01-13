`timescale 1ns / 1ps
module decoder2_4(i,y);
input wire [1:0]i ;
output reg [3:0]y ;
/*
assign y[0] = ((~i[1]) & (~i[0])) ;
assign y[1] = ((~i[1]) & i[0]) ;
assign y[2] = (i[1] & (~i[0])) ;
assign y[3] = (i[1] & i[0]) ; 

always @(*) begin
case(i)
2'b00 : y = 4'b1000 ;
2'b01 : y = 4'b0100 ;
2'b10 : y = 4'b0010 ;
2'b11 : y = 4'b0001 ;
default : y = 4'b0000 ;
endcase
end
*/

always @(*)begin
y = 4'b1000 >> i ;
end
endmodule
