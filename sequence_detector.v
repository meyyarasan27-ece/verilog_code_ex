`timescale 1ns / 1ps
module sequence_detector(clk,reset,din,y);
input wire clk,reset,din ;
output reg y ;

parameter s0 = 2'b00 ,s1 = 2'b01, s2 = 2'b10 ,s3 = 2'b11 ;
reg [1:0]next_state ,state ;

always @(posedge clk or posedge reset)begin
          if(reset)
              state <= s0 ;
          else
              state <= next_state ;
          end
always @(*)begin
next_state = state ;
y = 0;
case(state)
   s0 : begin
        if(din)begin
               next_state = s1 ;
               end
         else  begin
               next_state = s0;
               end      
          end
          
   s1 : begin
        if(din)begin
               next_state = s2;
               end
         else  begin
               next_state = s0;
               end      
          end 
      
      
    s2 : begin
        if(din)begin
               next_state = s3 ;
               y = 1 ;
               end
         else  begin
               next_state = s0 ;
               end      
          end
          
    s3 : begin
        if(din)begin
               next_state = s3 ;
               y = 1 ;
               end
         else  begin
               next_state =  s0;
               end      
          end
       default : begin next_state = s0 ;  y = 0 ;end          
endcase
end          
          
endmodule
