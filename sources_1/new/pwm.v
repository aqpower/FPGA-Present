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
module pwm (
    input  wire        rst,
    input  wire        clk,
    input  wire [31:0] duty,    // 占空比
    input  wire [31:0] period,  // 将多少个时钟周期作为一个PWM周期
    output reg         pwm_out
);

  parameter Init = 0, High = 1, Low = 2;
  reg [1:0] state;
  reg [32:0] cnt;

  initial begin
    state <= Init;
  end

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      state <= Init;
    end else begin
      case (state)
        Init: begin
          state <= High;
          cnt <= 0;
          pwm_out <= 0;
        end

        High: begin
          cnt <= cnt + 1;
          pwm_out <= 1;
          if (cnt >= duty) begin
            state <= Low;
          end
        end

        Low: begin
          cnt <= cnt + 1;
          pwm_out <= 0;
          if (cnt >= period) begin
            state <= High;
            cnt   <= 0;
          end
        end
      endcase
    end
  end

endmodule

