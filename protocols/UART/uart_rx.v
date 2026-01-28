`timescale 1ns / 1ps
module uart_rx #(parameter integer DATA = 8)(clk,reset,rx_in,rx_data,rx_valid,parity_error);
input wire clk ,reset , rx_in ;
output reg [DATA-1 : 0]rx_data ;
output reg rx_valid ,parity_error ;

wire baud_tick ;
baudrate_gen tick_generator(.clk(clk), .reset(reset), .baud_tick(baud_tick));

reg [$clog2(DATA) : 0]bit_cnt ;
reg [DATA-1 : 0]shift_register ;
reg [2:0]state ;
reg parity_check ;


localparam integer IDLE = 3'b000 ,
                   START = 3'b001 ,
                   DATA_STATE = 3'b010 ,
                   PARITY_STATE = 3'b100 ,
                   STOP = 3'b101 ;
                   
always @(posedge clk or posedge reset)
begin
     if(reset)begin
        state <= IDLE ;
        parity_error <= 1'b0 ;
        rx_valid <= 1'b0 ;
        bit_cnt <= 0 ;
        shift_register <= 0 ;
     end
     else begin 
          rx_valid <= 1'b0 ;
          
          case(state)
            IDLE : begin
                     if(rx_in == 1'b0) 
                          state <= START ;
                   end   
            START : begin 
                      if(baud_tick)begin
                        if(rx_in == 1'b0)begin
                           bit_cnt <= 1'b0 ;
                           parity_check <= 1'b0 ;
                           parity_error <= 1'b0 ;
                           state <= DATA_STATE ;
                        end
                        else 
                           state <= IDLE ;
                      end                    
                    end
                    
            DATA_STATE : begin
                           if(baud_tick)begin
                             shift_register <= {rx_in,shift_register[DATA-1 : 1]} ;
                             parity_check <= parity_check ^ rx_in ;
                             
                             if(bit_cnt == DATA-1)begin
                                bit_cnt <= 0 ;
                                state <= PARITY_STATE ;
                             end
                             else begin
                                bit_cnt <= bit_cnt + 1 ;
                             end
                           end
                         
                         end
                         
            PARITY_STATE : begin
                            if(baud_tick)begin
                            state <= STOP ;
                              if(parity_check != rx_in)
                                parity_error <= 1'b1 ;
                              
                            end
                          end 
            STOP : begin
                     if(baud_tick)begin
                       if(rx_in == 1)begin
                          rx_data <= shift_register ;
                          rx_valid <= 1'b1 ;
                       end 
                       state <= IDLE ;
                     end  
                   end       
          endcase
     end
end
endmodule
