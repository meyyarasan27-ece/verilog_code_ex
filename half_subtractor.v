`timescale 1ns / 1ps
module half_subtractor(a,b,diff,borrow);
input wire a,b ;
output reg diff,borrow ;

always @(*)begin
case({a,b})
2'b00 : begin diff = 0 ; borrow = 0 ;end
2'b01 : begin diff = 1'b1 ; borrow = 1'b1 ;end
2'b10 : begin diff = 1'b1 ; borrow = 1'b0 ;end
2'b11 : begin diff = 1'b0 ; borrow = 1'b0 ;end
default : begin diff = 1'bx ; borrow = 1'bx ;end 
endcase
end
endmodule
