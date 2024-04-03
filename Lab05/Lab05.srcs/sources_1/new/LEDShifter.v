`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2023 12:01:54 AM
// Design Name: 
// Module Name: LEDShifter
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


module LEDShifter(
    input left,
    input right,
    input crossing, 
    input qsec,
    input clkin,
    output [7:0] out
    );
    
    wire CE;
    wire [7:0] leftShift, rightShift;
    wire leftVal, rightVal, RESET;
    
    //Storing left and right values
    //Stores new values after successful crossings
    FDRE #(.INIT(1'b0)) leftFF (.C(clkin), .R(1'b0), .CE(left | right), .D(left), .Q(leftVal));
    FDRE #(.INIT(1'b0)) rightFF (.C(clkin), .R(1'b0), .CE(right | left), .D(right), .Q(rightVal));
    
    
    assign CE = ((leftVal | rightVal) & ~crossing) & qsec;
    
    assign r_RESET = ~&rightShift;
    assign l_RESET = ~&leftShift;
    
    //If we're shifting from Right -> Left
    FDRE #(.INIT(1'b1)) rightShiftFF0 (.C(clkin), .R(1'b0), .CE(CE), .D(1'b1), .Q(rightShift[7]));
    FDRE #(.INIT(1'b0)) rightShiftFF1 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[7] & r_RESET), .Q(rightShift[6]));
    FDRE #(.INIT(1'b0)) rightShiftFF2 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[6] & r_RESET), .Q(rightShift[5]));
    FDRE #(.INIT(1'b0)) rightShiftFF3 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[5] & r_RESET), .Q(rightShift[4]));
    FDRE #(.INIT(1'b0)) rightShiftFF4 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[4] & r_RESET), .Q(rightShift[3]));
    FDRE #(.INIT(1'b0)) rightShiftFF5 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[3] & r_RESET), .Q(rightShift[2]));
    FDRE #(.INIT(1'b0)) rightShiftFF6 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[2] & r_RESET), .Q(rightShift[1]));
    FDRE #(.INIT(1'b0)) rightShiftFF7 (.C(clkin), .R(1'b0), .CE(CE), .D(rightShift[1] & r_RESET), .Q(rightShift[0]));


    //If we're shifting from Left -> Right
    FDRE #(.INIT(1'b1)) leftShiftFF0 (.C(clkin), .R(1'b0), .CE(CE), .D(1'b1), .Q(leftShift[0]));
    FDRE #(.INIT(1'b0)) leftShiftFF1 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[0] & l_RESET), .Q(leftShift[1]));
    FDRE #(.INIT(1'b0)) leftShiftFF2 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[1] & l_RESET), .Q(leftShift[2]));
    FDRE #(.INIT(1'b0)) leftShiftFF3 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[2] & l_RESET), .Q(leftShift[3]));
    FDRE #(.INIT(1'b0)) leftShiftFF4 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[3] & l_RESET), .Q(leftShift[4]));
    FDRE #(.INIT(1'b0)) leftShiftFF5 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[4] & l_RESET), .Q(leftShift[5]));
    FDRE #(.INIT(1'b0)) leftShiftFF6 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[5] & l_RESET), .Q(leftShift[6]));
    FDRE #(.INIT(1'b0)) leftShiftFF7 (.C(clkin), .R(1'b0), .CE(CE), .D(leftShift[6] & l_RESET), .Q(leftShift[7]));    
    
    
    //If left WAS or IS high (while not crossing), then out will be the left -> right shift
    //If right WAS or IS high (while not crossing), then out will be right -> left shift
    assign out[7] = (leftShift[7] & leftVal & ~crossing) | (rightShift[7] & rightVal & ~crossing);
    assign out[6] = (leftShift[6] & leftVal & ~crossing) | (rightShift[6] & rightVal & ~crossing);
    assign out[5] = (leftShift[5] & leftVal & ~crossing) | (rightShift[5] & rightVal & ~crossing);
    assign out[4] = (leftShift[4] & leftVal & ~crossing) | (rightShift[4] & rightVal & ~crossing);
    assign out[3] = (leftShift[3] & leftVal & ~crossing) | (rightShift[3] & rightVal & ~crossing);
    assign out[2] = (leftShift[2] & leftVal & ~crossing) | (rightShift[2] & rightVal & ~crossing);
    assign out[1] = (leftShift[1] & leftVal & ~crossing) | (rightShift[1] & rightVal & ~crossing);
    assign out[0] = (leftShift[0] & leftVal & ~crossing) | (rightShift[0] & rightVal & ~crossing);
    
    
endmodule
