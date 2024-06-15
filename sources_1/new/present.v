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

module present(
    input wire rst,
    input wire clk,
    input wire btn,
    output wire btn_debounce,
    output wire light,
    output wire music
);

breathing_light light_module(
    .rst(rst),
    .clk(clk),
    .light(light)
);

music_gen music_module(
    .rst(rst),
    .clk(clk),
    .music(music)
);

debounce debounce_module(
    .clk(clk),
    .btn(btn),
    .btn_out(btn_debounce)
);

endmodule
