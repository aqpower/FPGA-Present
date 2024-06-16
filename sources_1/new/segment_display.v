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

  always @(posedge clk) begin
    case (num)
      4'd0: begin
        digit_enable <= 8'b11111110;
        segment_data <= 8'b0000_0010;
      end
      4'd1: begin
        digit_enable <= 8'b11111110;
        segment_data <= 8'b0110_0000;
      end
      4'd2: begin
        digit_enable <= 8'b11111101;
        segment_data <= 8'b1101_1010;
      end
      4'd3: begin
        digit_enable <= 8'b11111011;
        segment_data <= 8'b1111_0010;
      end
      4'd4: begin
        digit_enable <= 8'b11110111;
        segment_data <= 8'b0110_0110;
      end
      4'd5: begin
        digit_enable <= 8'b11101111;
        segment_data <= 8'b1011_0110;
      end
      4'd6: begin
        digit_enable <= 8'b11011111;
        segment_data <= 8'b1011_1110;
      end
      4'd7: begin
        digit_enable <= 8'b10111111;
        segment_data <= 8'b1110_0000;
      end
      default: begin
        digit_enable <= 8'b11111111;
        segment_data <= 8'b1111_1111;
      end
    endcase
  end
endmodule
