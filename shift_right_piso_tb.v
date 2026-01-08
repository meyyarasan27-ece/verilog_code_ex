`timescale 1ns / 1ps

module shift_right_piso_tb();

reg clk,reset,load ;
reg [3:0]parallel_data_in ;
wire serial_data_out ;

shift_right_piso uut(.clk(clk)
        , .reset(reset), .load(load)
        , .parallel_data_in(parallel_data_in)
        , .serial_data_out(serial_data_out));
        
always #5 clk = ~clk ;

initial begin
      clk = 0 ;
      parallel_data_in = 4'b0000 ;
      load = 0 ;
      reset = 1 ;
      
      #5 reset = 0 ;
      load = 1 ; 
     parallel_data_in = 4'b1010 ;
     
     #10 load = 0 ;
     #50 ;
      
      $finish ;
      end
      
initial begin
        $monitor("time = %0t || clk = %b || reset = %b || load = %b || parallel_data_in = %b || serial_data_out = %b "
        ,$time,clk,reset,load,parallel_data_in ,serial_data_out);
        end
endmodule
