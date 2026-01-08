`timescale 1ns / 1ps
module traffic_light(clk,reset,light);
input wire clk,reset ;
output reg [1:0]light ;

parameter red = 2'b00 , green = 2'b01 ,yellow = 2'b10 ;

parameter red_time = 8 ;
parameter green_time = 5 ;
parameter yellow_time = 3 ;

reg  [1:0]state,next_state ;
reg [3:0]timer ;

always @(posedge clk or posedge reset)begin
         if(reset)
            begin
              state <= red ;
              timer <= 0 ;
            end
         else
            begin
                state <= next_state ;
                if(state != next_state)
                   timer <= 0 ;
                 else
                    timer <= timer + 1 ;
              end
         end
         
always @(*)begin
           next_state = state ;
           
           case(state)
           red :if(timer == red_time-1)
                   next_state = green ; 
                   
           green : if(timer == green_time-1)
                     next_state = yellow ;
                     
           yellow : if(timer == yellow_time-1)
                      next_state = red ;  
                      
           default : next_state = red ;
           endcase
           end
           
always @(*)begin
           case(state)
           red : light = red ;
           yellow : light = yellow ;
           green : light = green ;
           default : light = red ;
           endcase
           end
           
endmodule
