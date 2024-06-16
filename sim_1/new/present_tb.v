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

  reg rst;
  reg clk;
  wire light;
  wire music;
  reg music_en;
  wire music_en_debounce;
  wire [7:0] digit_enable;
  wire [7:0] segment_data;
  wire [6:0] lamp_data;
  reg [1:0] light_lever;

  present present_tb (
      .rst(rst),
      .clk(clk),
      .music_en(music_en),
      .light_lever(light_lever),
      .music_en_debounce(music_en_debounce),
      .light(light),
      .music(music),
      .digit_enable(digit_enable),
      .segment_data(segment_data),
      .lamp_data(lamp_data)
  );
  always #10 clk = ~clk;

  initial begin
    light_lever = 2'b00;
    rst = 1;
    clk = 0;
    #10 rst = 1;
    music_en = 1;

    // 10ms后按下按钮
    #10000000 music_en = 0;
    // 5ms后松开按钮
    #5000000 music_en = 1;

    // 100ms后按下按钮
    #100000000 music_en = 0;
    // 5ms后松开按钮 
    #5000000 music_en = 1;
    // 10ms后按下按钮
    #10000000 music_en = 0;
    // 5ms后松开按钮
    #5000000 music_en = 1;
    // 10ms后按下按钮
    #10000000 music_en = 0;
    // 按住100ms
    #100000000 music_en = 1;
    // 10ms后按下按钮
    #10000000 music_en = 0;
    // 5ms后松开按钮
    #5000000 music_en = 1;
    // 5ms后按下按钮
    #5000000 music_en = 0;
    // 3ms后松开按钮
    #3000000 music_en = 1;
    light_lever = 2'b01;
  end


endmodule
