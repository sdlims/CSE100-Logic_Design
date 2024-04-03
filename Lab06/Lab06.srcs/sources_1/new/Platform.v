`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2023 11:57:35 AM
// Design Name: 
// Module Name: Platform
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


module Platform(
    input [14:0] colIn,
    input [14:0] rowIn,
    input frameTrigger,
    input clk, Go, tP, Impaled,
    output platform,
    output [14:0] platL1, platR1, platL2, platR2, platL3, platR3
    );
     
    wire [14:0] platformL1, platformR1, platformL2, platformR2, platformL3, platformR3;
    wire [9:0] plat1Din, plat2Din, plat3Din;
    wire [7:0] platformLength1, platformLength2, platformLength3;
    
    //Selector wire
    wire select;
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .R(1'b0), .CE(1'b1), .D(1'b0), .Q(select));
    
    //LFSR platform length randomizers
    LFSR Randomizer1 (.clk(clk), .CE(platformL1 <= 8 & platformR1 <= 8), .Q(platformLength1));
    LFSR Randomizer2 (.clk(clk), .CE(platformL2 <= 8 & platformR2 <= 8), .Q(platformLength2));
    LFSR Randomizer3 (.clk(clk), .CE(platformL3 <= 8 & platformR3 <= 8), .Q(platformLength3));
    
    //Choose where to start
    mux platform1Mux (.i0(799), .i1(140), .s(select), .o(plat1Din));
    mux platform2Mux (.i0(799), .i1(440), .s(select), .o(plat2Din));
    mux platform3Mux (.i0(799), .i1(740), .s(select), .o(plat3Din));

    wire GoS;
    FDRE #(.INIT(1'b0)) GoSignal (.C(clk), .R(1'b0), .CE(Go), .D(1'b1), .Q(GoS));
    wire STOP;
    assign STOP = Impaled & (platL1 == 24 | platL2 == 24 | platL3 == 24);
    
    countUD15L platformLeft1 (.Up(1'b0), .Dw((frameTrigger & ~(platformL1 <= 8) & GoS) & ~STOP), .LD(platformL1 <= 8 & platformR1 <= 8), .clk(clk), .Din(plat1Din), .UTC(), .DTC(), .Q(platformL1));
    countUD15L platformRight1 (.Up(1'b0), .Dw((frameTrigger & GoS) & ~STOP), .LD(platformR1 <= 8), .clk(clk), .Din(plat1Din + platformLength1), .UTC(), .DTC(), .Q(platformR1));

    countUD15L platformLeft2 (.Up(1'b0), .Dw((frameTrigger & ~(platformL2 <= 8) & GoS) & ~STOP), .LD(platformL2 <= 8 & platformR2 <= 8), .clk(clk), .Din(plat2Din), .UTC(), .DTC(), .Q(platformL2));
    countUD15L platformRight2 (.Up(1'b0), .Dw((frameTrigger & GoS) & ~STOP), .LD(platformR2 <= 8), .clk(clk), .Din(plat2Din + platformLength2), .UTC(), .DTC(), .Q(platformR2));

    countUD15L platformLeft3 (.Up(1'b0), .Dw((frameTrigger & ~(platformL3 <= 8) & GoS) & ~STOP), .LD(platformL3 <= 8 & platformR3 <= 8), .clk(clk), .Din(plat3Din), .UTC(), .DTC(), .Q(platformL3));
    countUD15L platformRight3 (.Up(1'b0), .Dw((frameTrigger & GoS) & ~STOP), .LD(platformR3 <= 8), .clk(clk), .Din(plat3Din + platformLength3), .UTC(), .DTC(), .Q(platformR3));
                
    assign platform = (((platformL1 <= colIn) & (colIn <= platformR1)) & ((192 <= rowIn) & (rowIn <= 200)) | ((platformL2 <= colIn) & (colIn <= platformR2) & ((192 <= rowIn) & (rowIn <= 200))) | ((platformL3 <= colIn) & (colIn <= platformR3) & ((192 <= rowIn) & (rowIn <= 200))));
    assign platL1 = platformL1;
    assign platL2 = platformL2;
    assign platL3 = platformL3;
    assign platR1 = platformR1;
    assign platR2 = platformR2;
    assign platR3 = platformR3;
endmodule
