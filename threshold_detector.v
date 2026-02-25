module threshold_detector(
    input clk,
    input rst,
    input [3:0] sensor,
    output reg threshold_cross
);

parameter HIGH = 10;
parameter LOW  = 6;

always @(posedge clk or posedge rst)
begin
    if(rst)
        threshold_cross <= 0;
    else
    begin
        if(sensor >= HIGH)
            threshold_cross <= 1;
        else if(sensor <= LOW)
            threshold_cross <= 0;
    end
end

endmodule