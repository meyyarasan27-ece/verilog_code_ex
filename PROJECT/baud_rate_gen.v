`timescale 1ns / 1ps
module baud_rate_gen #(parameter integer BAUD_RATE = 9600 ,
                      parameter integer CLK_FREQ = 50_000_000)(clk,reset,baud_tick);
input wire clk ,reset ;
output reg baud_tick ;

localparam integer BAUD_COUNT = (CLK_FREQ / (BAUD_RATE));
reg [$clog2(BAUD_COUNT) - 1 : 0 ]baud_cntr ;

always @(posedge clk or posedge reset)begin
   if(reset) begin
     baud_cntr  <= 1'b0 ;
     baud_tick <= 1'b0 ;
   end 
   else if(baud_cntr == BAUD_COUNT - 1)begin
     baud_cntr <= 1'b0 ;
     baud_tick <= 1'b1 ;
   end
   else begin
    baud_tick <= 1'b0 ;
    baud_cntr <= baud_cntr + 1 ;
   end
   
end
endmodule
