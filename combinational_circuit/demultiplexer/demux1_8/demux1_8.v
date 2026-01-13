`timescale 1ns / 1ps
module demux1_8(data,s,out_data);
input wire data ;
input wire [2:0]s ;
output reg [7:0]out_data ;

always @(*)begin
out_data = 8'b00000000;
case(s)
3'b000 : out_data[0] = data ;
3'b001 : out_data[1] = data ;
3'b010 : out_data[2] = data ;
3'b011 : out_data[3] = data ;
3'b100 : out_data[4] = data ;
3'b101 : out_data[5] = data ;
3'b110 : out_data[6] = data ;
3'b111 : out_data[7] = data ;

endcase
/* 1_4 demux
 out_data = data ? (4'b0001 << s):4'b0000 ;*/
end
endmodule
