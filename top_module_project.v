`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// College: ADHI COLLEGE OF ENGINEERING AND TECHNOLOGY
// Engineer: MEYYARASAN S , ARUN K , KEERTHANA S :
// 
// Create Date: 10.02.2026 20:43:58
// Design Name: Secured UART-Controlled ALU System
// Module Name: top_module_project
//
// Project Name: Design and Implementation of a Secure UART-Controlled ALU System Using FPGA
// Target Devices: (Specify FPGA, e.g., Xilinx Spartan-3E, Artix-7, etc.)
// Tool Versions: (Specify tool, e.g., Vivado 2025.2)
//
// Description: Top-level module integrating a secure UART interface with an ALU
//              system on FPGA. The module receives commands via UART,
//              performs arithmetic and logical operations, and outputs
//              results securely.
// 
// Dependencies: fpga_top.v , top_module_project.v , digit_lock.v ,
//               baud_rate_gen.v , uart_rx.v, uart_tx.v , alu.v, .v 
// 
// Revision:
// Version  Date         Author(s)        Description
//  0.01    10.02.2026   MEYYARASAN S   Initial creation
//
// Additional Comments:
// - This design supports security features to validate commands before execution.
// - Ensure UART baud rate matches FPGA configuration.
//////////////////////////////////////////////////////////////////////////////////


module top_module_project(clk, reset,rx_in, tx_out,auth_out,tx_busy_out);
input  wire clk         ;
input  wire reset       ;
input  wire rx_in       ;
output wire tx_out      ;
output wire auth_out    ;     
output wire tx_busy_out ;

    // UART RX signals
    wire [7:0] rx_data;
    wire rx_valid;
    wire parity_error;

    // Authentication
    wire auth;

    // ALU signals
    reg  [7:0] alu_a, alu_b;
    reg  [3:0] alu_sel;
    wire [7:0] alu_result;
    wire carry, zero, overflow;
    wire [7:0] remainder, quotient;
    wire div_by_zero;

    // UART TX signals
    reg  [7:0] tx_data;
    reg  tx_start;
    wire tx_busy;


    reg [2:0] state;

localparam WAIT_PASS = 3'd0,
           GET_A     = 3'd1,
           GET_B     = 3'd2,
           GET_OP    = 3'd3,
           SEND_RES  = 3'd4;

    //  UART RX 
    uart_rx uart_rx_inst (
        .clk(clk),
        .reset(reset),
        .rx_in(rx_in),
        .rx_data(rx_data),
        .rx_valid(rx_valid),
        .parity_error(parity_error)
    );

    // DIGITAL LOCK 
    digital_lock lock_inst (
        .clk(clk),
        .reset(reset),
        .rx_data(rx_data),
        .rx_done(rx_valid),
        .auth(auth)
    );

    //  ALU 
    alu alu_inst (
        .a(alu_a),
        .b(alu_b),
        .alu_sel(alu_sel),
        .result(alu_result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow),
        .remainder(remainder),
        .quotient(quotient),
        .div_by_zero(div_by_zero)
    );

    //  UART TX 
    uart_tx uart_tx_inst (
        .clk(clk),
        .reset(reset),
        .tx_data(tx_data),
        .tx_start(tx_start),
        .tx_out(tx_out),
        .tx_busy(tx_busy)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_PASS;
            alu_a <= 0;
            alu_b <= 0;
            alu_sel <= 0;
            tx_data <= 0;
            tx_start <= 0;
        end else begin
            tx_start <= 0;  

            case (state)
                WAIT_PASS: begin
                    if (auth)
                        state <= GET_A;
                end

                GET_A: begin
                    if (rx_valid) begin
                        alu_a <= rx_data;
                        state <= GET_B;
                    end
                end

                GET_B: begin
                    if (rx_valid) begin
                        alu_b <= rx_data;
                        state <= GET_OP;
                    end
                end

                GET_OP: begin
                    if (rx_valid) begin
                        alu_sel <= rx_data[3:0];
                        state <= SEND_RES;
                    end
                end

                SEND_RES: begin
                    if (!tx_busy) begin
                        tx_data <= alu_result;
                        tx_start <= 1;
                        state <= GET_A;   
                    end
                end
            endcase
        end
    end
    
    assign auth_out    = auth;
    assign tx_busy_out = tx_busy;

endmodule
