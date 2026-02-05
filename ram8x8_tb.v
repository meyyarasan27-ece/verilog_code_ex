`timescale 1ns / 1ps
module ram8x8_tb #(parameter integer DEPTH = 8 ,
                   parameter integer WIDTH = 8)();
reg clk ,wr_en ;
reg [WIDTH-1 : 0]data_in ;
reg [$clog2(DEPTH)-1 : 0]data_address ;
wire [WIDTH-1 : 0 ]data_out ;

ram8_8 uut(.clk(clk),
           .wr_en(wr_en),
           .data_in(data_in),
           .data_address(data_address),
           .data_out(data_out));

integer i ;

always #5 clk = ~clk ;

initial begin
 clk = 0 ;
 
 wr_en = 1'b1 ;
 for( i = 0 ; i < DEPTH ; i = i + 1)begin
    data_address = i ;
    data_in = 8'b10001010 + i ;
    #10 ;
 end
 
 wr_en = 1'b0 ;
 for( i = 0 ; i < DEPTH ; i = i + 1)begin
    data_address = i ;
    #10 ;
 end
 #10 ;
 $finish ;
end

endmodule
