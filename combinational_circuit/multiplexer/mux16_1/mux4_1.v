`timescale 1ns / 1ps
module mux4_1(a,b,c,d,w0,w1,y1);
input wire a,b,c,d ;
input wire w0,w1 ;
output wire y1 ;

assign y1 = (((~w0) & (~w1) & a)|((~w0) & (w1) & b) | ((w0) & (~w1)&c) | (w1&w0&d)) ;
endmodule


module mux2_1(e,f,w2,y2);
input wire e,f ;
input wire w2 ;
output wire y2 ;

assign y2 = (((~w2) & e ) | ( w2 & f )) ;
endmodule


module mux16_1(i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15 ,s0,s1,s2,s3,y);
input wire i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15 ;
input wire s0,s1,s2,s3 ;
 wire p,q,r,s,t,u;
output wire y ;

mux4_1 design0(.a(i0), .b(i1), .c(i2), .d(i3), .w0(s0), .w1(s1), .y1(p));
mux4_1 design1(.a(i4), .b(i5), .c(i6), .d(i7), .w0(s0), .w1(s1), .y1(q));
mux4_1 design2(.a(i8), .b(i9), .c(i10), .d(i11), .w0(s0), .w1(s1), .y1(r));
mux4_1 design3(.a(i12), .b(i13), .c(i14), .d(i15), .w0(s0), .w1(s1), .y1(s));

mux2_1 design4(.e(p), .f(q), .w2(s2), .y2(t));
mux2_1 design5(.e(r), .f(s), .w2(s2), .y2(u));
mux2_1 design6(.e(t), .f(u), .w2(s3), .y2(y));

endmodule
