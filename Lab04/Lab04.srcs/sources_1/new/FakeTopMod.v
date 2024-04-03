`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 03:34:29 PM
// Design Name: 
// Module Name: FakeTopMod
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


module FakeTopMod(
    input clkin,
    input btnR,
    input [15:0] sw,
    input btnU,
    output dp,
    output [15:0] led,
    //output [6:0] seg,
    output [3:0] an
    );
    
    //Create wires
    wire digsel, qsec, DTC_Out, LoadTime, RunTime, IncA, IncB, ShowScore, FlashA, FlashB, A_Win, B_Win;
    wire [7:0] LFSR_Out, timerOut;
    wire [2:0] Synchronization;
    wire [3:0] A_Count, B_Count;
    
    //Declare some stuff
    //qsec_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    LFSR LFSR_In (.clk(clkin), .Q(LFSR_Out));
    timeCounter timer (.Dw(RunTime), .LD(LoadTime), .Din(LFSR_Out), .clk(clkin), .DTC(DTC_Out), .Q(timerOut));
    //timerOut displays to AN[2:1]
    
    assign A_Win = sw[0] | sw[7];
    assign B_Win = sw[15] | sw[7]; 
    
    assign led[15] = A_Win;
    assign led[0] = B_Win;
    assign led[14:1] = 14'b00000000000000;
    //ADD FLIPFLOPS FOR SYNCHRONIZATION
    FDRE #(.INIT(1'b0)) SYNCH_ANOW (.C(clkin), .CE(1'b1), .D(A_Win), .Q(Synchronization[2]));
    FDRE #(.INIT(1'b0)) SYNCH_BNOW (.C(clkin), .CE(1'b1), .D(B_Win), .Q(Synchronization[1]));
    FDRE #(.INIT(1'b0)) SYNCH_GO (.C(clkin), .CE(1'b1), .D(btnU & ~(sw[15]) & ~(sw[0])), .Q(Synchronization[0]));
    
    stateMachine SM (.Go(Synchronization[0]), .TimeUp(DTC_Out), .Anow(Synchronization[2]), .Bnow(Synchronization[1]), .LoadTime(LoadTime), .RunTime(RunTime), .IncA(IncA), .IncB(IncB), .ShowScore(ShowScore), .FlashA(FlashA), .FlashB(FlashB), .clk(clkin));
    
    //Create Counters
    counter4L PlayerAC(.clk(clkin), .Inc(IncA), .Q(A_Count));
    counter4L PlayerBC(.clk(clkin), .Inc(IncB), .Q(B_Count));
    
    assign an[0] = 1'b0;
    assign an[3] = 1'b0;
    assign an[2:1] = 1'b1;
    assign led[15] = sw[15];
    assign led[0] = sw[0];
    assign led[8:7] = DTC_Out;
    //assign an[2:1] = sw[13];
    assign dp = 1'b0;
endmodule
