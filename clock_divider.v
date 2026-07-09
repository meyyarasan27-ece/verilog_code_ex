module clock_divider(
    input clk,
    input rst,
    output reg slow_clk
);

reg [26:0] counter;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        counter <= 0;
        slow_clk <= 0;
    end
    else
    begin
        if(counter == 50_000_000)
        begin
            counter <= 0;
            slow_clk <= ~slow_clk;
        end
        else
            counter <= counter + 1;
    end
end

endmodule