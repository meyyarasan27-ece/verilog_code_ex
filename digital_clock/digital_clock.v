`timescale 1ns / 1ps

module frequency_divider#(parameter integer CLK_FREQ_HZ = 50_000 ,
                          parameter integer TICK_FREQ_HZ = 1)(clk,reset,freq_1hz);
input wire clk,reset ;
output reg freq_1hz ;

localparam integer FULL_CYCLE = CLK_FREQ_HZ / TICK_FREQ_HZ ;
reg [$clog2(FULL_CYCLE)-1 : 0]full_cycle_count ;


always @(posedge clk or posedge reset)
begin
    if(reset)begin
      full_cycle_count <= 0 ;
      freq_1hz <= 0 ;
    end
    else if(full_cycle_count == FULL_CYCLE - 1)begin
         full_cycle_count <= 0 ;
         freq_1hz <= 1 ;
    end
    else begin
         full_cycle_count <= full_cycle_count + 1 ;
         freq_1hz <= 0 ;
    end
    end

endmodule


module digital_clock #(parameter integer CLK_FREQ_HZ = 50_000 ,
                      parameter integer TICK_FREQ_HZ = 1,
                      parameter integer MIN_VALUE = 60 ,
                      parameter integer SEC_VALUE = 60 ,
                      parameter integer HOUR_VALUE = 24 
                      )(clk,reset,out_hour,out_min,out_sec);
input wire clk,reset ;
output reg [$clog2(MIN_VALUE)-1:0]out_min ;
output reg [$clog2(SEC_VALUE)-1:0]out_sec ;
output reg [$clog2(HOUR_VALUE)-1:0]out_hour ;
wire freq_1hz ;
reg [$clog2(SEC_VALUE)-1:0]count_sec ;
reg [$clog2(MIN_VALUE)-1:0]count_min ;
reg [$clog2(HOUR_VALUE)-1:0]count_hour ;





frequency_divider #(.CLK_FREQ_HZ(CLK_FREQ_HZ), .TICK_FREQ_HZ(TICK_FREQ_HZ))frequency_1hz(.clk(clk), .reset(reset), .freq_1hz(freq_1hz));
localparam integer  hours = HOUR_VALUE - 1 ,minutes = MIN_VALUE - 1 , seconds = SEC_VALUE - 1 ;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        count_sec <= 0;
        count_min <= 0;
        count_hour <= 0;
        
    end 
    else if(freq_1hz)  begin
       if(count_sec == seconds)begin
          count_sec <= 0 ;
          
          if(count_min == minutes)begin
            count_min <= 0 ;
            
            if(count_hour == hours)begin
               count_hour <= 0 ;
            end
            else
               count_hour <= count_hour + 1;
          end
          else
             count_min <= count_min + 1;
       end
       else
         count_sec <= count_sec + 1;  
        
    end
    
    out_sec <= count_sec;
    out_min <= count_min ;
    out_hour <= count_hour ;
end

endmodule
