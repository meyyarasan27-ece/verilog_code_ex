`timescale 1ns / 1ps
module shift_right_piso( clk,load,reset,parallel_data_in,serial_data_out);

input wire clk,load,reset ;
input wire [3:0]parallel_data_in ;
output reg serial_data_out ;
reg [3:0]parallel_stored_data ;

always @(negedge clk)begin

    if(reset)begin
       serial_data_out <= 1'b0 ;
       parallel_stored_data <= 4'b0000 ;
     end
     
     else if(load) begin
        parallel_stored_data <= parallel_data_in ;
        serial_data_out <= 1'b0 ;
        end
        
     else begin
       serial_data_out <= parallel_stored_data[0] ;
       parallel_stored_data <= parallel_stored_data >> 1 ;
     end
   end
endmodule
