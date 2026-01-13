`timescale 1ns / 1ps
module half_adder_tb();
reg a,b ;
wire sum,carry ;

integer i ;
half_adder uut(.a(a), .b(b), .sum(sum), .carry(carry));

initial begin
$monitor("time = %t || a = %b || b = %b || sum = %b || carry = %b",$time ,a,b,sum,carry);
for(i = 0 ; i < 4 ; i = i+1)begin
{a,b} = i ;
#10;
end
$finish ;
end
endmodule
