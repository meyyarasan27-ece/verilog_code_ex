`timescale 1ns / 1ps
module digit_lock(
    input clk,
    input reset,
    input [7:0] rx_data,
    input rx_done,
    output reg auth
);

reg [1:0]  count;
reg [31:0] entered;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        auth    <= 0;
        count   <= 0;
        entered <= 0;
    end
    else if (rx_done && auth == 0) begin
        entered <= {entered[23:0], rx_data};
        count   <= count + 1;

        if (count == 3) begin
            if ({entered[23:0], rx_data} == "1416")
                auth <= 1;
            count <= 0;
        end
    end
end

endmodule
