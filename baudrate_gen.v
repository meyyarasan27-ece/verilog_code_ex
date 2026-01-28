`timescale 1ns / 1ps
module baudrate_gen #(parameter integer BAUD_RATE = 9600 ,
                      parameter integer CLK_FREQ = 50_000_000)(clk,reset,baud_tick);
input wire clk ,reset ;
output reg baud_tick ;

localparam integer HALF_BAUD_RATE = (CLK_FREQ / (2*BAUD_RATE));
reg [$clog2(HALF_BAUD_RATE) - 1 : 0 ]HALF_BAUD_COUNT ;

always @(posedge clk or posedge reset)begin
   if(reset) begin
     HALF_BAUD_COUNT <= 1'b0 ;
     baud_tick <= 1'b0 ;
   end 
   else if(HALF_BAUD_COUNT == HALF_BAUD_RATE - 1)begin
     HALF_BAUD_COUNT <= 1'b0 ;
     baud_tick <= 1'b1 ;
   end
   else begin
    baud_tick <= 1'b0 ;
    HALF_BAUD_COUNT <= HALF_BAUD_COUNT + 1 ;
   end
   
end
endmodule
