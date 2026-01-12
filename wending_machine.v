`timescale 1ns / 1ps
module wending_machine(clk,reset,data_in,data_out5,data_out10,data_out20);
input wire clk,reset ; 
input wire [4:0]data_in ;
output reg data_out5 , data_out10 , data_out20 ;

localparam  s0 = 2'b00  ;
localparam integer COIN_5 = 5 ,COIN_10 = 10 , COIN_20 = 20 ;

reg [1:0]state,next_state ;

always @(posedge clk or posedge reset) begin
      if(reset)
        state <= s0 ;
      else 
        state <= next_state ;
end

always @(*) begin
 next_state = state ;
 data_out5 = 0;
 data_out10 = 0 ;
 data_out20 = 0 ;
 
 case(state)
   s0 :  begin 
              if(data_in == COIN_5)
                begin                
                  data_out5 = 1 ;    
                  next_state = s0 ;  
                end                  
                
              else if(data_in == COIN_10)
                begin              
                 data_out10  = 1 ; 
                 next_state = s0 ; 
                end                
              else if(data_in == COIN_20)
                 begin               
                   data_out20 = 1 ;  
                   next_state = s0 ; 
                 end                 
                
                else
                next_state = s0 ;       
          end
   default : next_state = s0 ;
        
 endcase
end
endmodule
