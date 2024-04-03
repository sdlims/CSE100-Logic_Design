`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:30:11 PM
// Design Name: 
// Module Name: counterDown4L
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


module counterDown4L(
    input clkin,
    input Up,
    //Control Signal: Dw means we start decrementing
    input Dw,
    //Control Signal: Are we loading into Din or not?
    input LD,
    //Din
    input [3:0] Din,
    //Outputs the new 4-bit bus with incremented/decremented values
    output [3:0] Q,
    output DTC
    );

    wire CE;
    wire [3:0] incr, decr, Cout;
    assign CE = (Up ^ Dw) | LD;
    
    assign incr[0] = (~Q[0]);
    assign incr[1] = (~Q[1]&Q[0]) | (Q[1]&~Q[0]);
    assign incr[2] = (~Q[2]&Q[1]&Q[0]) | (Q[2]&~Q[1]) | (Q[2]&~Q[0]);
    assign incr[3] = (~Q[3]&Q[2]&Q[1]&Q[0]) | (Q[3]&~Q[2]) | (Q[3]&~Q[1]) | (Q[3]&~Q[0]);
    

    assign decr[0] = (~Q[0]);
    assign decr[1] = (~Q[1] & ~Q[0]) | (Q[1] & Q[0]);
    assign decr[2] = (~Q[2] & ~Q[1] & ~Q[0]) | (Q[2] & Q[0]) | (Q[2] & Q[1]);
    assign decr[3] = (~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[3] & Q[0]) | (Q[3] & Q[1]) | (Q[3] & Q[2]);

    
    assign Cout[0] = (incr[0] & Up & ~LD) | (decr[0] & Dw & ~LD) | (Din[0] & LD);
    assign Cout[1] = (incr[1] & Up & ~LD) | (decr[1] & Dw & ~LD) | (Din[1] & LD);
    assign Cout[2] = (incr[2] & Up & ~LD) | (decr[2] & Dw & ~LD) | (Din[2] & LD);
    assign Cout[3] = (incr[3] & Up & ~LD) | (decr[3] & Dw & ~LD) | (Din[3] & LD);

    FDRE #(.INIT(1'b0)) FF_0 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) FF_1 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) FF_2 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) FF_3 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[3]), .Q(Q[3]));
    
    //Assign 'Overflow' Output
    assign DTC = ~(Q[3] | Q[2] | Q[1] | Q[0]);
endmodule
