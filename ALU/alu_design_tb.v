`timescale 1ns / 1ps
module alu_design_tb #(parameter integer WIDTH = 8)();
reg  [WIDTH-1:0] a, b;
reg  [3:0]       alu_sel;
wire [WIDTH-1:0] result;
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;
wire             carry;
wire             overflow;
wire             div_by_zero;
wire             zero;

    alu_design #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .alu_sel(alu_sel),
        .result(result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow),
        .remainder(remainder),
        .quotient(quotient),
        .div_by_zero(div_by_zero)
    );


    task show;
        begin
            $display("T=%0t | SEL=%b | A=%0d B=%0d | RES=%0d | Q=%0d R=%0d | C=%b OV=%b Z=%b DBZ=%b",
                     $time, alu_sel, a, b, result,
                     quotient, remainder, carry, overflow, zero, div_by_zero);
        end
    endtask

    initial begin
        // ================= ADDITION =================
        alu_sel = 4'b0000;

        a = 10; b = 20; #10; show();   // no overflow
        a = 200; b = 100; #10; show(); // overflow
        a = 0; b = 0; #10; show();     // zero

        // ================= SUBTRACTION =================
        alu_sel = 4'b0001;

        a = 50; b = 20; #10; show();   // no borrow
        a = 20; b = 50; #10; show();   // borrow (underflow)
        a = 0;  b = 0;  #10; show();   // zero

        // ================= MULTIPLICATION =================
        alu_sel = 4'b0010;

        a = 5;  b = 6;  #10; show();   // no overflow
        a = 25; b = 25; #10; show();   // overflow
        a = 0;  b = 100;#10; show();   // zero

        // ================= DIVISION =================
        alu_sel = 4'b0011;

        a = 25; b = 4;  #10; show();   // normal division
        a = 100; b = 10;#10; show();   // exact division
        a = 10; b = 0;  #10; show();   // divide by zero

        // ================= LOGIC =================
        alu_sel = 4'b0100; a = 8'hAA; b = 8'h0F; #10; show(); // AND
        alu_sel = 4'b0101;                     #10; show(); // OR
        alu_sel = 4'b0110;                     #10; show(); // XOR
        alu_sel = 4'b0111; a = 8'h0F;           #10; show(); // NOT

        // ================= SHIFTS =================
        alu_sel = 4'b1000; a = 8'b0001_0001; #10; show(); // left shift
        alu_sel = 4'b1001;                   #10; show(); // right shift

        $finish;
    end
    
endmodule
