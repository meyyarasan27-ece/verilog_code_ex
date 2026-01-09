`timescale 1ns / 1ps
module ring_counter(clk,reset,data_out);
input wire clk,reset ;
output reg [3:0]data_out ;

always @(negedge clk)begin
       if(reset)
         data_out <= 4'b1000 ;
       else 
          data_out <= {data_out[0] , data_out[3:1]} ;
     end

endmodule
