`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 11:07:19 AM
// Design Name: 
// Module Name: top_mod
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


module top_mod(
    input [15:0] sw,
    input btnU,
    input btnR,
    input clkin,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );
    
    wire dig_sel;
    wire DP;
    assign led[15:0] = sw[15:0];
    
    wire [7:0] out_add;
    wire [6:0] upperSeg;
    wire [6:0] lowerSeg;
    
    AddSub8 (.A(sw[15:8]), .B(sw[7:0]), .sub(btnU), .S(out_add[7:0]), .ovfl(DP));
    hexSeg upperHex (.n(out_add[7:4]), .seg(upperSeg[6:0]));
    hexSeg lowerHex (.n(out_add[3:0]), .seg(lowerSeg[6:0]));
    
    assign dp = ~DP;
    
    assign an[0] = ~dig_sel;
    assign an[1] = dig_sel;
    assign an[3] = 1;
    assign an[2] = 1;
    
    //Mux so either the upper or lower hex will be displayed
    mux (.s(dig_sel), .i0(upperSeg[6:0]), .i1(lowerSeg[6:0]), .y(seg[6:0]));
    lab2_digsel (.clkin(clkin), .greset(btnR), .digsel(dig_sel));

    
endmodule
