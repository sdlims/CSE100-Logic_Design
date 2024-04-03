`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 01:33:40 PM
// Design Name: 
// Module Name: Selector
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


module Selector(
    input [15:0] n,
    input [3:0] sel,
    output [3:0] h
    );
    
    assign h[3] = (n[15] & sel[3]) | (n[11] & sel[2]) | (n[7] & sel[1]) | (n[3] & sel[0]);
    assign h[2] = (n[14] & sel[3]) | (n[10] & sel[2]) | (n[6] & sel[1]) | (n[2] & sel[0]);
    assign h[1] = (n[13] & sel[3]) | (n[9]  & sel[2]) | (n[5] & sel[1]) | (n[1] & sel[0]);
    assign h[0] = (n[12] & sel[3]) | (n[8]  & sel[2]) | (n[4] & sel[1]) | (n[0] & sel[0]);
      
endmodule
