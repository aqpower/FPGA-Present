`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/16 00:09:01
// Design Name: 
// Module Name: present_tb
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


module present_tb;

  reg  rst;
  reg  clk;
  wire light;
  always #10 clk = ~clk;

  present present_tb (
      .rst  (rst),
      .clk  (clk),
      .light(light)
  );

  initial begin
    rst = 1;
    clk = 0;
    #10 rst = 1;
  end
endmodule
