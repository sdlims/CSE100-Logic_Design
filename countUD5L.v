`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 10:54:38 AM
// Design Name: 
// Module Name: countUD5L
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


module countUD5L(
    input clk,
    //Control Signal: Up means we start incrementing
    input Up,
    //Control Signal: Dw means we start decrementing
    input Dw,
    //Control Signal: Are we loading into Din or not?
    input LD,
    //Gets loaded with LD IF LD is high
    input [4:0] Din,
    //Outputs the new 5-bit bus with incremented/decremented values
    output [4:0] Q,
    //Control Signal: Are we still incrementing?
    output UTC,
    //Control Signal: Are we still decrementing?
    output DTC
    );

    wire CE;
    wire [4:0] incr, decr, Cout;
    assign CE = (Up ^ Dw) | LD;
    
    assign incr[0] = (~Q[0]);
    assign incr[1] = (~Q[1]&Q[0]) | (Q[1]&~Q[0]);
    assign incr[2] = (~Q[2]&Q[1]&Q[0]) | (Q[2]&~Q[1]) | (Q[2]&~Q[0]);
    assign incr[3] = (~Q[3]&Q[2]&Q[1]&Q[0]) | (Q[3]&~Q[2]) | (Q[3]&~Q[1]) | (Q[3]&~Q[0]);
    assign incr[4] = (~Q[4]&Q[3]&Q[2]&Q[1]&Q[0]) | (Q[4]&~Q[3]) | (Q[4]&~Q[2]) | (Q[4]&~Q[0])| (Q[4]&~Q[1]);
    
    assign decr[0] = (~Q[0]);
    assign decr[1] = (~Q[1] & ~Q[0]) | (Q[1] & Q[0]);
    assign decr[2] = (~Q[2] & ~Q[1] & ~Q[0]) | (Q[2] & Q[0]) | (Q[2] & Q[1]);
    assign decr[3] = (~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[3] & Q[0]) | (Q[3] & Q[1]) | (Q[3] & Q[2]);
    assign decr[4] = (~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[4] & Q[1]) | (Q[4] & Q[2]) | (Q[4] & Q[3]) | (Q[4] & Q[0]);
    
    assign Cout[0] = (incr[0] & Up & ~LD) | (decr[0] & Dw & ~LD) | (LD & Din[0]);
    assign Cout[1] = (incr[1] & Up & ~LD) | (decr[1] & Dw & ~LD) | (LD & Din[1]);
    assign Cout[2] = (incr[2] & Up & ~LD) | (decr[2] & Dw & ~LD) | (LD & Din[2]);
    assign Cout[3] = (incr[3] & Up & ~LD) | (decr[3] & Dw & ~LD) | (LD & Din[3]);
    assign Cout[4] = (incr[4] & Up & ~LD) | (decr[4] & Dw & ~LD) | (LD & Din[4]);

    FDRE #(.INIT(1'b0)) FF_0 (.C(clk), .R(1'b0), .CE(CE), .D(Cout[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) FF_1 (.C(clk), .R(1'b0), .CE(CE), .D(Cout[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) FF_2 (.C(clk), .R(1'b0), .CE(CE), .D(Cout[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) FF_3 (.C(clk), .R(1'b0), .CE(CE), .D(Cout[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) FF_4 (.C(clk), .R(1'b0), .CE(CE), .D(Cout[4]), .Q(Q[4]));
    
    //Assign 'Overflow' Output
    assign UTC = (Q[4] & Q[3] & Q[2] & Q[1] & Q[0]);
    assign DTC = ~(Q[4] | Q[3] | Q[2] | Q[1] | Q[0]);
    
endmodule
