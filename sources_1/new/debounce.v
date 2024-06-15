`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/16 04:29:26
// Design Name: 
// Module Name: debounce
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


module debounce (
    input  wire clk,
    input  wire btn,
    output reg  btn_out
);

  // 时钟频率为50MHz，时钟周期为1 / 50MHz = 20ns
  // 1ms / 20ns = 50000个时钟周期
  parameter Idle = 0, Debounce = 1, Stable = 2;

  reg [1:0] state;

  reg btn_reg;
  reg [31:0] counter;

  initial begin
    btn_reg = 1;
    btn_out = 1;
    counter = 0;
    state   = Idle;
  end

  always @(posedge clk) begin
    if (btn_reg != btn) begin // 按键状态发生变化,进入消抖状态
      btn_reg <= btn;
      counter <= 0;
      state   <= Debounce;  
    end else begin
      case (state)
        Idle: begin
          counter <= 0;
          btn_out <= btn_out;  
        end
        Debounce: begin
          counter <= counter + 1;
          if (counter >= 15 * 50000) begin
            state <= Stable;
          end
        end
        Stable: begin
          btn_out <= btn_reg;  
          state   <= Idle;
        end
      endcase
    end
  end

endmodule

