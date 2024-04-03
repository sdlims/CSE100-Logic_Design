`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 11:16:08 AM
// Design Name: 
// Module Name: mux
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


module mux(
    input s,
    input [7:0] i0,
    input [7:0] i1,
    output [7:0] y
    );
    
    assign y[0] = ~s & i0[0] | s & i1[0];
    assign y[1] = ~s & i0[1] | s & i1[1];
    assign y[2] = ~s & i0[2] | s & i1[2];
    assign y[3] = ~s & i0[3] | s & i1[3];
    assign y[4] = ~s & i0[4] | s & i1[4];
    assign y[5] = ~s & i0[5] | s & i1[5];
    assign y[6] = ~s & i0[6] | s & i1[6];
    assign y[7] = ~s & i0[7] | s & i1[7];
endmodule
