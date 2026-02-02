`timescale 1ns / 1ps
module synchronous_fifo #(parameter integer DATA_WIDTH = 8,
                          parameter integer DEPTH = 4)(clk,reset,wr_en,rd_en,wr_data,rd_data,full,empty);
input wire clk ,reset ;
input wire [DATA_WIDTH-1 :0]wr_data ;
input wire wr_en , rd_en ;
output reg [DATA_WIDTH-1 : 0]rd_data ;
output wire full ,empty ;

reg [DATA_WIDTH-1 : 0]mem[0 : DEPTH-1] ;
localparam integer ADD_WIDTH = $clog2(DEPTH) ;
reg [ADD_WIDTH-1 : 0]rd_ptr ,wr_ptr ;
reg [ADD_WIDTH : 0 ]count ;
//write operation
always @(posedge clk or posedge reset)begin
  if(reset)begin
    wr_ptr <= 0 ;
  end
  else begin
    if(wr_en && !full)begin
       mem[wr_ptr] <= wr_data ;
       wr_ptr <= wr_ptr + 1 ;
    end
  end
end

//read operation
always @(posedge clk or posedge reset)begin
  if(reset)begin
    rd_ptr <= 0 ;
    rd_data <= 0 ;
  end
  else begin
    if(rd_en && !empty)begin
      rd_data <= mem[rd_ptr] ;
       rd_ptr <= rd_ptr + 1 ;
    end
  end
end
always @(posedge clk or posedge reset)begin
   if(reset)begin
     count <= 0 ;
   end
   else if((wr_en && !full ) && !(rd_en && !empty))begin
      count <= count + 1 ;
   end
   else if((rd_en && !empty) && !(wr_en && !full))begin
      count <= count - 1 ;
   end
   else 
     count <= count ;
end
assign full = (count == DEPTH);
assign empty = (count == 0);
endmodule
