`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/16 15:37:37
// Design Name: 
// Module Name: lamp_display
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


module lamp_display (
    input  wire [3:0] num,
    output reg  [6:0] lamp_data
);
  always @(num) begin
    case (num)
      1: lamp_data <= 8'b11111110;
      2: lamp_data <= 8'b11111101;
      3: lamp_data <= 8'b11111011;
      4: lamp_data <= 8'b11110111;
      5: lamp_data <= 8'b11101111;
      6: lamp_data <= 8'b11011111;
      7: lamp_data <= 8'b10111111;
      default: lamp_data <= 8'b11111111;
    endcase
  end
endmodule
