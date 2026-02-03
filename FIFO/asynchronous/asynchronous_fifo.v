`timescale 1ns / 1ps
module asynchronous_fifo #(parameter integer DATA_WIDTH = 8 ,
                           parameter integer DEPTH = 4)(wr_clk,rd_clk,wr_reset,rd_reset,wr_en,rd_en,wr_data,rd_data,full,empty);
input wire wr_clk ,rd_clk ,wr_reset ,rd_reset ;
input wire wr_en ,rd_en ;
input wire [DATA_WIDTH -1 : 0]wr_data ;
output reg [DATA_WIDTH - 1 :0 ]rd_data ;
output wire full ,empty ;

localparam integer POINTER_DEPTH = $clog2(DEPTH) ;
reg [POINTER_DEPTH  :  0]rd_ptr , wr_ptr ;
reg [DATA_WIDTH-1  : 0 ]mem[0 : DEPTH - 1] ;

reg [POINTER_DEPTH  : 0 ]wr_gray ,rd_gray ;
reg [POINTER_DEPTH  : 0 ]wr_gray_sync1 ,wr_gray_sync2 ;
reg [POINTER_DEPTH  : 0 ]rd_gray_sync1 ,rd_gray_sync2 ;
//write data 

always @(posedge wr_clk or posedge wr_reset)begin
  if(wr_reset)begin
    wr_ptr <= 0 ;
    wr_gray <= 0 ;
  end
  else begin
    if(wr_en && !full)begin
      mem[wr_ptr[POINTER_DEPTH-1:0]] <= wr_data ;
      wr_ptr <= wr_ptr + 1 ;
      wr_gray <= binaryToGray(wr_ptr + 1) ;
    end
  end
end

//binary to gray

function [POINTER_DEPTH : 0] binaryToGray(input [POINTER_DEPTH : 0]wr_gray) ;
binaryToGray = (wr_gray >> 1)^wr_gray ;
endfunction

//read  data
always @(posedge rd_clk or posedge rd_reset)begin
  if(rd_reset)begin
    rd_ptr <= 0 ;
    rd_data <= 0 ;
    rd_gray <= 0 ;
  end
  else begin
    if(rd_en && !empty)begin
      rd_data <= mem[rd_ptr[POINTER_DEPTH -1 : 0]] ;
      rd_ptr <= rd_ptr + 1 ;
      rd_gray <= binaryToGray(rd_ptr + 1);
    end
  end
end

// read synchronoizer from write pointer 
always @(posedge wr_clk or posedge wr_reset)begin
 if(wr_reset)begin
   rd_gray_sync1 <= 0 ;
   rd_gray_sync2 <= 0 ;
 end
 else begin
   rd_gray_sync1 <= rd_gray ;
   rd_gray_sync2 <= rd_gray_sync1 ;
 end
end

// write synchronoizer from read pointer 
always @(posedge rd_clk or posedge rd_reset)begin
 if(rd_reset)begin
   wr_gray_sync1 <= 0 ;
   wr_gray_sync2 <= 0 ;
 end
 else begin
   wr_gray_sync1 <= wr_gray ;
   wr_gray_sync2 <= wr_gray_sync1 ;
 end
end

assign empty = (rd_gray == wr_gray_sync2);
assign full =  (binaryToGray(wr_ptr + 1) == {~rd_gray_sync2[POINTER_DEPTH : POINTER_DEPTH -1 ], rd_gray_sync2[POINTER_DEPTH-2 : 0 ]});
endmodule
