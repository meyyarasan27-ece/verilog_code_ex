`timescale 1ns / 1ps
module full_subtractor_tb();
reg a,b,c ;
wire diff,borrow ;

full_subtractor uut(.a(a), .b(b), .c(c), .diff(diff), .borrow(borrow));
integer i ;
initial begin
$monitor("time = %0t || a = %b || b = %b || c = %b || diff = %b || borrow = %b ",$time,a,b,c,diff,borrow);
for(i = 0 ;i < 8 ; i = i+1)begin
{a,b,c} = i ;
#10 ;
end
$finish ;
end
endmodule
