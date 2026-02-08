`timescale 1ns / 1ps
module alu_design#(parameter integer WIDTH = 8)(a,b,alu_sel,result,
                                                carry,zero,overflow,
                                                remainder,quotient,div_by_zero);
input wire [WIDTH-1 : 0]a,b ;
input wire [3 : 0 ]alu_sel ;
output reg [WIDTH-1 : 0]result ;
output reg [WIDTH-1 : 0]remainder ;
output reg [WIDTH-1 : 0]quotient ;
output reg div_by_zero ;
output reg carry,overflow ;
output wire zero ;


reg [WIDTH : 0 ]temp_storage ;
localparam integer MULTIPLE_TEMP_WIDTH = 2 * WIDTH ;
reg [MULTIPLE_TEMP_WIDTH-1 : 0]temp_multiple_storage ;


always @(*)begin
  result = 0 ;
  carry = 0 ;
  overflow = 0 ;
  temp_storage = 0 ;
  remainder = 0 ;
  quotient = 0 ;
  div_by_zero = 0;
  temp_multiple_storage = 0 ;
  
  case(alu_sel)
    4'b0000 : begin //Addition
             temp_storage = a+b ;
             result = temp_storage[WIDTH-1 : 0] ;
             carry = temp_storage[WIDTH] ;
             overflow = carry ;
             end
             
    4'b0001 : begin //Subtraction
             temp_storage = a-b ;
             result = temp_storage[WIDTH-1 : 0]; 
             carry = temp_storage[WIDTH] ;
             overflow = ~carry ;
             
             end
             
    4'b0010 : begin //Multiplication
             temp_multiple_storage = a*b ;
             result = temp_multiple_storage[WIDTH-1 : 0] ;
             overflow = | temp_multiple_storage[MULTIPLE_TEMP_WIDTH-1 : WIDTH];
             end
             
    4'b0011 : begin // Division
             if (b == 0) begin
               div_by_zero = 1;
             end
             else begin
               quotient  = a / b ;
               remainder = a % b ;
             end
             end
             
             
    4'b0100 : result = a & b ; //AND
    4'b0101 : result = a | b ; //OR
    4'b0110 : result = a ^ b ; //XOR 
    4'b0111 : result = ~a ; //NOT 
    4'b1000 : result = a << 1 ; //LEFT SHIFT 
    4'b1001 : result = a >> 1 ; //RIGHT SHIFT
    
    default : result = 0 ;
  endcase
end

assign zero = (result == 0 ) ;
endmodule
