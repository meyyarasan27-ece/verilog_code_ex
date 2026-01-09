`timescale 1ns / 1ps
module flip_flop_sr_tb();
reg s,r,clk,reset;
wire q ;

flip_flop_sr uut(.reset(reset), .clk(clk), .s(s), .r(r), .q(q));

initial begin 
clk = 0 ;
 forever #5 clk = ~clk ;
end

initial begin 
   reset = 1 ;
    s = 0 ; r = 0;
   #12 reset = 0 ;
end

initial begin

#15  s  = 0 ; r = 1 ; 
#10  s = 0 ; r = 0 ;
#10  s= 1 ; r = 0 ;
#10  s= 0 ; r = 0 ;
#10  s= 1 ; r = 0 ;
#10  s= 0 ; r = 0 ;
#10  s= 0 ; r = 1 ;
#10  s= 0 ; r = 0 ;
#10  s= 1 ; r = 1 ;
#10  s= 0 ; r = 0 ;

#10  $finish ;
end

initial begin
    $monitor("Time=%0t | clk=%b | reset = %b  | s = %b || r = %b | q=%b"
    , $time, clk , reset, s ,r , q);
end


endmodule
