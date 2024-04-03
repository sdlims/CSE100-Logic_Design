`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2023 11:34:09 AM
// Design Name: 
// Module Name: TopMod
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


module TopMod(
    input btnU, btnR, btnC,
    input clkin,
    output [3:0] vgaRed, vgaGreen, vgaBlue, an,
    output [6:0] seg,
    output [15:0] led,
    output Hsync, Vsync
    );
     
    wire clk, start, digsel;
    labVGA_clks not_so_slow (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    
    wire [14:0] colOut, rowOut;
    pixelAddress currentAdd (.clkin(clk), .colOut(colOut), .rowOut(rowOut), .Hsync(Hsync), .Vsync(Vsync));
    
    //STATE MACHINE STUFF
    wire tPT, tPB, tB, tP, tS, timeUp, Up, Dw;
    wire Inc, flashBug, timerUp, Impaled;
        //Up = btnU is temporary until SM is implemented
    VGALogic vgaLogic (.rowOut(rowOut), .colOut(colOut), .clk(clk), .Up(btnU), .Go(btnC), .flashBug(flashBug), .Inc(Inc), .Impaled(Impaled), .vgaRed(vgaRed), .vgaGreen(vgaGreen), .vgaBlue(vgaBlue), .tPT(tPT), .tPB(tPB), .tB(tB), .tP(tP), .tS(tS), .timeUp(timeUp));
     
    bugSM bugSM(.Go(btnC), .clk(clk), .touchSlug(tB), .timeUp(timeUp), .Inc(Inc), .flashBug(flashBug));
    
    slugSM slugSM (.tPT(tPT), .tPB(tPB), .tB(tB), .tP(tP), .tS(tS), .Up(btnU), .timeUp(timeUp), .clk(clk), .Impaled(Impaled));
    //LEDS for testing
    //assign led[15:0] = {16{Impaled}};
    
    //Counter
    wire [14:0] countOut;
    countUD15L Counter (.Up(Inc), .Dw(1'b0), .LD(1'b0), .clk(clk), .Din(), .UTC(), .DTC(), .Q(countOut));
    
    //Ring Counter and Selector
    wire [3:0] ringOut, selOut;
    wire [15:0] Selection;
    assign Selection [15:8] = 8'b0;
    assign Selection[7:0] = countOut[7:0];
    ringCounter rngCnt (.advance(digsel), .clkin(clk), .out(ringOut));
    Selector Selector (.n(Selection), .sel(ringOut), .h(selOut));
    
    //Anode and Segment stuff
    assign an[3:2] = 2'b11;
    assign an[1:0] = ~ringOut[1:0];
    
    hex7seg Display(.n(selOut), .seg(seg));
endmodule
