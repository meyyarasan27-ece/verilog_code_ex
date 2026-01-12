`timescale 1ns / 1ps

module digital_clock_tb( );
reg clk ,reset ;
wire [5:0]out_sec ,out_min ;
wire [4:0]out_hour ;

digital_clock uut(.clk(clk)
                  , .reset(reset)
                  , .out_sec(out_sec)
                  , .out_min(out_min)
                  , .out_hour(out_hour));

always #5 clk = ~clk ;

initial begin 
  clk = 0 ; 
  reset =1 ;
  #10  reset = 0 ;
  
  #2_000_000_000 $finish ;
end

initial begin
  $monitor("time = %0t | clk = %b |reset = %b | %02d : %02d : %02d "
  ,$time,clk,reset , out_hour,out_min,out_sec);
end
endmodule
