`timescale 1ns / 1ps
module shift_right_sipo(clk,reset,serial_data_in,parallel_data_out);
input wire clk,reset,serial_data_in ;
output reg [3:0]parallel_data_out ;

always @(negedge clk)begin
       if(reset) begin
         parallel_data_out <= 4'b0000 ;
         end
       else begin
          parallel_data_out <= {serial_data_in ,parallel_data_out[3:1]} ;
           end
         
       
end
endmodule
