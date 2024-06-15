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
  reg [31:0] clk_freq = 50000000;  // 50 MHz 时钟频率,1s = 50,000,000个时钟周期
  reg [31:0] beat_1_4 = 50000000 / 4; // 1/4拍

  reg [31:0] note_frequencies[0:NUM_NOTES-1];
  reg [31:0] note_durations[0:NUM_NOTES-1];

  reg [31:0] note_counter;
  reg [15:0] note_index;
  parameter Init = 0, Play_Note = 1, Change_Note = 2;
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
  end

  always @(posedge clk or posedge rst) begin
    if (!rst) begin
      state <= Init;
    end else begin
      case (state)
        Init: begin
          note_index <= 0;
          note_counter <= 0;
          state <= Play_Note;
        end

        Play_Note: begin
          note_counter <= note_counter + 1;
          if (note_counter >= note_durations[note_index]) begin
            note_counter <= 0;
            state <= Change_Note;
          end
        end

        Change_Note: begin
          note_index <= (note_index + 1) % NUM_NOTES;
          state <= Play_Note;
        end
      endcase
    end
  end

  wire [31:0] period = clk_freq / note_frequencies[note_index];
  wire [31:0] duty = period / 2;

  pwm pwm_music (
      .rst(rst),
      .clk(clk),
      .duty(duty),
      .period(period),
      .pwm_out(music)
  );
endmodule
