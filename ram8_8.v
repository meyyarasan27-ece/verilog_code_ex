`timescale 1ns / 1ps
module ram8_8 #(parameter integer WIDTH = 8 ,
                parameter integer DEPTH  = 8 )(clk,wr_en,data_in,data_out,data_address);

input wire clk,wr_en ;
localparam integer ADDRESS_WIDTH = $clog2(DEPTH);
input wire [WIDTH-1 : 0]data_in ;
input wire [ADDRESS_WIDTH-1 : 0]data_address ;
output reg [WIDTH-1 : 0]data_out ;

reg [WIDTH-1 : 0]memory[DEPTH-1 : 0] ;

always @(posedge clk)begin

if(wr_en)begin
   memory[data_address] <= data_in ;
end

data_out <= memory[data_address] ;
end
endmodule
