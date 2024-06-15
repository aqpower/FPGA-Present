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

module breathing_light(
    input wire clk,
    output wire light
);

reg [31:0] counter;
reg [7:0] duty;
reg state;
reg[31:0] num;

initial begin
    counter = 0;
    duty = 0;
    num = 200;
    state = 1;
end

parameter t = 20000000;

always @(posedge clk) begin
    if (state == 1) begin
        counter = counter + 1;
        if(counter >= t) begin
            state = 0;
        end
    end else begin
        counter = counter - 1;
        if(counter <= 0) begin
            state = 1;
        end
    end

    duty = counter/(t/256);
end

endmodule
