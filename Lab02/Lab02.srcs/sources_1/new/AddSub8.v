`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 01:49:59 PM
// Design Name: 
// Module Name: AddSub8
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


module AddSub8(
    input [7:0] A,
    input [7:0] B,
    input sub,
    output [7:0] S,
    output ovfl
    );
    wire [7:0] C;
    wire temp;
    //C is a copy of B, but if we're subtracting, it's the opposite version of B
    assign C[0] = sub ^ B[0];
    assign C[1] = sub ^ B[1];
    assign C[2] = sub ^ B[2];
    assign C[3] = sub ^ B[3];
    assign C[4] = sub ^ B[4];
    assign C[5] = sub ^ B[5];
    assign C[6] = sub ^ B[6];
    assign C[7] = sub ^ B[7];
    
    
    //Add A & C Together
    bitAdder BA (.a(A[7:0]), .b(C[7:0]), .Cin(sub), .Cout(temp), .s(S[7:0]));

    //If the signs of a, b are equal AND the sign of sum is the opposite, then overflow = 1
    //a = 0, b = 1, s = 1: (0 ^ 1) = 1; (1 ^ 1) = 0; 0 & 1 = 0, no Overflow
    //a = 1, b = 1, s = 1: (1 ^ 1) = 0; 0 & 0 = 0, no Overflow
    //a = 1, b = 1, s = 0: (1 ^ 0) = 1; 1 & 1 = 1, Overflow
    assign ovfl = (A[7] ^ S[7]) & (B[7] ^ S[7]);
    
endmodule
