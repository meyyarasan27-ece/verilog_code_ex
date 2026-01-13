`timescale 1ns / 1ps

module decoder2_4_tb( );
reg [1:0]j ;
wire [3:0]y ;

integer i ;
decoder2_4 uut (.i(j), .y(y));

initial begin
$monitor("time = %0t || j = %b || y = %b ",$time,i,y);

for(i = 0 ; i < 4 ; i = i +1 )begin
 j = i ;
#10 ;
end
$finish ;
end

endmodule
