`timescale 1ns / 1ps
module demux1_8_tb( );
reg data ;
reg [2:0]s ;
wire [7:0]out_data ;

demux1_8 uut(.data(data), .s(s), .out_data(out_data));
integer i ;
initial begin 
$monitor("time  = %0t || data = %b || s = %b || out_data = %b ",$time,data,s,out_data);
end


initial begin
s = 0 ;
for( i = 0 ; i < 8 ; i =  i+1 ) begin
    s = i ;
    data = 1 ;
    #10;
end
$finish ;
end


endmodule
