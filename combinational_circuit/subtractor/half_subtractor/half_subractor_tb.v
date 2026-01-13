`timescale 1ns / 1ps
module half_subractor_tb();
reg a,b ;
wire diff,borrow ;

half_subtractor uut(.a(a), .b(b), .diff(diff), .borrow(borrow));
integer i ;
initial begin
$monitor("time = %0t  || a = %b || b = %b || diff = %b || borrow = %b",$time,a,b,diff,borrow);

for( i = 0 ; i < 4 ; i = i+1 )begin
{a,b} = i ;
#10 ;
end
$finish ;
end
endmodule
