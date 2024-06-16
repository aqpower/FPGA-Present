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
// * PWM占空比决定了音量，PWM的频率决定了音调。

module music_gen (
    input wire rst,
    input wire clk,
    input wire music_en,
    output wire music,
    output wire [7:0] digit_enable,
    output wire [7:0] segment_data,
    output wire [6:0] lamp_data
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
  reg [31:0] clk_freq = 50000000;  // 50 MHz 时钟频率,1s = 50,000,000个时钟周期
  reg [31:0] beat_1_4 = 50000000 / 4;  // 1/4拍

  reg [31:0] note_frequencies[0:NUM_NOTES-1];
  reg [31:0] note_durations[0:NUM_NOTES-1];
  reg [31:0] note_display[0:NUM_NOTES-1];
  reg [31:0] note_counter;
  reg [15:0] note_index;
  reg [3:0] display_value;
  parameter Init = 0, Play_Note = 1, Change_Note = 2, Pause_Note = 3;
  reg [1:0] state;

  initial begin
    state = Init;
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

    note_durations[0] = beat_1_4 * 3;
    note_durations[1] = beat_1_4 * 1;
    note_durations[2] = beat_1_4 * 4;
    note_durations[3] = beat_1_4 * 4;
    note_durations[4] = beat_1_4 * 4;
    note_durations[5] = beat_1_4 * 8;
    note_durations[6] = beat_1_4 * 3;
    note_durations[7] = beat_1_4 * 1;
    note_durations[8] = beat_1_4 * 4;
    note_durations[9] = beat_1_4 * 4;
    note_durations[10] = beat_1_4 * 4;
    note_durations[11] = beat_1_4 * 8;
    note_durations[12] = beat_1_4 * 3;
    note_durations[13] = beat_1_4 * 1;
    note_durations[14] = beat_1_4 * 4;
    note_durations[15] = beat_1_4 * 4;
    note_durations[16] = beat_1_4 * 4;
    note_durations[17] = beat_1_4 * 4;
    note_durations[18] = beat_1_4 * 4;
    note_durations[19] = beat_1_4 * 3;
    note_durations[20] = beat_1_4 * 1;
    note_durations[21] = beat_1_4 * 4;
    note_durations[22] = beat_1_4 * 4;
    note_durations[23] = beat_1_4 * 4;
    note_durations[24] = beat_1_4 * 8;

    note_display[0] = 5;
    note_display[1] = 5;
    note_display[2] = 6;
    note_display[3] = 5;
    note_display[4] = 1;
    note_display[5] = 7;
    note_display[6] = 5;
    note_display[7] = 5;
    note_display[8] = 6;
    note_display[9] = 5;
    note_display[10] = 2;
    note_display[11] = 1;
    note_display[12] = 5;
    note_display[13] = 5;
    note_display[14] = 5;
    note_display[15] = 3;
    note_display[16] = 1;
    note_display[17] = 7;
    note_display[18] = 6;
    note_display[19] = 4;
    note_display[20] = 4;
    note_display[21] = 3;
    note_display[22] = 1;
    note_display[23] = 2;
    note_display[24] = 1;
  end

  reg music_en_negedge_detected;

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      state <= Init;
      music_en_negedge_detected <= 0;
      note_index <= 0;
      note_counter <= 0;
      display_value <= 0;
    end else begin
      // 检测 music_en 的下降沿
      if (!music_en && !music_en_negedge_detected) begin
        music_en_negedge_detected <= 1;
        if (state == Play_Note || state == Change_Note) begin
          state <= Pause_Note;
        end else if (state == Pause_Note) begin
          state <= Play_Note;
        end
      end else if (music_en && music_en_negedge_detected) begin
        music_en_negedge_detected <= 0;
      end

      case (state)
        Init: begin
          note_index <= 0;
          note_counter <= 0;
          display_value <= 0;
          music_en_negedge_detected <= 0;
          state <= Pause_Note;
        end

        Play_Note: begin
          note_counter  <= note_counter + 1;
          display_value <= note_display[note_index];
          if (note_counter >= note_durations[note_index]) begin
            note_counter <= 0;
            state <= Change_Note;
          end
        end

        Change_Note: begin
          note_index <= (note_index + 1) % NUM_NOTES;
          state <= Play_Note;
        end

        Pause_Note: begin
        end

      endcase
    end
  end


  wire [31:0] period = clk_freq / note_frequencies[note_index];
  wire [31:0] duty = period / 2;
  pwm pwm_music_inst (
      .rst(rst),
      .clk(clk),
      .duty(duty),
      .period(period),
      .pwm_out(pwm_music)
  );
  assign music = state == Play_Note ? pwm_music : 0;

  segment_display segment_display_module (
      .clk(clk),
      .num(display_value),
      .digit_enable(digit_enable),
      .segment_data(segment_data)
  );
  lamp_display lamp_display_module (
      .num(display_value),
      .lamp_data(lamp_data)
  );
endmodule
