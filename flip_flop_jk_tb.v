`timescale 1ns / 1ps
module flip_flop_jk_tb();

reg j,k,clk,reset;
wire q ;

flip_flop_jk uut(.reset(reset), .clk(clk), .j(j), .k(k), .q(q));

initial begin 
clk = 0 ;
 forever #5 clk = ~clk ;
end

initial begin 
   reset = 1 ;
    j = 0 ; k = 0;
   #12 reset = 0 ;
end

initial begin

#15  j  = 0 ; k = 1 ; 
#10  j = 0 ; k = 0 ;
#10 j = 1 ; k = 0 ;
#10 j = 0 ; k = 0 ;
#10 j = 1 ; k = 1 ;
#10 j = 0 ; k = 0 ;
#10 j = 0 ; k = 1 ;
#10 j = 0 ; k = 0 ;
#10 j = 1 ; k = 1 ;
#10 j = 0 ; k = 0 ;

#10  $finish ;
end

initial begin
    $monitor("Time=%0t | clk=%b | reset = %b  | j= %b || k = %b | q=%b"
    , $time, clk , reset, j ,k , q);
end


endmodule
