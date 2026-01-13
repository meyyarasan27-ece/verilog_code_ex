`timescale 1ns / 1ps

module full_adder(a,b,cin,sum,carry);
input wire a,b,cin ;
output wire sum,carry ;

assign sum = a^b^cin ;
assign carry = (a&b) | (cin &(a^b));
endmodule
module parallel_4bit_adder(a3,a2,a1,a0,b3,b2,b1,b0 ,s0,s1,s2,s3,c4);
input wire a3,a2,a1,a0,b3,b2,b1,b0 ;
output wire s0,s1,s2,s3,c4;
wire c1,c2,c3 ;
parameter ci_1 = 0 ;

full_adder adder1(.a(a0), .b(b0), .cin(ci_1), .sum(s0), .carry(c1));
full_adder adder2(.a(a1), .b(b1), .cin(c1), .sum(s1), .carry(c2));
full_adder adder3(.a(a2), .b(b2), .cin(c2), .sum(s2), .carry(c3));
full_adder adder4(.a(a3), .b(b3), .cin(c3), .sum(s3), .carry(c4));

endmodule
