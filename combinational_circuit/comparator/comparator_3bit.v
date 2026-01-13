`timescale 1ns / 1ps
module comparator_3bit(a,b,a_greater_b , a_equal_b,a_lesser_b);
input wire [1:0]a ,b ;
output wire a_greater_b , a_equal_b,a_lesser_b ;
/*
always @(*) begin
a_greater_b = 0;
a_equal_b   = 0;
a_lesser_b  = 0;

if(a > b) begin
  a_greater_b = 1 ;
  a_equal_b   = 0;
  a_lesser_b  = 0;
end

else if(a < b) begin
    a_lesser_b = 1 ;
    a_greater_b = 0;
    a_equal_b   = 0;
end
else  begin
   a_equal_b = 1 ;
   a_greater_b = 0 ;
   a_lesser_b  = 0;
end
end

*/
//data flow level
assign a_lesser_b = (~a[0] & (~a[1]) & b[0]) | ((!a[1])& b[1] ) | ((~a[0])&b[1]&b[0]);
assign a_equal_b = (a[1]~^b[1]) & (a[1] ~^b[1]);
assign a_greater_b = (a[0]&b[0]&(~b[1]))| (a[0]&a[0]&(~b[0])) | ((!b[1])& a[1] );
endmodule
