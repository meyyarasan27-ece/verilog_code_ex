`timescale 1ns / 1ps

module frequency_divider (reset,clk,clk_output_10);
    input  wire clk,  reset;      
    output reg  clk_output_10  ;

localparam integer half_count = 5 ;
reg [2:0]count ;

always @(posedge clk)begin 
                           if(reset) begin 
                                count <= 0 ;
                                clk_output_10 <= 0 ;
                            end
                            
                              else begin
                                 if(count == half_count - 1 )begin
                                     count <= 0 ;
                                     clk_output_10 <= ~clk_output_10 ; 
                                     end
                                     else begin
                                         count <= count + 1 ;
                                         end  
                              end
                           end 

endmodule