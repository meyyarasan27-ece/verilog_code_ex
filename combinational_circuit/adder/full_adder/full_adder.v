`timescale 1ns / 1ps
module full_adder(a,b,cin,sum,carry);
input wire a,b,cin ;
output wire sum,carry ;
//data flow level
assign sum = a^b^cin ;
assign carry = (a&b) | (cin &(a^b));

endmodule
