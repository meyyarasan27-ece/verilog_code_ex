`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// College: ADHI COLLEGE OF ENGINEERING AND TECHNOLOGY
// Engineer: MEYYARASAN S 
// 
// Create Date: 10.02.2026 22:56:14
// Design Name: Secured UART-Controlled ALU System
// Module Name: fpga_top
//
// Project Name: Design and Implementation of a Secure UART-Controlled ALU System Using FPGA
// Target Devices: (Specify FPGA, e.g., Xilinx Spartan-3E, Artix-7, etc.)
// Tool Versions: (Specify tool, e.g., Vivado 2025.2)
//
// Description:Top-level module integrating a secure UART interface with an ALU
//              system on FPGA. The module receives commands via UART,
//              performs arithmetic and logical operations, and outputs
//              results securely. 
//
// Dependencies: fpga_top.v , top_module_project.v , digit_lock.v ,
//                 baud_rate_gen.v , uart_rx.v, uart_tx.v , alu.v, .v 
// 
// Revision:
// Version  Date         Author(s)        Description
//  0.01    10.02.2026   MEYYARASAN S   Initial creation
//
// Additional Comments:
// - This design supports security features to validate commands before execution.
// - Ensure UART baud rate matches FPGA configuration.
//////////////////////////////////////////////////////////////////////////////////


module fpga_top(clk_50mhz,reset_btn,uart_rx,uart_tx,led);
input  wire clk_50mhz ;
input  wire reset_btn ;
input  wire uart_rx   ;
output wire uart_tx   ;  
output wire [3:0] led ;

wire auth;
wire tx_busy;

top_module_project uut (
    .clk(clk_50mhz),
    .reset(reset_btn),
    .rx_in(uart_rx),
    .tx_out(uart_tx),
    .auth_out(auth),
    .tx_busy_out(tx_busy));

    // LED indications
assign led[0] = auth;        // Authentication success
assign led[1] = tx_busy;     // UART TX busy
assign led[2] = ~reset_btn;  // System active
assign led[3] = uart_rx;     // UART RX activity

endmodule
