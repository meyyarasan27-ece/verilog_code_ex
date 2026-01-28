`timescale 1ns / 1ps
module uart_protocol_tb #(parameter integer DATA = 8)();
reg clk ,reset,tx_start ;
reg [DATA - 1 : 0 ]tx_data ;
wire [DATA - 1 : 0 ]rx_data ;
wire tx_out ,tx_busy,rx_valid,parity_error ;

uart_protocol uut(.clk(clk),
                  .reset(reset),
                  .tx_start(tx_start), 
                  .tx_data(tx_data),
                  .rx_data(rx_data), 
                  .tx_out(tx_out), 
                  .tx_busy(tx_busy),
                  .rx_valid(rx_valid),
                  .parity_error(parity_error));
                  
always #10 clk = ~clk ;
reg [DATA-1 : 0]reg_array[3:0] ;
integer i ;
initial begin
   clk = 0 ;
   reset = 1 ;
   tx_start = 0 ;
   
   #20 reset  = 0 ;
   reg_array[0] = 8'hD3; 
   reg_array[1] = 8'hA5; 
   reg_array[2] = 8'h3C; 
   reg_array[3] = 8'h55; 
   
   for(i = 0 ; i < 4 ; i = i +  1)begin
      wait(tx_busy == 0);
      tx_data = reg_array[i] ;
      tx_start = 1 ;
      #40 tx_start = 0 ;
      
      wait(rx_valid == 1) ;
   end
   
   #2_000_000 $finish ;
   
end

endmodule
