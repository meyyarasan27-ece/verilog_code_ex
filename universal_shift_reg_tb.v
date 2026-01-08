`timescale 1ns / 1ps
module universal_shift_reg_tb();
reg clk,reset ,serial_right_in ,serial_left_in ;
reg [1:0]sel ;
reg [3:0]parallel_in ;
wire [3:0]parallel_data_out ;

universal_shift_reg uut(.clk(clk)
, .reset(reset)
, .serial_right_in(serial_right_in)
, . serial_left_in(serial_left_in)
, .sel(sel)
, .parallel_in(parallel_in)
, .parallel_data_out(parallel_data_out));

always #5 clk = ~clk ;

initial begin 
   clk = 0 ;
   serial_right_in = 0 ;
   serial_left_in = 0 ;
   parallel_in = 4'b0000 ;
   sel = 2'b00 ;
   reset = 1 ;
   
   #8 reset = 0 ;
   
   #7 sel = 2'b10 ;  serial_right_in = 1'b1 ;
   #40 ;
   #5 reset = 1 ; sel = 2'b00 ;
   #8 reset = 0 ;
   #10 sel = 2'b01 ;  serial_left_in = 1'b1 ; 
   #40 ;
   
   #10 sel = 2'b11 ; parallel_in = 4'b1111 ;
   #10 sel = 2'b11 ; parallel_in = 4'b1010 ;
   #20;
    $finish ;
   
end

initial begin
      $monitor("time = %0t || clk = %b || reset = %b || sel = %b || parallel_data_out = %b "
      ,$time,clk,reset,sel,parallel_data_out);
        end
endmodule
