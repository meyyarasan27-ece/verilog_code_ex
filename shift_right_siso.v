`timescale 1ns / 1ps
module shift_right_siso(clk,reset,din,data_out);
input wire clk ,reset,din ;
output wire data_out ;
reg [3:0]right_shift_out ;

always @(negedge clk)
begin
  if(reset)
    right_shift_out <= 4'b0000 ;
  
  else 
    right_shift_out <= {din ,right_shift_out[3:1]} ;

end
assign data_out = right_shift_out[0];
endmodule
