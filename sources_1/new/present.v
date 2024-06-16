`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/12 20:43:40
// Design Name: 
// Module Name: present
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

module present (
    input wire rst,
    input wire clk,
    input wire music_en,
    input wire [1:0] light_lever,
    output wire music_en_debounce,
    output wire light,
    output wire music,
    output wire [7:0] digit_enable,
    output wire [7:0] segment_data,
    output wire [6:0] lamp_data
);

  breathing_light light_module (
      .rst(rst),
      .clk(clk),
      .light_lever(light_lever),
      .light(light)
  );


  debounce debounce_module (
      .clk(clk),
      .btn(music_en),
      .btn_out(music_en_debounce)
  );

  music_gen music_module (
      .rst(rst),
      .clk(clk),
      .music_en(music_en_debounce),
      .music(music),
      .digit_enable(digit_enable),
      .segment_data(segment_data),
      .lamp_data(lamp_data)
  );

endmodule
