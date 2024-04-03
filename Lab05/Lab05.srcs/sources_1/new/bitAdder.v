`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 11:17:18 AM
// Design Name: 
// Module Name: bitAdder
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


module bitAdder(
    input [7:0] a,
    input [7:0] b,
    input Cin,
    output [7:0] s,
    output Cout
    );
    wire [6:0] cout;
    
    fullAdder F1 (.a(a[0]), .b(b[0]), .Cin(Cin), .s(s[0]), .Cout(cout[0]));
    fullAdder F2 (.a(a[1]), .b(b[1]), .Cin(cout[0]), .s(s[1]), .Cout(cout[1]));
    fullAdder F3 (.a(a[2]), .b(b[2]), .Cin(cout[1]), .s(s[2]), .Cout(cout[2]));
    fullAdder F4 (.a(a[3]), .b(b[3]), .Cin(cout[2]), .s(s[3]), .Cout(cout[3]));
    fullAdder F5 (.a(a[4]), .b(b[4]), .Cin(cout[3]), .s(s[4]), .Cout(cout[4]));
    fullAdder F6 (.a(a[5]), .b(b[5]), .Cin(cout[4]), .s(s[5]), .Cout(cout[5]));
    fullAdder F7 (.a(a[6]), .b(b[6]), .Cin(cout[5]), .s(s[6]), .Cout(cout[6]));
    fullAdder F8 (.a(a[7]), .b(b[7]), .Cin(cout[6]), .s(s[7]), .Cout(Cout));
endmodule
