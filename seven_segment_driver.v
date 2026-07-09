module seven_segment_driver(
    input clk,
    input [6:0] battery,
    input [1:0] mode,
    output reg [6:0] seg,
    output reg [3:0] an
);

reg [19:0] refresh_counter;
wire [1:0] digit_select;
reg [3:0] digit;

always @(posedge clk)
    refresh_counter <= refresh_counter + 1;

assign digit_select = refresh_counter[19:18];

always @(*)
begin
    case(digit_select)

        2'b00: begin
            an = 4'b1110;
            digit = battery % 10;
        end

        2'b01: begin
            an = 4'b1101;
            digit = battery / 10;
        end

        2'b10: begin
            an = 4'b1011;
            digit = mode;   // show mode number
        end

        default: begin
            an = 4'b1111;
            digit = 0;
        end
    endcase
end

always @(*)
begin
    case(digit)
        0: seg = 7'b1000000;
        1: seg = 7'b1111001;
        2: seg = 7'b0100100;
        3: seg = 7'b0110000;
        4: seg = 7'b0011001;
        5: seg = 7'b0010010;
        6: seg = 7'b0000010;
        7: seg = 7'b1111000;
        8: seg = 7'b0000000;
        9: seg = 7'b0010000;
        default: seg = 7'b1111111;
    endcase
end

endmodule