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
    input [8:0] n,
    input [3:0] sel,
    output [4:0] h
    );
    //If sign == 1, h[4] == 1
    
    assign h[4] = n[8] & sel[2];
    assign h[3] = (n[7] & sel[1]) | (n[3] & sel[0]);
    assign h[2] = (n[6] & sel[1]) | (n[2] & sel[0]);
    assign h[1] = (n[5] & sel[1]) | (n[1] & sel[0]);
    assign h[0] = (n[4] & sel[1]) | (n[0] & sel[0]);
      
endmodule
