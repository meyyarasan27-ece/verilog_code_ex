`timescale 1ns / 1ps

module up_counter(reset, clk, count);

input wire reset, clk ;
output reg [3:0] count;

always @(negedge clk )begin
    if(reset)
    count <= 4'b0000 ;
    else
    count <= count + 1 ;
end
endmodule
