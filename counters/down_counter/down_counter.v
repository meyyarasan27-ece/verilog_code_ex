`timescale 1ns / 1ps
module down_counter(clk,reset,count );
input wire clk ,reset ;
output reg [3:0]count ;

always @(negedge clk)begin
  if(reset)
    count <= 4'b1111 ;
  else
    count <= count - 1 ;
end
endmodule
