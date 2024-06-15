`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/12 21:14:51
// Design Name: 
// Module Name: PWN_GENERATOR
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


// PWM生成模块
module PWMGenerator (
    input clk,
    input rst,
    input [6:0] switch,
    output reg speed 
);
  reg [32:0] high_time;
  reg [32:0] pwm_cnt; 
  parameter period = 256;
  
// 0  14  29  43  57  71  86  100
  always @(speed_switch) begin
    case (speed_switch)
      7'b1111110: high_time <= 29;
      7'b1111101: high_time <= 57;
      7'b1111011: high_time <= 86;
      7'b1110111: high_time <= 114;
      7'b1101111: high_time <= 143;
      7'b1011111: high_time <= 171;
      7'b0111111: high_time <= 256;
      default: high_time <= 0;
    endcase
  end

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      pwm_cnt <= 0;
      speed   <= 0;
    end else begin
      // 高电平周期内
      if (pwm_cnt < high_time - 1) begin
        pwm_cnt <= pwm_cnt + 1;
        speed   <= 1;
        // 低电平周期内
      end else if (pwm_cnt < period - 1) begin
        pwm_cnt <= pwm_cnt + 1;
        speed   <= 0;
        // 一个完整的PWM周期结束
      end else begin
        pwm_cnt <= 0;
      end
      if (speed_switch == 7'b1111111) speed <= 0;
    end
  end
endmodule
