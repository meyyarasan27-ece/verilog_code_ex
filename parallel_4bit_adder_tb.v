`timescale 1ns / 1ps
module parallel_4bit_adder_tb();
reg a3,a2,a1,a0,b3,b2,b1,b0 ;
wire carry,s3,s2,s1,s0 ;

integer i ;

parallel_4bit_adder uut(.a0(a0), .a1(a1), .a2(a2), .a3(a3), .b0(b0), .b1(b1), .b2(b2), .b3(b3), .s0(s0), .s1(s1), .s2(s2), .s3(s3), .c4(carry));
initial begin
$monitor("time = %t ||  b3 = %b ||  a3 = %b|| b2 = %b ||  a2 = %b|| b1 = %b ||  a1 = %b|| b0 = %b ||  a0 = %b || c4 = %b || s3 = %b || s2 = %b || s1 = %b || s0 = %b",
$time,b3,a3,b2,a2,b1,a1,b0,a0,carry,s3,s2,s1,s0);

for( i = 0 ; i < 16 ; i =i + 1)begin
{a3,a2,a1,a0} = i;
{b3,b2,b1,b0} = i ;
#10; 
end
$finish ;
end
endmodule
