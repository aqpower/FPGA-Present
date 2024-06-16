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

  parameter sleep = 0;



  parameter NUM_NOTES = 59;
  reg [31:0] clk_freq = 50000000;  // 50 MHz 时钟频率,1s = 50,000,000个时钟周期
  reg [31:0] beat_1_4 = 50000000 / 8;  // 1/4拍

  reg [31:0] note_frequencies[0:NUM_NOTES-1];
  reg [31:0] note_durations[0:NUM_NOTES-1];
  reg [31:0] note_display[0:NUM_NOTES-1];
  reg [31:0] note_counter;
  reg [15:0] note_index;
  reg [3:0] display_value;
  parameter Init = 0, Play_Note = 1, Change_Note = 2, Pause_Note = 3;
  reg [1:0] state;

  // initial begin
  //   state = Init;
  //   note_frequencies[0] = m_5;
  //   note_frequencies[1] = m_5;
  //   note_frequencies[2] = m_6;
  //   note_frequencies[3] = m_5;
  //   note_frequencies[4] = h_1;
  //   note_frequencies[5] = m_7;
  //   note_frequencies[6] = m_5;
  //   note_frequencies[7] = m_5;
  //   note_frequencies[8] = m_6;
  //   note_frequencies[9] = m_5;
  //   note_frequencies[10] = h_2;
  //   note_frequencies[11] = h_1;
  //   note_frequencies[12] = m_5;
  //   note_frequencies[13] = m_5;
  //   note_frequencies[14] = h_5;
  //   note_frequencies[15] = h_3;
  //   note_frequencies[16] = h_1;
  //   note_frequencies[17] = m_7;
  //   note_frequencies[18] = m_6;
  //   note_frequencies[19] = h_4;
  //   note_frequencies[20] = h_4;
  //   note_frequencies[21] = h_3;
  //   note_frequencies[22] = h_1;
  //   note_frequencies[23] = h_2;
  //   note_frequencies[24] = h_1;

  //   note_durations[0] = beat_1_4 * 3;
  //   note_durations[1] = beat_1_4 * 1;
  //   note_durations[2] = beat_1_4 * 4;
  //   note_durations[3] = beat_1_4 * 4;
  //   note_durations[4] = beat_1_4 * 4;
  //   note_durations[5] = beat_1_4 * 8;
  //   note_durations[6] = beat_1_4 * 3;
  //   note_durations[7] = beat_1_4 * 1;
  //   note_durations[8] = beat_1_4 * 4;
  //   note_durations[9] = beat_1_4 * 4;
  //   note_durations[10] = beat_1_4 * 4;
  //   note_durations[11] = beat_1_4 * 8;
  //   note_durations[12] = beat_1_4 * 3;
  //   note_durations[13] = beat_1_4 * 1;
  //   note_durations[14] = beat_1_4 * 4;
  //   note_durations[15] = beat_1_4 * 4;
  //   note_durations[16] = beat_1_4 * 4;
  //   note_durations[17] = beat_1_4 * 4;
  //   note_durations[18] = beat_1_4 * 4;
  //   note_durations[19] = beat_1_4 * 3;
  //   note_durations[20] = beat_1_4 * 1;
  //   note_durations[21] = beat_1_4 * 4;
  //   note_durations[22] = beat_1_4 * 4;
  //   note_durations[23] = beat_1_4 * 4;
  //   note_durations[24] = beat_1_4 * 8;

  //   note_display[0] = 5;
  //   note_display[1] = 5;
  //   note_display[2] = 6;
  //   note_display[3] = 5;
  //   note_display[4] = 1;
  //   note_display[5] = 7;
  //   note_display[6] = 5;
  //   note_display[7] = 5;
  //   note_display[8] = 6;
  //   note_display[9] = 5;
  //   note_display[10] = 2;
  //   note_display[11] = 1;
  //   note_display[12] = 5;
  //   note_display[13] = 5;
  //   note_display[14] = 5;
  //   note_display[15] = 3;
  //   note_display[16] = 1;
  //   note_display[17] = 7;
  //   note_display[18] = 6;
  //   note_display[19] = 4;
  //   note_display[20] = 4;
  //   note_display[21] = 3;
  //   note_display[22] = 1;
  //   note_display[23] = 2;
  //   note_display[24] = 1;
  // end
  /**
535[1] 6[1]65 5123212
535[1]76[1]5 5234(7)1
6[1][1] 767[1] 67[1]665312
535[1]76[1]5 5234(7)1

**/

  initial begin
    state = Init;

    // 535[1] 6[1]65 5123212
    // 535[1]76[1]5 5234(7)1
    // 6[1][1] 767[1] 67[1]665312
    // 535[1]76[1]5 5234(7)1


    note_frequencies[0] = m_5;
    note_frequencies[1] = m_3;
    note_frequencies[2] = m_5;
    note_frequencies[3] = h_1;

    note_frequencies[4] = m_6;
    note_frequencies[5] = h_1;
    note_frequencies[6] = m_6;
    note_frequencies[7] = m_5;

    note_frequencies[8] = m_5;
    note_frequencies[9] = m_1;
    note_frequencies[10] = m_2;
    note_frequencies[11] = m_3;
    note_frequencies[12] = m_2;
    note_frequencies[13] = m_1;
    note_frequencies[14] = m_2;

    note_frequencies[15] = m_5;
    note_frequencies[16] = m_3;
    note_frequencies[17] = m_5;
    note_frequencies[18] = h_1;
    note_frequencies[19] = m_7;
    note_frequencies[20] = m_6;
    note_frequencies[21] = h_1;
    note_frequencies[22] = m_5;

    note_frequencies[23] = m_5;
    note_frequencies[24] = m_2;
    note_frequencies[25] = m_3;
    note_frequencies[26] = m_4;
    note_frequencies[27] = l_7;
    note_frequencies[28] = m_1;

    note_frequencies[29] = m_6;
    note_frequencies[30] = h_1;
    note_frequencies[31] = h_1;

    note_frequencies[32] = m_7;
    note_frequencies[33] = m_6;
    note_frequencies[34] = m_7;
    note_frequencies[35] = h_1;

    note_frequencies[36] = m_6;
    note_frequencies[37] = m_7;
    note_frequencies[38] = h_1;
    note_frequencies[39] = m_6;
    note_frequencies[40] = m_6;
    note_frequencies[41] = m_5;
    note_frequencies[42] = m_3;
    note_frequencies[43] = m_1;
    note_frequencies[44] = m_2;

    note_frequencies[45] = m_5;
    note_frequencies[46] = m_3;
    note_frequencies[47] = m_5;
    note_frequencies[48] = h_1;
    note_frequencies[49] = m_7;
    note_frequencies[50] = m_6;
    note_frequencies[51] = h_1;
    note_frequencies[52] = m_5;

    note_frequencies[53] = m_5;
    note_frequencies[54] = m_2;
    note_frequencies[55] = m_3;
    note_frequencies[56] = m_4;
    note_frequencies[57] = l_7;
    note_frequencies[58] = m_1;

    note_durations[0] = beat_1_4 * 4;
    note_durations[1] = beat_1_4 * 2;
    note_durations[2] = beat_1_4 * 2;
    note_durations[3] = beat_1_4 * 8;

    note_durations[4] = beat_1_4 * 4;
    note_durations[5] = beat_1_4 * 2;
    note_durations[6] = beat_1_4 * 2;
    note_durations[7] = beat_1_4 * 8;

    note_durations[8] = beat_1_4 * 4;
    note_durations[9] = beat_1_4 * 2;
    note_durations[10] = beat_1_4 * 2;
    note_durations[11] = beat_1_4 * 4;
    note_durations[12] = beat_1_4 * 2;
    note_durations[13] = beat_1_4 * 2;
    note_durations[14] = beat_1_4 * 12;

    note_durations[15] = beat_1_4 * 4;
    note_durations[16] = beat_1_4 * 2;
    note_durations[17] = beat_1_4 * 2;
    note_durations[18] = beat_1_4 * 6;
    note_durations[19] = beat_1_4 * 2;
    note_durations[20] = beat_1_4 * 4;
    note_durations[21] = beat_1_4 * 4;
    note_durations[22] = beat_1_4 * 8;

    note_durations[23] = beat_1_4 * 4;
    note_durations[24] = beat_1_4 * 2;
    note_durations[25] = beat_1_4 * 2;
    note_durations[26] = beat_1_4 * 6;
    note_durations[27] = beat_1_4 * 2;
    note_durations[28] = beat_1_4 * 12;

    note_durations[29] = beat_1_4 * 4;
    note_durations[30] = beat_1_4 * 4;
    note_durations[31] = beat_1_4 * 8;

    note_durations[32] = beat_1_4 * 4;
    note_durations[33] = beat_1_4 * 2;
    note_durations[34] = beat_1_4 * 2;
    note_durations[35] = beat_1_4 * 8;

    note_durations[36] = beat_1_4 * 2;
    note_durations[37] = beat_1_4 * 2;
    note_durations[38] = beat_1_4 * 2;
    note_durations[39] = beat_1_4 * 2;
    note_durations[40] = beat_1_4 * 2;
    note_durations[41] = beat_1_4 * 2;
    note_durations[42] = beat_1_4 * 2;
    note_durations[43] = beat_1_4 * 2;
    note_durations[44] = beat_1_4 * 16;

    note_durations[45] = beat_1_4 * 4;
    note_durations[46] = beat_1_4 * 2;
    note_durations[47] = beat_1_4 * 2;
    note_durations[48] = beat_1_4 * 6;
    note_durations[49] = beat_1_4 * 2;
    note_durations[50] = beat_1_4 * 4;
    note_durations[51] = beat_1_4 * 4;
    note_durations[52] = beat_1_4 * 8;

    note_durations[53] = beat_1_4 * 4;
    note_durations[54] = beat_1_4 * 2;
    note_durations[55] = beat_1_4 * 2;
    note_durations[56] = beat_1_4 * 6;
    note_durations[57] = beat_1_4 * 2;
    note_durations[58] = beat_1_4 * 12;

    note_display[0] = 5;
    note_display[1] = 3;
    note_display[2] = 5;
    note_display[3] = 1;

    note_display[4] = 6;
    note_display[5] = 1;
    note_display[6] = 6;
    note_display[7] = 5;

    note_display[8] = 5;
    note_display[9] = 1;
    note_display[10] = 2;
    note_display[11] = 3;
    note_display[12] = 2;
    note_display[13] = 1;
    note_display[14] = 2;

    note_display[15] = 5;
    note_display[16] = 3;
    note_display[17] = 5;
    note_display[18] = 1;
    note_display[19] = 7;
    note_display[20] = 6;
    note_display[21] = 1;
    note_display[22] = 5;

    note_display[23] = 5;
    note_display[24] = 2;
    note_display[25] = 3;
    note_display[26] = 4;
    note_display[27] = 7;
    note_display[28] = 1;

    note_display[29] = 6;
    note_display[30] = 1;
    note_display[31] = 1;

    note_display[32] = 7;
    note_display[33] = 6;
    note_display[34] = 7;
    note_display[35] = 1;

    note_display[36] = 6;
    note_display[37] = 7;
    note_display[38] = 1;
    note_display[39] = 6;
    note_display[40] = 6;
    note_display[41] = 5;
    note_display[42] = 3;
    note_display[43] = 1;
    note_display[44] = 2;

    note_display[45] = 5;
    note_display[46] = 3;
    note_display[47] = 5;
    note_display[48] = 1;
    note_display[49] = 7;
    note_display[50] = 6;
    note_display[51] = 1;
    note_display[52] = 5;

    note_display[53] = 5;
    note_display[54] = 2;
    note_display[55] = 3;
    note_display[56] = 4;
    note_display[57] = 7;
    note_display[58] = 1;
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
  // wire [31:0] duty = 500;
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
