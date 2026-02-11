`timescale 1ns / 1ps
module uart_tx #(parameter integer DATA = 8)(clk,reset,tx_data,tx_start,tx_out,tx_busy);
input wire clk ,reset,tx_start ;
input wire [DATA - 1 : 0 ]tx_data ;
output reg tx_out ,tx_busy ;
wire baud_tick  ;
reg parity_bit ;

reg [$clog2(DATA) : 0 ]bit_cnt  ;
reg [DATA-1:0]shift_register ;
reg [2:0]state    ;

baud_rate_gen tick_generator(.clk(clk), .reset(reset), .baud_tick(baud_tick));


localparam IDLE  =  3'b000  ,
           START =  3'b001  ,
           DATA_STATE  =  3'b010 ,
           PARITY_STATE = 3'b011 ,
           STOP  =  3'b100  ;

always @(posedge clk or posedge reset)
begin
     if(reset)begin
       state <= IDLE   ;
       tx_busy <= 1'b0 ;
       tx_out <= 1'b1  ;
       bit_cnt <= 0    ;
       shift_register <= 0;  
       parity_bit <= 0;  
     end
     else  begin
     if(baud_tick)begin
       case(state)
         IDLE : begin
                tx_out <= 1'b1  ;
                tx_busy <= 1'b0 ;
                
                if(tx_start) begin
                  tx_busy <= 1'b1 ;
                  shift_register <= tx_data ;
                  parity_bit <= ^tx_data ;
                  bit_cnt <= 0   ;
                  state <= START ;
                end
                end
                
         START : begin
                   tx_out  <= 1'b0 ;
                   state   <=  DATA_STATE ;
                 end       
        DATA_STATE : begin
                       tx_out <= shift_register[0] ;
                       shift_register <= shift_register >> 1 ;
                       
                       if(bit_cnt == DATA - 1)begin
                         state   <= PARITY_STATE ;
                         bit_cnt <= 1'b0 ;
                       end
                       else begin
                        bit_cnt <= bit_cnt + 1 ;
                       end
                     end
        PARITY_STATE : begin
                       tx_out <= parity_bit ;
                       state  <= STOP ;
                       end
        STOP : begin
                tx_out <= 1'b1  ;
                tx_busy <= 1'b1 ;
                state <= IDLE   ;
               end
        
       endcase
     
     end
     end
end
endmodule
