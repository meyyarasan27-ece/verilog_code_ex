`timescale 1ns / 1ps
module half_adder(a,b,sum,carry);
input wire a,b ;
output wire sum,carry ;

//gate level 
xor(sum,a,b);
and(carry,a,b);

//behavioral level
/*output reg sum,carry ;
always @(*)begin
case({a,b})
2'b00 : begin sum = 1'b0 ; carry = 1'b 0 ; end 
2'b01 : begin sum = 1'b1 ;carry = 1'b0 ; end
2'b10 :begin sum =  1'b1 ; carry = 1'b0 ; end
2'b11 :begin sum = 1'b0 ;carry = 1'b1 ; end
default:begin sum = 1'bx ;carry = 1'bx ; end
endcase
end

//data flow level
sum = a^b ;
carry = a&b ;
*/
endmodule
