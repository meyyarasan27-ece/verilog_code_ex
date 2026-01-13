`timescale 1ns / 1ps
module even_paritybit_gen(data ,pout);
//data flow level
//behavioral level
input wire [3:0]data ;
output reg pout ;
always @(*)begin
if(data[0]^data[1]^data[2]^data[3])begin
   pout = 1 ;
end
else begin
   pout = 0 ;
end
end
//assign pout = b3^b2^b1^b0 ;
endmodule
