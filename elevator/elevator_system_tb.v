`timescale 1ns / 1ps
module elevator_system_tb();
reg clk , reset , move_up , move_down ,extra_waiting ;
wire state_output ;

elevator_system uut(.clk(clk)
                   , .reset(reset)
                   , .move_up(move_up)
                   , .move_down(move_down)
                   , .extra_waiting(extra_waiting)
                   , .state_output(state_output));
                   
always #5 clk = ~clk ;

initial begin
   clk = 0;
   reset = 1;
   move_up = 0;
   move_down = 0;
   extra_waiting = 0;
   
   #10 reset = 0 ;
   
   #10 move_up = 1;
   #20 move_up = 0;
   
   #10 move_down = 1;
   #20 move_down = 0;
   
   #5 extra_waiting = 1;
   #10 extra_waiting = 0;
   #10 move_up = 0 ;
   #10 move_down = 0 ;
   #20 move_up = 1;
   #20 move_up = 0;
   
   #50 $finish ;
end

initial begin
   $monitor("time = %0t | clk = %b | reset = %b | move_up = %b | move_down = %b | extra_waiting = %b | state_output = %b "
            ,$time , clk , reset , move_up , move_down , extra_waiting , state_output);
end
endmodule
