module mode_controller(
    input clk,
    input rst,
    input [3:0] sensor,
    output reg [1:0] mode
);

parameter SLEEP  = 2'b00;
parameter IDLE   = 2'b01;
parameter ACTIVE = 2'b10;

parameter HIGH = 4'd10;
parameter LOW  = 4'd6;

always @(posedge clk or posedge rst)
begin
    if(rst)
        mode <= SLEEP;
    else
    begin
        if(sensor < LOW)
            mode <= SLEEP;
        else if(sensor >= LOW && sensor < HIGH)
            mode <= IDLE;
        else
            mode <= ACTIVE;
    end
end

endmodule