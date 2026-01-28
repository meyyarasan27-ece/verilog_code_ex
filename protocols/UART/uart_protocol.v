`timescale 1ns / 1ps
module uart_protocol #(parameter integer DATA = 8)(clk,
                                                  reset,
                                                  tx_data,
                                                  rx_data,
                                                  tx_start,
                                                  tx_out,
                                                  tx_busy,
                                                  rx_valid,
                                                  parity_error);
input wire clk ,reset,tx_start ;
input wire [DATA - 1 : 0 ]tx_data ;
output wire [DATA - 1 : 0 ]rx_data ;
output wire tx_out ,tx_busy,rx_valid,parity_error ;
wire rx_in ;

uart_tx transmitter(.clk(clk),
                    .reset(reset),
                    .tx_start(tx_start),
                    .tx_data(tx_data),
                    .tx_out(tx_out),
                    .tx_busy(tx_busy));
 
 uart_rx reciever(.clk(clk),
                  .reset(reset),
                  .rx_in(tx_out),
                  .rx_data(rx_data),
                  .parity_error(parity_error),
                  .rx_valid(rx_valid));
endmodule
