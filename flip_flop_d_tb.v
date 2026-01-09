`timescale 1ns / 1ps

module flip_flop_d_tb();

reg d,clk,reset ;
wire q ;

flip_flop_d uut(.d(d), .clk(clk), .reset(reset), .q(q));

initial begin 
clk = 0 ;
 forever #5 clk = ~clk ;
end

initial begin 
reset = 1 ;
#12 reset = 0 ;
end

initial begin
d = 0 ; 
#4 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ; 
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10 d = 0 ;
#10 d = 1 ;
#10  $finish ;
end

initial begin
    $monitor("Time=%0t | clk=%b | reset=%b | d=%b | q=%b", $time, clk, reset, d, q);
end

endmodule
