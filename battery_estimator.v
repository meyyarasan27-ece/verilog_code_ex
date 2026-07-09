module battery_estimator(
    input clk,
    input rst,
    input [1:0] mode,
    output reg [6:0] battery
);

parameter ACTIVE = 2'b10;
parameter IDLE   = 2'b01;
parameter SLEEP  = 2'b00;

parameter SPEED = 50_000_000;

reg [25:0] counter;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        battery <= 7'd99;
        counter <= 0;
    end
    else
    begin
        if(counter == SPEED-1)
        begin
            counter <= 0;

            case(mode)
                ACTIVE:
                    if(battery >= 2)
                        battery <= battery - 2;
                IDLE:
                    if(battery >= 1)
                        battery <= battery - 1;
                SLEEP:
                    if(battery < 99)
                        battery <= battery + 1;
            endcase
        end
        else
            counter <= counter + 1;
    end
end

endmodule