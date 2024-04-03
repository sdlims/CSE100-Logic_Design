`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 12:48:08 PM
// Design Name: 
// Module Name: fullAdder
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


module fullAdder(
    input a,
    input b,
    input Cin,
    output s,
    output Cout
    );
    
    assign s = a ^ b ^ Cin;
    assign Cout = (a & b) | (Cin & a) | (Cin & b);
    
endmodule
