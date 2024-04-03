`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 01:34:36 PM
// Design Name: 
// Module Name: RingCounter
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


module RingCounter(
    input clk,
    input advance,
    output [3:0] out
    );
    
    FDRE #(.INIT(1'b1) ) FF0  (.C(clk), .CE(advance), .D(out[0]), .Q(out[1]));
    FDRE #(.INIT(1'b0) ) FF1  (.C(clk), .CE(advance), .D(out[1]), .Q(out[2]));
    FDRE #(.INIT(1'b0) ) FF2  (.C(clk), .CE(advance), .D(out[2]), .Q(out[3]));
    FDRE #(.INIT(1'b0) ) FF3  (.C(clk), .CE(advance), .D(out[3]), .Q(out[0]));
    
endmodule
