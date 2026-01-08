`timescale 1ns / 1ps
module universal_shift_reg(clk,reset,sel,serial_left_in,serial_right_in,parallel_in,parallel_data_out);
input wire clk,reset ,serial_right_in ,serial_left_in ;
input wire [1:0]sel ;
input wire [3:0]parallel_in ;
output reg [3:0]parallel_data_out ;

always @(posedge clk or posedge reset)begin
if(reset)
parallel_data_out <= 4'b0000 ;
else begin
      case(sel)
          2'b00 : parallel_data_out <= parallel_data_out ;
          2'b01 : parallel_data_out <= {serial_left_in,parallel_data_out[3:1]};
          2'b10 : parallel_data_out <= {parallel_data_out[2:0],serial_right_in};
          2'b11 : parallel_data_out <= parallel_in ;
          default :parallel_data_out <= parallel_data_out ;
      endcase
end
end
 endmodule
