`timescale 1ns / 1ps
module flip_flop_t_tb();

reg t,clk,reset ;
wire q ;

flip_flop_t uut(.t(t), .clk(clk), .reset(reset), .q(q));

initial begin 
clk = 0 ;
 forever #5 clk = ~clk ;
end

initial begin 
reset = 1 ;
#8 reset = 0 ;
end

initial begin
 t = 0 ; 
#4 t = 1 ;
#10 t = 0 ;
#10 t = 1 ;
#10 t = 0 ;
#10 t = 1 ;
#10 t = 0 ;
#10 t = 1 ;
#10 t = 0 ;
#10 t = 1 ;
#10 t = 0 ; 

#10  $finish ;
end

initial begin
    $monitor("Time=%0t | clk=%b | reset=%b | t=%b | q=%b", $time, clk, reset, t, q);
end


endmodule
