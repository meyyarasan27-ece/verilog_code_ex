`timescale 1ns / 1ps
module up_down_counter(reset, clk, mode, count);
input wire reset, clk, mode;
output reg [3:0] count;

always @(negedge clk) begin
    if (reset && mode)
        count <= 4'b1111;   
    else if(reset && !mode)
         count <= 4'b0000 ;
    else begin
         if(mode)
             count <= count - 1;  
            else
             count <= count + 1; 
        
    end
end

endmodule
