`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 11:28:38 AM
// Design Name: 
// Module Name: countUD15L
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


module countUD15L(
    input [14:0] Din,
    input Up,
    input Dw,
    input LD,
    input clk,
    output UTC,
    output DTC,
    output [14:0] Q
    );
    
    
    wire [2:0] UTCout;
    wire [2:0] DTCout;
    
    
    wire [1:0] upInc;
    wire [1:0] downInc;

    
    assign upInc[0] = Up & UTCout[0];
    assign downInc[0] = Dw & DTCout[0];
    assign upInc[1] = upInc[0] & UTCout[1];
    assign downInc[1] = downInc[0] & DTCout[1];
    countUD5L count0to4(.clk(clk), .Up(Up), .Dw(Dw), .LD(LD), .Din(Din[4:0]), .Q(Q[4:0]), .UTC(UTCout[0]), .DTC(DTCout[0]));
    countUD5L count5to9(.clk(clk), .Up(upInc[0]), .Dw(downInc[0]), .LD(LD), .Din(Din[9:5]), .Q(Q[9:5]), .UTC(UTCout[1]), .DTC(DTCout[1]));
    countUD5L count10to14(.clk(clk), .Up(upInc[1]), .Dw(downInc[1]), .LD(LD), .Din(Din[14:10]), .Q(Q[14:10]), .UTC(UTCout[2]), .DTC(DTCout[2]));
    assign UTC = (UTCout[0] & UTCout[1] & UTCout[2]);
    assign DTC = (DTCout[0] & DTCout[1] & DTCout[2]);
endmodule
