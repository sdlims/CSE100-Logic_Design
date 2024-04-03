`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2023 02:53:33 PM
// Design Name: 
// Module Name: VGALogic
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


module VGALogic(
    input [14:0] colOut, rowOut,
    input clk,
    input Up, Go,
    input flashBug, Inc, Impaled,
    output [3:0] vgaRed, vgaGreen, vgaBlue,
    output tPB, tPT, tB, tP, tS, timeUp
    );
    
    
    //FRAME TRIGGER
        //frameTrigger is ONLY used for moving objects, static objects do not need frameTrigger
    wire frameTrigger1, frameTrigger2, frameTrigger;
    assign frameTrigger1 = rowOut == 482 & colOut == 770;
    assign frameTrigger2 = rowOut == 520 & colOut == 790;
    assign frameTrigger = frameTrigger1 | frameTrigger2;
    
    //For flashing
    wire[14:0] Flash;
    countUD15L flashing (.Up(frameTrigger), .Dw(1'b0), .LD(1'b0), .clk(clk), .Din(), .UTC(), .DTC(), .Q(Flash));
    
    //Timer for Slug and Bug collision
    wire timeUp;
    countUD15L Timer (.Up(1'b0), .Dw(tB & frameTrigger), .LD(timeUp), .Din(10'b0001111011), .clk(clk), .UTC(), .DTC(timeUp), .Q());
    
    //Active wire to output colors into active region
    wire Active;
    assign Active = (colOut >= 0) & (colOut <= 639) & (rowOut >= 0) & (rowOut <= 479);
    
    //POND
    wire pond;
    assign pond = 350 <= rowOut & rowOut <= 471 & 8 <= colOut & colOut <= 631;

    
    //BORDER
    wire borderN, borderE, borderS, borderW, border;
    assign borderN = 0 <= rowOut & rowOut <= 7 & 0 <= colOut & colOut <= 639;
    assign borderE = 0 <= rowOut & rowOut <= 639 & 632 <= colOut & colOut <= 639;
    assign borderS = 471 <= rowOut & rowOut <= 479 & 0 <= colOut & colOut <= 639;
    assign borderW = 0 <= rowOut & rowOut <= 639 & 0 <= colOut & colOut <= 7;
    assign border = borderN | borderE | borderS | borderW;
   
    //PLATFORMS
        //frameTrigger necessary
    wire platform;
    wire [14:0] platL1, platR1, platL2, platR2, platL3, platR3;
    Platform Platform(.colIn(colOut), .rowIn(rowOut), .clk(clk), .Go(Go), .tP(tP), .Impaled(Impaled), .frameTrigger(frameTrigger1), .platform(platform), .platL1(platL1), .platL2(platL2), .platL3(platL3), .platR1(platR1), .platR2(platR2), .platR3(platR3));
    
    //BUG
        //frameTrigger necessary
    wire bug;
    wire [14:0] bugL, bugR, bugT;
    Bug Bug(.colIn(colOut), .rowIn(rowOut), .clk(clk), .Go(Go), .frameTrigger(frameTrigger), .tB(tB), .tP(tP), .flashBug(flashBug), .Flash(Flash[4]), .timeUp(timeUp), .bugLeft(bugL), .bugRight(bugR), .bugTop(bugT), .bug(bug));
    

    
    //SLUG
    wire slug;
    wire [14:0] slugT, slugB, slugL, slugR;
    Slug Slugg (.Up(Up), .frameTrigger(frameTrigger), .slowFrameTrigger(frameTrigger2), .colIn(colOut), .clk(clk), .tPT(tPT), .tPB(tPB), .tB(tB), .tP(tP), .tS(tS), .Flash(Flash[4]), .Impaled(Impaled), .slugBottom(slugB), .slugTopp(slugT), .slugLeftt(slugL), .slugRightt(slugR), .rowIn(rowOut), .slug(slug));
    
    //Assign colors
    assign vgaRed = {4{Active}} & (({4{pond}} & 4'b0011) | ({4{border}} & 4'b0000) | ({4{platform & ~border}} & 4'b0100) | ({4{slug & ~border}} & 4'b1111));
    assign vgaGreen = {4{Active}} & (({4{pond}} & 4'b0100) | ({4{border}} & 4'b0000) | ({4{platform & ~border}} & 4'b0011) | ({4{bug & ~border}} & 4'b1111) | ({4{slug & ~border}} & 4'b1110));
    assign vgaBlue = {4{Active}} & (({4{pond}} & 4'b0011) | ({4{border}} & 4'b1111) | ({4{platform & ~border}} & 4'b0011)); 
    

    
    //Assign touching logic
    assign tPT = (slugB <= 192 & slugT >= 176) & ((platL1 <= slugL & slugL <= platR1) | (platL2 <= slugL & slugL <= platR2) | (platL3<= slugL & slugL <= platR3) | (platL1 <= slugR & slugR <= platR1) | (platL2 <= slugR & slugR <= platR2) | (platL3<= slugR & slugR <= platR3));
    assign tPB = (slugB <= 216 & slugT >= 200) & ((platL1 <= slugL & slugL <= platR1) | (platL2 <= slugL & slugL <= platR2) | (platL3<= slugL & slugL <= platR3) | (platL1 <= slugR & slugR <= platR1) | (platL2 <= slugR & slugR <= platR2) | (platL3<= slugR & slugR <= platR3));
    assign tB = (bugL <= slugR & slugR <= bugR & (bugT - 8) <= slugB & slugB <= (bugT)) | (bugR <= slugR & slugR <= bugR & (bugT - 8) <= slugT & slugT <= (bugT)) | (bugL <= slugL & slugL <= bugR & (bugT - 8) <= slugB & slugB <= (bugT)) | (bugR <= slugL & slugL <= bugR & (bugT - 8) <= slugT & slugT <= bugT) | (slugL <= bugL & bugL <= slugR & bugT == slugB) | (slugL <= bugL & bugL <= slugR & (bugT - 8) == slugT);
    assign tP = (slugT == 334) & (slugB == 350);
    assign tS = ((slugR == platL1) | (slugR == platL2) | (slugR == platL3)) & ((192 <= slugT & slugT <= 200) | (192 <= slugB & slugB <= 200));
endmodule
