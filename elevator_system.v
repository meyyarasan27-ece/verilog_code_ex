`timescale 1ns / 1ps
module elevator_system(clk,reset,move_down,move_up,extra_waiting,state_output);
input wire clk , reset , move_down , move_up , extra_waiting ;
output reg state_output ;
reg [2:0]state ,next_state ;

localparam idle = 3'b000 ,
           moving_down = 3'b001 ,
           moving_up = 3'b010 ,
           stopping = 3'b011 ,
           door_opening = 3'b100 ,
           open_door = 3'b101 ,
           door_closing = 3'b110 , 
           next_stop_processing = 3'b111 ;

always @(posedge clk or posedge reset )begin
        
        if(reset)
          state <= idle ;
        else
           state <= next_state ;

end

always @(*)begin
  next_state = state;

     case(state)
         idle : begin
                     if(move_up)
                        next_state = moving_up ;
                      
                     else if(move_down)
                         next_state = moving_down ;
                      
                     else 
                         next_state = idle ;
                      
                       
                 end
                 
         moving_down : next_state = stopping ;
         moving_up : next_state = stopping ;
         stopping : begin
                     next_state = door_opening ;
                  end
         door_opening : begin
                      next_state = open_door ;
                  end
         open_door : begin
                      next_state = door_closing ;
                  end
          door_closing : begin
                     if(extra_waiting)begin
                       next_state = door_opening ;
                     end
                     else
                        next_state = next_stop_processing ;
                   end
         next_stop_processing : begin
                    if(move_up)
                      next_state = moving_up ;
                   else if(move_down)
                      next_state = moving_down ;
                   else
                      next_state = idle ;
                   end 
                   
         default : next_state = idle ;  
     endcase
end

always @(*)begin
   state_output = (state != idle) ;
end

endmodule
