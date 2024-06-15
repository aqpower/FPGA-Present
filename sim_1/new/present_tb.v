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
  wire music;
  reg  btn;
  wire btn_debounce;
  always #10 clk = ~clk;

  present present_tb (
      .rst(rst),
      .clk(clk),
      .btn(btn),
      .btn_debounce(btn_debounce),
      .light(light),
      .music(music)
  );

  initial begin
    rst = 1;
    clk = 0;
    #10 rst = 1;
    btn = 1;

    // 10ms后按下按钮
    #10000000 btn = 0;
    // 5ms后松开按钮
    #5000000 btn = 1;

    // 100ms后按下按钮
    #100000000 btn = 0;
    // 5ms后松开按钮 
    #5000000 btn = 1;
    // 10ms后按下按钮
    #10000000 btn = 0;
    // 5ms后松开按钮
    #5000000 btn = 1;
    // 10ms后按下按钮
    #10000000 btn = 0;
    // 按住100ms
    #100000000 btn = 1;
    // 10ms后按下按钮
    #10000000 btn = 0;
    // 5ms后松开按钮
    #5000000 btn = 1;
    // 5ms后按下按钮
    #5000000 btn = 0;
    // 3ms后松开按钮
    #3000000 btn = 1;
  end


endmodule
