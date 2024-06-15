`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/12 20:55:27
// Design Name: 
// Module Name: breathing_light
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

module breathing_light (
    input  wire rst,
    input  wire clk,   
    output wire light  
);
  // 时钟频率为50MHz，时钟周期为1 / 50MHz = 20ns
  // 一个PWN周期为256个时钟周期, 生成PWN频率为 50MHz / 256 = 195312.5Hz, 一个PWM周期为 256 * 20ns = 5.12us
  parameter period = 256;
  // 呼吸灯亮度变化的周期, 一个时钟周期为20ns, 一个呼吸灯周期为 20000000 * 20ns = 400ms
  parameter t = 20000000;
  reg [31:0] cnt;
  parameter Lighter = 1, Darker = 0;
  reg state;
  reg [7:0] duty;
  reg [7:0] index;
  wire [7:0] sin_value;
  sin_table sin_inst (
      .index(index),
      .sin_value(sin_value)
  );

  initial begin
    cnt   = 0;
    index = 0;
    state = Lighter;
  end

  always @(posedge clk) begin
    case (state)
      Lighter: begin
        cnt = cnt + 1;
        if (cnt >= t) begin
          state = Darker;
        end
      end
      Darker: begin
        cnt = cnt - 1;
        if (cnt <= 0) begin
          state = Lighter;
        end
      end
    endcase
    index = cnt / (t / 256);
    duty = sin_value;
  end

  pwm pwm_inst (
      .rst(rst),
      .clk(clk),
      .duty(duty),
      .period(period),
      .pwm_out(light)
  );

endmodule

