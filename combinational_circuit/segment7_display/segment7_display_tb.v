`timescale 1ns / 1ps
module segment7_display_tb();
reg b3,b2,b1,b0 ;
wire seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g ;

integer i ;
segment7_display uut(.b3(b3), .b2(b2), .b1(b1), .b0(b0), 
.a(seg_a), .b(seg_b), .c(seg_c), .d(seg_d), .e(seg_e), .f(seg_f), .g(seg_g));

initial begin
$monitor("time = %t || b3 = %b || b2 = %b || b1 = %b || b0 = %b || a = %b || b = %b || c = %b || d = %b || e = %b || f = %b || g = %b ",
$time,b3,b2,b1,b0,seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g);

for( i = 0 ; i < 10 ; i =i+1)begin
{b3,b2,b1,b0} = i ;
#10;
end
$finish ;
end
endmodule
