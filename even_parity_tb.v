`timescale 1ns / 1ps
module even_parity_tb();
reg [3:0]data ;
wire pout ;

integer i ;
even_paritybit_gen uut(.data(data), .pout(pout));

initial begin 
$monitor("time = %t || data = %b || pout = %b "
,$time,data,pout);
end

initial begin 
 for (i = 0 ; i < 16 ; i = i+1 ) begin
 data = i ;
 #10;
 end
 $finish;
end
endmodule
