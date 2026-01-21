`timescale 1ns / 1ps

module digital_clock_tb#( parameter integer CLK_FREQ_HZ = 50_000 ,
                          parameter integer TICK_FREQ_HZ = 1,
                          parameter integer MIN_VALUE = 60 ,
                          parameter integer SEC_VALUE = 60 ,
                          parameter integer HOUR_VALUE = 24 )( );
reg clk ,reset;
wire [$clog2(SEC_VALUE)-1:0]out_sec ;
wire [$clog2(MIN_VALUE)-1:0]out_min ;
wire [$clog2(HOUR_VALUE)-1:0]out_hour ;

digital_clock #(.CLK_FREQ_HZ(CLK_FREQ_HZ), .TICK_FREQ_HZ(TICK_FREQ_HZ), .MIN_VALUE(MIN_VALUE), .SEC_VALUE(SEC_VALUE), .HOUR_VALUE(HOUR_VALUE))uut(.clk(clk)
                  , .reset(reset)
                  , .out_sec(out_sec)
                  , .out_min(out_min)
                  , .out_hour(out_hour));

always #10_000 clk = ~clk ;

initial begin 
  clk = 0 ; 
  reset =1 ;
  #110_000  reset = 0 ;
  
  #500_000_000 $finish ;
end

initial begin
  $monitor("time = %0t | clk = %b |reset = %b | %02d : %02d : %02d "
  ,$time,clk,reset , out_hour,out_min,out_sec);
end
endmodule
