`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:21:28 PM
// Design Name: 
// Module Name: ringCounter
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


module ringCounter(
    input advance,
    input clkin,
    output [3:0] out
    );
    
    FDRE #(.INIT(1'b1) ) FF0  (.C(clkin), .R(1'b0), .CE(advance), .D(out[0]), .Q(out[1]));
    FDRE #(.INIT(1'b0) ) FF1  (.C(clkin), .R(1'b0), .CE(advance), .D(out[1]), .Q(out[2]));
    FDRE #(.INIT(1'b0) ) FF2  (.C(clkin), .R(1'b0), .CE(advance), .D(out[2]), .Q(out[3]));
    FDRE #(.INIT(1'b0) ) FF3  (.C(clkin), .R(1'b0), .CE(advance), .D(out[3]), .Q(out[0]));
    
endmodule
