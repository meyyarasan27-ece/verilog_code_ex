`timescale 1ns / 1ps
module uart_tx_tb #(parameter integer DATA = 8)( );
reg clk ,reset ,tx_start ;
reg [DATA -1 : 0]data ;
wire tx_out ,tx_busy ;

uart_protocol uut(.clk(clk), 
                  .reset(reset), 
                  .tx_start(tx_start), 
                  .data(data), 
                  .tx_out(tx_out), 
                  .tx_busy(tx_busy));
 reg [DATA-1 : 0]tx_data[3:0] ;                 
always #10 clk = ~clk ;
 integer i ;
initial begin
  clk = 0   ;
  reset = 1 ;
  tx_start = 0 ;
  
  #20 reset = 0 ;
  
    tx_data[0] = 8'hD3;
    tx_data[1] = 8'hA5;
    tx_data[2] = 8'h3C;
    tx_data[3] = 8'h55;
 
 for(i = 0 ; i < 4 ; i = i +1 )begin
    wait(tx_busy == 0)
    data = tx_data[i] ;
    tx_start = 1 ;
    #40 tx_start = 0 ;
    
 end  
 
  #2_000_000 $finish ;
end             

initial begin
  $monitor("time = %0t |clk = %b | tx_ out = %b | tx_busy = %b",$time ,clk ,tx_out,tx_busy);
end     
endmodule
