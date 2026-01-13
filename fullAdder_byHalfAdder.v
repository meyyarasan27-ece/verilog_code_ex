`timescale 1ns / 1ps

module half_adder(a1,b1,s1,c1);
input wire a1,b1 ;
output s1,c1 ;
// data flow level
assign s1 = a1 ^ b1 ;
assign c1 = a1 & b1 ;
endmodule

module fullAdder_byHalfAdder(a,b,cin,sum,carry);
input wire a,b,cin ;
output wire sum,carry ;
wire w1,w2,w3 ;

half_adder adder1 (.a1(a), .b1(b), .s1(w1), .c1(w2));

half_adder adder2(.a1(w1), .b1(cin), .s1(sum), .c1(w3));
assign carry = w3|w2 ;
endmodule
