`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/16 00:45:07
// Design Name: 
// Module Name: sin_table
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


module sin_table (
    input  wire [7:0] index,
    output reg  [7:0] sin_value
);

  always @(*) begin
    case (index)
      8'd0: sin_value = 8'd0;
      8'd1: sin_value = 8'd1;
      8'd2: sin_value = 8'd3;
      8'd3: sin_value = 8'd4;
      8'd4: sin_value = 8'd6;
      8'd5: sin_value = 8'd7;
      8'd6: sin_value = 8'd9;
      8'd7: sin_value = 8'd10;
      8'd8: sin_value = 8'd12;
      8'd9: sin_value = 8'd14;
      8'd10: sin_value = 8'd15;
      8'd11: sin_value = 8'd17;
      8'd12: sin_value = 8'd18;
      8'd13: sin_value = 8'd20;
      8'd14: sin_value = 8'd21;
      8'd15: sin_value = 8'd23;
      8'd16: sin_value = 8'd25;
      8'd17: sin_value = 8'd26;
      8'd18: sin_value = 8'd28;
      8'd19: sin_value = 8'd29;
      8'd20: sin_value = 8'd31;
      8'd21: sin_value = 8'd32;
      8'd22: sin_value = 8'd34;
      8'd23: sin_value = 8'd36;
      8'd24: sin_value = 8'd37;
      8'd25: sin_value = 8'd39;
      8'd26: sin_value = 8'd40;
      8'd27: sin_value = 8'd42;
      8'd28: sin_value = 8'd43;
      8'd29: sin_value = 8'd45;
      8'd30: sin_value = 8'd46;
      8'd31: sin_value = 8'd48;
      8'd32: sin_value = 8'd49;
      8'd33: sin_value = 8'd51;
      8'd34: sin_value = 8'd53;
      8'd35: sin_value = 8'd54;
      8'd36: sin_value = 8'd56;
      8'd37: sin_value = 8'd57;
      8'd38: sin_value = 8'd59;
      8'd39: sin_value = 8'd60;
      8'd40: sin_value = 8'd62;
      8'd41: sin_value = 8'd63;
      8'd42: sin_value = 8'd65;
      8'd43: sin_value = 8'd66;
      8'd44: sin_value = 8'd68;
      8'd45: sin_value = 8'd69;
      8'd46: sin_value = 8'd71;
      8'd47: sin_value = 8'd72;
      8'd48: sin_value = 8'd74;
      8'd49: sin_value = 8'd75;
      8'd50: sin_value = 8'd77;
      8'd51: sin_value = 8'd78;
      8'd52: sin_value = 8'd80;
      8'd53: sin_value = 8'd81;
      8'd54: sin_value = 8'd83;
      8'd55: sin_value = 8'd84;
      8'd56: sin_value = 8'd86;
      8'd57: sin_value = 8'd87;
      8'd58: sin_value = 8'd89;
      8'd59: sin_value = 8'd90;
      8'd60: sin_value = 8'd92;
      8'd61: sin_value = 8'd93;
      8'd62: sin_value = 8'd95;
      8'd63: sin_value = 8'd96;
      8'd64: sin_value = 8'd97;
      8'd65: sin_value = 8'd99;
      8'd66: sin_value = 8'd100;
      8'd67: sin_value = 8'd102;
      8'd68: sin_value = 8'd103;
      8'd69: sin_value = 8'd105;
      8'd70: sin_value = 8'd106;
      8'd71: sin_value = 8'd108;
      8'd72: sin_value = 8'd109;
      8'd73: sin_value = 8'd110;
      8'd74: sin_value = 8'd112;
      8'd75: sin_value = 8'd113;
      8'd76: sin_value = 8'd115;
      8'd77: sin_value = 8'd116;
      8'd78: sin_value = 8'd117;
      8'd79: sin_value = 8'd119;
      8'd80: sin_value = 8'd120;
      8'd81: sin_value = 8'd122;
      8'd82: sin_value = 8'd123;
      8'd83: sin_value = 8'd124;
      8'd84: sin_value = 8'd126;
      8'd85: sin_value = 8'd127;
      8'd86: sin_value = 8'd128;
      8'd87: sin_value = 8'd130;
      8'd88: sin_value = 8'd131;
      8'd89: sin_value = 8'd132;
      8'd90: sin_value = 8'd134;
      8'd91: sin_value = 8'd135;
      8'd92: sin_value = 8'd136;
      8'd93: sin_value = 8'd138;
      8'd94: sin_value = 8'd139;
      8'd95: sin_value = 8'd140;
      8'd96: sin_value = 8'd142;
      8'd97: sin_value = 8'd143;
      8'd98: sin_value = 8'd144;
      8'd99: sin_value = 8'd146;
      8'd100: sin_value = 8'd147;
      8'd101: sin_value = 8'd148;
      8'd102: sin_value = 8'd149;
      8'd103: sin_value = 8'd151;
      8'd104: sin_value = 8'd152;
      8'd105: sin_value = 8'd153;
      8'd106: sin_value = 8'd154;
      8'd107: sin_value = 8'd156;
      8'd108: sin_value = 8'd157;
      8'd109: sin_value = 8'd158;
      8'd110: sin_value = 8'd159;
      8'd111: sin_value = 8'd161;
      8'd112: sin_value = 8'd162;
      8'd113: sin_value = 8'd163;
      8'd114: sin_value = 8'd164;
      8'd115: sin_value = 8'd165;
      8'd116: sin_value = 8'd167;
      8'd117: sin_value = 8'd168;
      8'd118: sin_value = 8'd169;
      8'd119: sin_value = 8'd170;
      8'd120: sin_value = 8'd171;
      8'd121: sin_value = 8'd172;
      8'd122: sin_value = 8'd174;
      8'd123: sin_value = 8'd175;
      8'd124: sin_value = 8'd176;
      8'd125: sin_value = 8'd177;
      8'd126: sin_value = 8'd178;
      8'd127: sin_value = 8'd179;
      8'd128: sin_value = 8'd180;
      8'd129: sin_value = 8'd181;
      8'd130: sin_value = 8'd183;
      8'd131: sin_value = 8'd184;
      8'd132: sin_value = 8'd185;
      8'd133: sin_value = 8'd186;
      8'd134: sin_value = 8'd187;
      8'd135: sin_value = 8'd188;
      8'd136: sin_value = 8'd189;
      8'd137: sin_value = 8'd190;
      8'd138: sin_value = 8'd191;
      8'd139: sin_value = 8'd192;
      8'd140: sin_value = 8'd193;
      8'd141: sin_value = 8'd194;
      8'd142: sin_value = 8'd195;
      8'd143: sin_value = 8'd196;
      8'd144: sin_value = 8'd197;
      8'd145: sin_value = 8'd198;
      8'd146: sin_value = 8'd199;
      8'd147: sin_value = 8'd200;
      8'd148: sin_value = 8'd201;
      8'd149: sin_value = 8'd202;
      8'd150: sin_value = 8'd203;
      8'd151: sin_value = 8'd204;
      8'd152: sin_value = 8'd205;
      8'd153: sin_value = 8'd206;
      8'd154: sin_value = 8'd207;
      8'd155: sin_value = 8'd208;
      8'd156: sin_value = 8'd209;
      8'd157: sin_value = 8'd209;
      8'd158: sin_value = 8'd210;
      8'd159: sin_value = 8'd211;
      8'd160: sin_value = 8'd212;
      8'd161: sin_value = 8'd213;
      8'd162: sin_value = 8'd214;
      8'd163: sin_value = 8'd215;
      8'd164: sin_value = 8'd215;
      8'd165: sin_value = 8'd216;
      8'd166: sin_value = 8'd217;
      8'd167: sin_value = 8'd218;
      8'd168: sin_value = 8'd219;
      8'd169: sin_value = 8'd220;
      8'd170: sin_value = 8'd220;
      8'd171: sin_value = 8'd221;
      8'd172: sin_value = 8'd222;
      8'd173: sin_value = 8'd223;
      8'd174: sin_value = 8'd223;
      8'd175: sin_value = 8'd224;
      8'd176: sin_value = 8'd225;
      8'd177: sin_value = 8'd226;
      8'd178: sin_value = 8'd226;
      8'd179: sin_value = 8'd227;
      8'd180: sin_value = 8'd228;
      8'd181: sin_value = 8'd228;
      8'd182: sin_value = 8'd229;
      8'd183: sin_value = 8'd230;
      8'd184: sin_value = 8'd230;
      8'd185: sin_value = 8'd231;
      8'd186: sin_value = 8'd232;
      8'd187: sin_value = 8'd232;
      8'd188: sin_value = 8'd233;
      8'd189: sin_value = 8'd234;
      8'd190: sin_value = 8'd234;
      8'd191: sin_value = 8'd235;
      8'd192: sin_value = 8'd236;
      8'd193: sin_value = 8'd236;
      8'd194: sin_value = 8'd237;
      8'd195: sin_value = 8'd237;
      8'd196: sin_value = 8'd238;
      8'd197: sin_value = 8'd238;
      8'd198: sin_value = 8'd239;
      8'd199: sin_value = 8'd239;
      8'd200: sin_value = 8'd240;
      8'd201: sin_value = 8'd241;
      8'd202: sin_value = 8'd241;
      8'd203: sin_value = 8'd242;
      8'd204: sin_value = 8'd242;
      8'd205: sin_value = 8'd243;
      8'd206: sin_value = 8'd243;
      8'd207: sin_value = 8'd243;
      8'd208: sin_value = 8'd244;
      8'd209: sin_value = 8'd244;
      8'd210: sin_value = 8'd245;
      8'd211: sin_value = 8'd245;
      8'd212: sin_value = 8'd246;
      8'd213: sin_value = 8'd246;
      8'd214: sin_value = 8'd246;
      8'd215: sin_value = 8'd247;
      8'd216: sin_value = 8'd247;
      8'd217: sin_value = 8'd248;
      8'd218: sin_value = 8'd248;
      8'd219: sin_value = 8'd248;
      8'd220: sin_value = 8'd249;
      8'd221: sin_value = 8'd249;
      8'd222: sin_value = 8'd249;
      8'd223: sin_value = 8'd250;
      8'd224: sin_value = 8'd250;
      8'd225: sin_value = 8'd250;
      8'd226: sin_value = 8'd250;
      8'd227: sin_value = 8'd251;
      8'd228: sin_value = 8'd251;
      8'd229: sin_value = 8'd251;
      8'd230: sin_value = 8'd251;
      8'd231: sin_value = 8'd252;
      8'd232: sin_value = 8'd252;
      8'd233: sin_value = 8'd252;
      8'd234: sin_value = 8'd252;
      8'd235: sin_value = 8'd253;
      8'd236: sin_value = 8'd253;
      8'd237: sin_value = 8'd253;
      8'd238: sin_value = 8'd253;
      8'd239: sin_value = 8'd253;
      8'd240: sin_value = 8'd253;
      8'd241: sin_value = 8'd254;
      8'd242: sin_value = 8'd254;
      8'd243: sin_value = 8'd254;
      8'd244: sin_value = 8'd254;
      8'd245: sin_value = 8'd254;
      8'd246: sin_value = 8'd254;
      8'd247: sin_value = 8'd254;
      8'd248: sin_value = 8'd254;
      8'd249: sin_value = 8'd254;
      8'd250: sin_value = 8'd254;
      8'd251: sin_value = 8'd254;
      8'd252: sin_value = 8'd254;
      8'd253: sin_value = 8'd254;
      8'd254: sin_value = 8'd254;
      8'd255: sin_value = 8'd255;
      8'd256: sin_value = 8'd255;
      default: sin_value = 8'd0;
    endcase
  end

endmodule

