`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2023 04:48:49 PM
// Design Name: 
// Module Name: count1Bit
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


module count1Bit(
    input clkin,
    input Up,
    output out
    );
    wire incr, CE;
    assign CE = Up;
    assign incr = (~out);
    
    FDRE #(.INIT(1'b0)) FF_0 (.C(clkin), .R(1'b0), .CE(CE), .D(incr), .Q(out));

endmodule
