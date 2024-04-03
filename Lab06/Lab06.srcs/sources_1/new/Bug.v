`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2023 10:24:27 AM
// Design Name: 
// Module Name: Bug
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


module Bug(
    input [14:0] colIn,
    input [14:0] rowIn,
    input frameTrigger, timeUp, flashBug, Flash,
    input tB, tP,
    input clk, Go,
    output [14:0] bugLeft, bugRight, bugTop,
    output bug
    );
    
    wire [14:0] bugL, bugR;
    wire GoS;
    
    Bug_LFSR bugHeight (.clk(clk), .CE(bugL <= 8 & bugR <= 8 | (tB & timeUp)), .Q(bugTop));
    FDRE #(.INIT(1'b0)) GoSignal (.C(clk), .R(1'b0), .CE(Go), .D(1'b1), .Q(GoS));
    
    countUD15L bugLeftt (.Up(1'b0), .Dw(frameTrigger & ~(bugL <= 8) & ~tB & GoS), .LD((bugL <= 8 & bugR <= 8) | (tB & timeUp)), .clk(clk), .Din(632), .UTC(), .DTC(), .Q(bugL));
    countUD15L bugRightt (.Up(1'b0), .Dw(frameTrigger & ~tB & GoS), .LD((bugR <= 8) | (tB & timeUp)), .clk(clk), .Din(640), .UTC(), .DTC(), .Q(bugR));
    
    assign bug = (bugL <= colIn & colIn <= bugR & (bugTop - 8) <= rowIn & rowIn <= bugTop) & ~(Flash & flashBug);
    assign bugLeft = bugL;
    assign bugRight = bugR;
endmodule
