`timescale 1ns / 1ps
module digital_clock(clk,reset,out_hour,out_min,out_sec);
input wire clk,reset ;
output reg [5:0]out_min,out_sec ;
output reg [4:0]out_hour ;

reg enable_min ,enable_hour ;
reg [5:0]count_sec ,count_min ;
reg [4:0]count_hour ;

localparam integer  hours = 23 ,minutes = 59 , seconds = 59 ;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        count_sec <= 0;
        count_min <= 0;
        count_hour <= 0;
        enable_min <= 0;
        enable_hour <= 0;
    end else begin
        
        if(count_sec == seconds) begin
            count_sec <= 0;
            enable_min <= 1;   

        end else begin
            count_sec <= count_sec + 1;
            enable_min <= 0;
        end

       
        if(enable_min) begin
            if(count_min == minutes) begin
                count_min <= 0;
                enable_hour <= 1;  
            end else begin
                count_min <= count_min + 1;
                enable_hour <= 0;
            end
        end

      
        if(enable_hour) begin
            if(count_hour == hours)
                count_hour <= 0;
            else
                count_hour <= count_hour + 1;
        end

        
        out_sec <= count_sec;
        out_min <= count_min;
        out_hour <= count_hour;
    end
end

endmodule
