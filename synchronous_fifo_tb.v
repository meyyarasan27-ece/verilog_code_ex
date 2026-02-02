`timescale 1ns / 1ps
module synchronous_fifo_tb #(parameter integer DATA_WIDTH = 8 ,
                             parameter integer DEPTH = 4)();
reg reset ,clk ; 
reg [DATA_WIDTH-1 : 0]wr_data ;
reg wr_en ,rd_en ;
wire [DATA_WIDTH-1 : 0]rd_data ;
wire full ,empty ;

reg [DATA_WIDTH-1 : 0]mem[0:DEPTH-1] ;

synchronous_fifo uut(.reset(reset),
                     .clk(clk),
                     .wr_data(wr_data),
                     .wr_en(wr_en),
                     .rd_en(rd_en),
                     .rd_data(rd_data),
                     .full(full),
                     .empty(empty));
  integer i ;
                     
 always #5 clk = ~clk ;
 initial begin
   clk = 0 ;
   reset = 1 ;
   wr_en = 0 ;
   rd_en = 0 ;
   wr_data = 8'd0;
   
  mem[0] = 8'b01011101 ;
  mem[1] = 8'b11010100 ;
  mem[2] = 8'b11110011 ;
  mem[3] = 8'b00001101 ;
   
   
   
   #10 reset = 0 ;
   #10 wr_en = 1 ; rd_en = 0 ;
   for(i = 0 ; i < DEPTH ; i = i + 1)begin
      wr_data = mem[i] ;
      #10 ;
   end
   
   #10 rd_en = 1 ; wr_en = 0 ;
   
   #(DEPTH*10) $finish ;
  /* 
   #10 reset = 0 ;
   #10 wr_en = 1 ; rd_en = 0 ; wr_data = 8'b01011101 ;
   #10 wr_data = 8'b11010100 ;
   #10 wr_data = 8'b11110011 ;
   #10 wr_data = 8'b00001101 ;
   #10 wr_en = 0 ;
   #10 rd_en = 1 ;
   
   #40 ;
   #10 rd_en = 0 ;
    $finish ;
   */
 end
endmodule
