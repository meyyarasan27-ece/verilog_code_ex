`timescale 1ns / 1ps

module top_adaptive_iot(
    input clk,
    input btnC,
    input [3:0] sw,
    output [6:0] seg,
    output [3:0] an,
    output [4:0] led
);

wire slow_clk;
wire threshold_cross;
wire [1:0] mode;
wire tx_enable;
wire [6:0] battery;

// Clock Divider
clock_divider CD(
    .clk(clk),
    .rst(btnC),
    .slow_clk(slow_clk)
);

// Threshold Detector
threshold_detector TD(
    .clk(slow_clk),
    .rst(btnC),
    .sensor(sw),
    .threshold_cross(threshold_cross)
);

mode_controller MC(
    .clk(slow_clk),
    .rst(btnC),
    .sensor(sw),
    .mode(mode)
);

// Transmission Control
assign tx_enable = (mode == 2'b10);

// Battery
battery_estimator BE(
    .clk(clk),
    .rst(btnC),
    .mode(mode),
    .battery(battery)
);

// 7 Segment
seven_segment_driver SSD(
    .clk(clk),
    .battery(battery),
    .mode(mode),
    .seg(seg),
    .an(an)
);

// LED Indicators
assign led[0] = (mode == 2'b00);
assign led[1] = (mode == 2'b01);
assign led[2] = (mode == 2'b10);
assign led[3] = tx_enable;
assign led[4] = threshold_cross;

endmodule