`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2023 12:02:09 AM
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
    //Left
    input btnR,
    //Right
    input btnL,
    //Reset
    input btnU,
    //Clk
    input clkin,
    //led display
    output [15:0] led,
    //segment display
    output [6:0] seg,
    //anodes
    output [3:0] an
    );
    wire clk, Up, Dw, Crossing, digsel, sign, overflow;
    wire [1:0] Synchronization;
    wire [7:0] CountOut, Selection;
    wire [3:0] RingOut, SelectOut;
    qsec_clks slowit (.clkin(clkin), .greset(btnU), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    FDRE #(.INIT(1'b0)) Synchronization0 (.C(clk), .CE(1'b1), .R(1'b0), .D(btnL), .Q(Synchronization[0]));
    FDRE #(.INIT(1'b0)) Synchronization1 (.C(clk), .CE(1'b1), .R(1'b0), .D(btnR), .Q(Synchronization[1]));
    
    //State Machine
    StateMachine SM (.left(Synchronization[0]), .right(Synchronization[1]), .clkin(clk), .Up(Up), .Dw(Dw), .Crossing(Crossing));
    
    //Turning off unnecessary LEDs
    assign led[14:9] = 6'b000000;
    
    
    assign led[15] = btnL;
    assign led[8] = btnR;
    
    
    //LEDShifter
    LEDShifter LEDs (.left(Up), .right(Dw), .crossing(Crossing), .qsec(qsec), .clkin(clk), .out(led[7:0]));
    
    //count8UL
    count8UL Counter (.clkin(clk), .Up(Up), .Dw(Dw), .Q(CountOut), .sign(sign));
    
    //ringCounter
    ringCounter RingCounter (.advance(digsel), .clkin(clk), .out(RingOut));
    
    //Selector
    AddSub8 Conversion (.A(8'b0), .B(CountOut), .sub(sign), .S(Selection[7:0]), .ovfl(overflow));
    
    Selector Select (.n(Selection), .sel(RingOut), .h(SelectOut));
    
    //Anode display logic
    //an[2] TEMPORARILY off while I work on that logic
    assign an[3] = 1'b1;
    assign an[2] = ~(sign & RingOut[2]);
    assign an[1:0] = ~RingOut[1:0];
    
    wire [6:0] segWire1, segWire2;
    assign segWire2 = 7'b0111111;
    
    //hex7seg
    hex7seg Display (.n(SelectOut), .seg(segWire1));
    
    assign seg[0] = (~(sign & RingOut[2]) & segWire1[0]) | ((sign & RingOut[2]) & segWire2[0]);
    assign seg[1] = (~(sign & RingOut[2]) & segWire1[1]) | ((sign & RingOut[2]) & segWire2[1]);
    assign seg[2] = (~(sign & RingOut[2]) & segWire1[2]) | ((sign & RingOut[2]) & segWire2[2]);
    assign seg[3] = (~(sign & RingOut[2]) & segWire1[3]) | ((sign & RingOut[2]) & segWire2[3]);
    assign seg[4] = (~(sign & RingOut[2]) & segWire1[4]) | ((sign & RingOut[2]) & segWire2[4]);
    assign seg[5] = (~(sign & RingOut[2]) & segWire1[5]) | ((sign & RingOut[2]) & segWire2[5]);
    assign seg[6] = (~(sign & RingOut[2]) & segWire1[6]) | ((sign & RingOut[2]) & segWire2[6]);
    
endmodule
