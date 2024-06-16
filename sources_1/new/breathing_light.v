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
    input wire rst,
    input wire clk,
    input wire [1:0] light_lever,
    output wire light
);
  // 时钟频率为50MHz，时钟周期为1 / 50MHz = 20ns
  // 约定一个PWN周期为256个时钟周期, 生成PWN频率为 50MHz / 256 = 195312.5Hz, 一个PWM周期为 256 * 20ns = 5.12us
  parameter period = 256;
  // 呼吸灯亮度变化的周期, 一个时钟周期为20ns, 一个呼吸灯周期为 20000000 * 20ns = 400ms
  reg [31:0] breathing_cycle = 25000000;

  reg [31:0] cnt;
  parameter Init = 0, Lighter = 1, Darker = 2;
  reg  [ 1:0] state;
  reg  [31:0] duty;
  reg  [ 7:0] index;
  wire [ 7:0] sin_value;
  sin_table sin_inst (
      .index(index),
      .sin_value(sin_value)
  );

  initial begin
    state <= Init;
  end

  always @(light_lever) begin
    case (light_lever)
      2'b00: breathing_cycle = 15000000;  // 0.6s
      2'b01: breathing_cycle = 25000000;  // 1s
      2'b10: breathing_cycle = 35000000;  // 1.4s
      2'b11: breathing_cycle = 50000000;  // 2s
    endcase
    state <= Init;
  end

  always @(posedge clk or posedge rst) begin
    if (!rst) begin
      state <= Init;
    end else begin
      case (state)
        Init: begin
          state <= Lighter;
          cnt   <= 0;
          index <= 0;
        end
        Lighter: begin
          cnt <= cnt + 1;
          if (cnt >= breathing_cycle) begin
            state <= Darker;
          end
        end
        Darker: begin
          cnt <= cnt - 1;
          if (cnt <= 0) begin
            state <= Lighter;
          end
        end
      endcase
      // * index <= cnt / breathing_cycle * 256;
      index <= cnt / (breathing_cycle / 256);
      duty  <= sin_value;
    end
  end

  pwm pwm_light (
      .rst(rst),
      .clk(clk),
      .duty(duty),
      .period(period),
      .pwm_out(light)
  );

endmodule

