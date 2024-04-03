`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2023 11:09:33 AM
// Design Name: 
// Module Name: Slug
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


module Slug(
    input Up, tPT, tPB, tB, tP, tS,
    input frameTrigger, slowFrameTrigger,
    input Impaled, Flash, 
    input [14:0] colIn, rowIn,
    input clk,
    output slug, 
    output [14:0] slugBottom, slugTopp, slugLeftt, slugRightt
    );
    
//    //FlipFlop to load slug position initially
//    wire select;
//    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .R(1'b0), .CE(1'b1), .D(1'b0), .Q(select));
    
    //WIRES
    wire [14:0] slugT, slugB, slugL, slugR;
    wire Dw, Impale;
    assign Dw = ~Up;
    FDRE #(.INIT(1'b0)) IMPALED (.C(clk), .R(1'b0), .CE(Impaled), .D(Impaled), .Q(Impale));
    countUD15L slugTop (.Up((frameTrigger & Dw & ~(slugT >= 334) & ~tPT & ~tPB & ~tB & ~tP) & ~Impale & ~tS), .Dw((frameTrigger & Up & ~(slugT <= 8) & ~tPB & ~tB & ~tP) & ~tS & ~Impale), .LD((slugT <= 8) & (slugB <= 8)), .clk(clk), .Din(100), .UTC(), .DTC(), .Q(slugT));
    countUD15L slugBot (.Up((frameTrigger & Dw & ~(slugB >= 350) & ~tPT & ~tPB & ~tB & ~tP) & ~Impale & ~tS), .Dw((frameTrigger & Up & ~(slugB <= 24) & ~tPB & ~tB & ~tP) & ~tS & ~Impale), .LD(slugB <= 8), .clk(clk), .Din(116), .UTC(), .DTC(), .Q(slugB));
    
    //(tPT | tPB) & slowFrameTrigger & ~(slugL <= 8)
    //(tPT | tPB) & slowFrameTrigger & ~(slugR <= 24)
    countUD15L slugLeft (.Up(1'b0), .Dw((Impale & ~(slugL == 8)) & slowFrameTrigger), .LD((slugL <= 8) & (slugR <= 8)), .Din(140), .clk(clk), .UTC(), .DTC(), .Q(slugL));
    countUD15L slugRight (.Up(1'b0), .Dw((Impale & ~(slugR == 24))& slowFrameTrigger), .LD(slugR <= 8), .Din(156), .clk(clk), .UTC(), .DTC(), .Q(slugR));
    
    assign slug = ((slugT <= rowIn) & (rowIn <= slugB) & (slugL <= colIn) & (colIn <= slugR)) & ~((Flash & (slugT == 334) & (slugB == 350)) | (Flash & Impale)); //AND if touching platform
    assign slugBottom = slugB;
    assign slugTopp = slugT;
    assign slugLeftt = slugL;
    assign slugRightt = slugR;
endmodule
