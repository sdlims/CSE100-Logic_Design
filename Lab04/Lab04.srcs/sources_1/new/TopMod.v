`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:12:26 PM
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
    input clkin,
    input btnR,
    input [15:0] sw,
    input btnU,
    output dp,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
    );
    
    //Create wires
    wire digsel, DTC_Out, LoadTime, clk, RunTime, IncA, IncB, ShowScore, FlashA, FlashB, A_Win, B_Win, Go, ledOn, moveOn;
    wire [7:0] LFSR_Out, timerOut;
    wire [2:0] Synchronization;
    wire [3:0] A_Count, B_Count;
    
    //Declare some stuff
    qsec_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    //Timer and LFSR
    LFSR LFSR_In (.clk(clk), .Q(LFSR_Out));
    timeCounter timer (.Dw(qsec & RunTime), .LD(LoadTime), .Din(LFSR_Out), .clkin(clk), .DTC(DTC_Out), .Q(timerOut));

    assign Go = btnU & ~(sw[15]) & ~(sw[0]) & ~(sw[7]);

    //timerOut displays to AN[2:1]
    assign A_Win = sw[0] | sw[7];
    assign B_Win = sw[15] | sw[7]; 
    //Assign LEDS to the Switch inputs, rest of LEDS are off
    assign led[15] = B_Win;
    assign led[14:9] = 6'b000000;
    assign led[8] = ledOn;
    assign led[7] = ledOn;
    assign led[6:1] = 6'b000000;
    assign led[0] = A_Win;
    

    
    //ADD FLIPFLOPS FOR SYNCHRONIZATION
    FDRE #(.INIT(1'b0)) SYNCH_ANOW (.C(clk), .R(1'b0), .CE(1'b1), .D(A_Win), .Q(Synchronization[2]));
    FDRE #(.INIT(1'b0)) SYNCH_BNOW (.C(clk), .R(1'b0), .CE(1'b1), .D(B_Win), .Q(Synchronization[1]));
    FDRE #(.INIT(1'b0)) SYNCH_GO (.C(clk), .R(1'b0), .CE(1'b1), .D(Go), .Q(Synchronization[0]));
    
    //State Machine
    stateMachine SM (.Go(Synchronization[0]), .TimeUp(DTC_Out), .Anow(Synchronization[2]), .Bnow(Synchronization[1]), .LoadTime(LoadTime), .RunTime(RunTime), .IncA(IncA), .IncB(IncB), .ShowScore(ShowScore), .FlashA(FlashA), .FlashB(FlashB), .clkin(clk), .LED(ledOn), .WIN(moveOn));
    
    wire [1:0] DRAIN;
    
    //Create Counters
    counterDown4L PlayerAC (.clkin(clk), .Dw(1'b0), .Up(IncA), .LD(1'b0), .Din(4'b0000), .Q(A_Count), .DTC(DRAIN[0]));
    counterDown4L PlayerBC (.clkin(clk), .Dw(1'b0), .Up(IncB), .LD(1'b0), .Din(4'b0000), .Q(B_Count), .DTC(DRAIN[1]));
    
    //Create a wire bus to hold PlayerAC, PlayerBC, and timerOut
    wire [15:0] toSelector;
    assign toSelector[15:12] = B_Count;
    assign toSelector[3:0] = A_Count;
    assign toSelector[11:4] = timerOut;
    wire [3:0] toHex;
    wire [3:0] rngCnt;
        
    //RingCounter
    //NOT WORKING!!!!
    ringCounter RNGCNT (.advance(digsel), .clkin(clk), .out(rngCnt));
    
    //Selector
    Selector SEL (.n(toSelector), .sel(rngCnt), .h(toHex));
    
    wire flashingA, flashingB;
    count1Bit aRandom (.clkin(clk), .Up(qsec), .out(flashingA));
    count1Bit bRandom (.clkin(clk), .Up(qsec), .out(flashingB));
    
    //1 == OFF   0 == ON
    assign an[0] = ~(rngCnt[0] & ((~FlashA | ~flashingA))) | ~moveOn;
    assign an[3] = ~(rngCnt[3] & ((~FlashB | ~flashingB))) | ~moveOn;
    assign an[2] = (~rngCnt[2] | ~sw[3]);
    assign an[1] = (~rngCnt[1] | ~sw[3]);
    //hex7seg
    hex7seg hexDisplay(.n(toHex), .seg(seg[6:0]));
    assign dp = 1'b1;
endmodule
