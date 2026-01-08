`timescale 1ns / 1ps
module shift_reg_pipo(clk,reset,parallel_data_in,parallel_data_out);
input wire clk,reset ;
input wire [3:0]parallel_data_in ;
output reg [3:0]parallel_data_out ;

always @(negedge clk) begin
        if(reset)begin
              parallel_data_out <= 4'b0000 ;
              end
          else begin
               parallel_data_out <= parallel_data_in ;
               end
        
     end
endmodule
