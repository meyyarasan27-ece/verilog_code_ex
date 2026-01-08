`timescale 1ns / 1ps
module shift_left_siso(clk ,reset,din,data_out);
input wire clk,reset,din ;
output wire data_out ;
 reg [3:0]shift_left_out;

always @(negedge clk) begin

      if(reset)
        shift_left_out <= 4'b0000 ;
      else 
        shift_left_out <= {shift_left_out[2:0],din};
end

assign data_out = shift_left_out[3] ;
endmodule
