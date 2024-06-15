`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/16 01:21:59
// Design Name: 
// Module Name: music_gen
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
// * 占空比决定了音量，而PWM的频率决定了音调。

module music_gen (
    input  wire rst,
    input  wire clk,
    output wire music
);

  parameter l_1 = 131;
  parameter l_2 = 147;
  parameter l_3 = 165;
  parameter l_4 = 175;
  parameter l_5 = 196;
  parameter l_6 = 220;
  parameter l_7 = 247;

  parameter m_1 = 262;
  parameter m_2 = 294;
  parameter m_3 = 330;
  parameter m_4 = 349;
  parameter m_5 = 392;
  parameter m_6 = 440;
  parameter m_7 = 494;

  parameter h_1 = 523;
  parameter h_2 = 587;
  parameter h_3 = 659;
  parameter h_4 = 698;
  parameter h_5 = 784;
  parameter h_6 = 880;
  parameter h_7 = 988;


  parameter NUM_NOTES = 25;
  reg [31:0] clk_freq = 50000000;  // 50 MHz 时钟频率
  reg [31:0] note_counter;
  reg [15:0] note_index;

  // 定义音符频率和持续时间
  reg [31:0] note_frequencies[0:NUM_NOTES-1];
  reg [31:0] note_durations[0:NUM_NOTES-1];

  initial begin
    note_frequencies[0] = m_5;
    note_frequencies[1] = m_5;
    note_frequencies[2] = m_6;
    note_frequencies[3] = m_5;
    note_frequencies[4] = h_1;
    note_frequencies[5] = m_7;
    note_frequencies[6] = m_5;
    note_frequencies[7] = m_5;
    note_frequencies[8] = m_6;
    note_frequencies[9] = m_5;
    note_frequencies[10] = h_2;
    note_frequencies[11] = h_1;
    note_frequencies[12] = m_5;
    note_frequencies[13] = m_5;
    note_frequencies[14] = h_5;
    note_frequencies[15] = h_3;
    note_frequencies[16] = h_1;
    note_frequencies[17] = m_7;
    note_frequencies[18] = m_6;
    note_frequencies[19] = h_4;
    note_frequencies[20] = h_4;
    note_frequencies[21] = h_3;
    note_frequencies[22] = h_1;
    note_frequencies[23] = h_2;
    note_frequencies[24] = h_1;

    note_durations[0] = clk_freq / 1;  // 1拍
    note_durations[1] = clk_freq / 1;  // 1拍
    note_durations[2] = clk_freq / 2;  // 2拍
    note_durations[3] = clk_freq / 2;  // 2拍
    note_durations[4] = clk_freq / 2;  // 2拍
    note_durations[5] = clk_freq / 4;  // 4拍
    note_durations[6] = clk_freq / 1;  // 1拍
    note_durations[7] = clk_freq / 1;  // 1拍
    note_durations[8] = clk_freq / 2;  // 2拍
    note_durations[9] = clk_freq / 2;  // 2拍
    note_durations[10] = clk_freq / 2;  // 2拍
    note_durations[11] = clk_freq / 4;  // 4拍
    note_durations[12] = clk_freq / 1;  // 1拍
    note_durations[13] = clk_freq / 1;  // 1拍
    note_durations[14] = clk_freq / 2;  // 2拍
    note_durations[15] = clk_freq / 2;  // 2拍
    note_durations[16] = clk_freq / 2;  // 2拍
    note_durations[17] = clk_freq / 2;  // 2拍
    note_durations[18] = clk_freq / 4;  // 4拍
    note_durations[19] = clk_freq / 1;  // 1拍
    note_durations[20] = clk_freq / 1;  // 1拍
    note_durations[21] = clk_freq / 2;  // 2拍
    note_durations[22] = clk_freq / 2;  // 2拍
    note_durations[23] = clk_freq / 2;  // 2拍
    note_durations[24] = clk_freq / 4;  // 4拍
  end

  parameter Init = 0, Play_Note = 1, Change_Note = 2;
  reg [1:0] state;

  // reg pwm_enable;

  pwm pwm_music (
      .rst(rst),
      .clk(clk),
      .duty(50),
      .period(clk_freq / note_frequencies[note_index]),
      .pwm_out(music)
  );

  // assign music = pwm_enable ? music : 0;

  always @(posedge clk or posedge rst) begin
    if (!rst) begin
      state        <= Init;
      note_index   <= 0;
      note_counter <= 0;
      // pwm_enable   <= 0;
    end else begin
      case (state)
        Init: begin
          note_index <= 0;
          note_counter <= 0;
          state <= Play_Note;
        end

        Play_Note: begin
          if (note_counter < note_durations[note_index]) begin
            note_counter <= note_counter + 1;
            // pwm_enable   <= 1;
          end else begin
            note_counter <= 0;
            state <= Change_Note;
          end
        end

        Change_Note: begin
          // pwm_enable <= 0;
          note_index <= (note_index + 1) % NUM_NOTES;
          state <= Play_Note;
        end
      endcase
    end
  end
endmodule
