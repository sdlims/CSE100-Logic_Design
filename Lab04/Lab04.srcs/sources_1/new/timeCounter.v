`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:21:28 PM
// Design Name: 
// Module Name: timeCounter
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


module timeCounter(
    input Dw,
    input LD,
    input [7:0] Din,
    input clkin,
    output DTC,
    output [7:0] Q
    );
    
    //Create some wires
    wire [1:0] DTCout;
    wire downInc;

    assign downInc = Dw & DTCout[0];
    
    counterDown4L count0to3(.clkin(clkin), .Up(1'b0), .Dw(~DTC & Dw), .LD(LD), .Din(Din[3:0]), .Q(Q[3:0]), .DTC(DTCout[0]));
    counterDown4L count4to7(.clkin(clkin), .Up(1'b0), .Dw(~DTC & downInc), .LD(LD), .Din(Din[7:4]), .Q(Q[7:4]), .DTC(DTCout[1]));
    assign DTC = (DTCout[0] & DTCout[1]);
    
endmodule
