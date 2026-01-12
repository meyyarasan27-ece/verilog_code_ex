`timescale 1ns / 1ps
module wending_machine_tb( );
reg clk,reset;
reg [4:0]data_in ;
wire data_out5,data_out10,data_out20 ;

wending_machine uut (.clk(clk), .reset(reset), .data_in(data_in)
                     , .data_out5(data_out5), .data_out10(data_out10)
                     , .data_out20(data_out20));
                     
always #5 clk = ~clk ;

initial begin
   clk = 0 ;
   reset = 1 ;
   data_in = 5 ;
   #10 reset = 0 ; data_in = 10 ;
   #10 data_in = 5 ;
   #10 data_in = 10 ;
   #10 data_in = 20 ;
   #10 data_in = 20 ;
   #10 data_in = 10 ;
   #10 data_in = 5 ;
   #10 data_in = 10 ;
   #10 data_in = 5 ;
   #10  data_in = 20 ;
   #10 $finish ;
end

initial begin
   $monitor("time = %0t | clk = %b | reset = %b | data_in = %d | data_out5 = %b | data_out10 = %b | data_out20 = %b "
   ,$time,clk,reset,data_in,data_out5,data_out10,data_out20);
end
endmodule
