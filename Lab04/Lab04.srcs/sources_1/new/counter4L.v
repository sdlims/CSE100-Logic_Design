`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:21:28 PM
// Design Name: 
// Module Name: counter4L
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

module counter4L(
    input clk,
    input Inc,
    //Control Signal: Up means we start incrementing
    //Outputs the new 5-bit bus with incremented/decremented values
    output [3:0] Q
    );

    wire CE;
    wire [4:0] incr;
    
    assign CE = Inc;
    
    assign incr[0] = (~Q[0]);
    assign incr[1] = (~Q[1]&Q[0]) | (Q[1]&~Q[0]);
    assign incr[2] = (~Q[2]&Q[1]&Q[0]) | (Q[2]&~Q[1]) | (Q[2]&~Q[0]);
    assign incr[3] = (~Q[3]&Q[2]&Q[1]&Q[0]) | (Q[3]&~Q[2]) | (Q[3]&~Q[1]) | (Q[3]&~Q[0]);


    FDRE #(.INIT(1'b0)) FF_0 (.C(clk), .R(1'b0), .CE(CE), .D(incr[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) FF_1 (.C(clk), .R(1'b0), .CE(CE), .D(incr[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) FF_2 (.C(clk), .R(1'b0), .CE(CE), .D(incr[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) FF_3 (.C(clk), .R(1'b0), .CE(CE), .D(incr[3]), .Q(Q[3]));

endmodule
