`timescale 1ns / 1ps
module comparator_3bit_tb();

reg [1:0]a,b ;
wire a_greater_b , a_equal_b,a_lesser_b ;

integer i, j ;
comparator_3bit uut(.a(a), .b(b), .a_greater_b(a_greater_b), .a_equal_b(a_equal_b), .a_lesser_b(a_lesser_b));

initial begin
a = 0 ; b = 0 ;
$monitor("time = %0t || a = %b || b = %b || a_greater_b = %b || a_equal_b = %b ||a_lesser_b = %b",$time,a,b,a_greater_b , a_equal_b,a_lesser_b);

for( i = 0 ; i < 4 ; i = i+1)begin
    for( j = 0 ; j < 4 ; j = j+1 )begin
        a = i ;
        b = j ;
        #10 ;
    end
end
$finish ;
end
endmodule
