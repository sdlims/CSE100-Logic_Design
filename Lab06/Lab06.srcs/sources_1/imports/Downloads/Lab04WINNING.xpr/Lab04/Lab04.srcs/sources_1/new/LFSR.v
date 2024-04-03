`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:21:28 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR(
    input clk,
    input CE,
    output [7:0] Q
    );
    
    wire [7:0] rnd;
    wire inp;
    
    
    assign inp = rnd[0] ^ rnd[3] ^ rnd[4] ^ rnd[1];
    FDRE # (.INIT(1'b1)) Q0_FF (.C(clk), .R(1'b0), .CE(CE), .D(inp), .Q(rnd[0]));
    FDRE # (.INIT(1'b0)) Q1_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[0]), .Q(rnd[1]));
    FDRE # (.INIT(1'b0)) Q2_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[1]), .Q(rnd[2]));
    FDRE # (.INIT(1'b0)) Q3_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[2]), .Q(rnd[3]));
    FDRE # (.INIT(1'b0)) Q4_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[3]), .Q(rnd[4]));
    
    assign Q[7] = 1'b1;
    assign Q[6:2] = rnd[4:0];
    assign Q[1:0] = 2'b0;
    
endmodule
