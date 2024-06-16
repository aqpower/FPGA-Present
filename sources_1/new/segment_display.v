`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/16 15:02:02
// Design Name: 
// Module Name: segment_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module segment_display (
    input wire clk,
    input wire [3:0] num,
    output reg [7:0] digit_enable,
    output reg [7:0] segment_data
);

  function [7:0] digit_num(input [3:0] num);
    begin
      case (num)
        4'd0: digit_num = 8'b1111_1100;
        4'd1: digit_num = 8'b0110_0000;
        4'd2: digit_num = 8'b1101_1010;
        4'd3: digit_num = 8'b1111_0010;
        4'd4: digit_num = 8'b0110_0110;
        4'd5: digit_num = 8'b1011_0110;
        4'd6: digit_num = 8'b1011_1110;
        4'd7: digit_num = 8'b1110_0000;
        4'd8: digit_num = 8'b1111_1110;
        4'd9: digit_num = 8'b1111_0110;
        default: digit_num = 8'b1111_1111;
      endcase
    end
  endfunction

  always @(posedge clk) begin
    digit_enable <= 8'b11111110;  // Enable the first digit (or any other digit as required)
    segment_data <= digit_num(num);
  end
endmodule
