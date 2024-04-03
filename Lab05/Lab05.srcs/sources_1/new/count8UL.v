`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2023 10:23:52 PM
// Design Name: 
// Module Name: count8UL
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


module count8UL(
    input clkin,
    input Up,
    //Control Signal: Dw means we start decrementing
    input Dw,
    //Outputs the new 8-bit bus with incremented/decremented values
    output [7:0] Q,
    //If negative, then sign == 1, else sign == 0
    output sign
    );

    wire CE;
    wire [7:0] incr, decr, Cout;
    assign CE = (Up ^ Dw);
    
    assign incr[0] = (~Q[0]);
    assign incr[1] = (~Q[1]&Q[0]) | (Q[1]&~Q[0]);
    assign incr[2] = (~Q[2]&Q[1]&Q[0]) | (Q[2]&~Q[1]) | (Q[2]&~Q[0]);
    assign incr[3] = (~Q[3]&Q[2]&Q[1]&Q[0]) | (Q[3]&~Q[2]) | (Q[3]&~Q[1]) | (Q[3]&~Q[0]);
    assign incr[4] = (~Q[4] & Q[3] & Q[2] & Q[1] & Q[0]) | (Q[4] & ~Q[3]) | (Q[4] & ~Q[2]) | (Q[4] & ~Q[1]) | (Q[4] & ~Q[0]);
    assign incr[5] = (~Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]) | (Q[5] & ~Q[4]) | (Q[5] & ~Q[3]) | (Q[5] & ~Q[2]) | (Q[5] & ~Q[1]) | (Q[5] & ~Q[0]);
    assign incr[6] = (~Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]) | (Q[6] & ~Q[5]) | (Q[6] & ~Q[4]) | (Q[6] & ~Q[3]) | (Q[6] & ~Q[2]) | (Q[6] & ~Q[1]) | (Q[6] & ~Q[0]);
    assign incr[7] = (~Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0]) | (Q[7] & ~Q[6]) | (Q[7] & ~Q[5]) | (Q[7] & ~Q[4]) | (Q[7] & ~Q[3]) | (Q[7] & ~Q[2]) | (Q[7] & ~Q[1]) | (Q[7] & ~Q[0]);
    
    assign decr[0] = (~Q[0]);
    assign decr[1] = (~Q[1] & ~Q[0]) | (Q[1] & Q[0]);
    assign decr[2] = (~Q[2] & ~Q[1] & ~Q[0]) | (Q[2] & Q[0]) | (Q[2] & Q[1]);
    assign decr[3] = (~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[3] & Q[0]) | (Q[3] & Q[1]) | (Q[3] & Q[2]);
    assign decr[4] = (~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[4] & Q[3]) | (Q[4] & Q[2]) | (Q[4] & Q[1]) | (Q[4] & Q[0]);
    assign decr[5] = (~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[5] & Q[4]) | (Q[5] & Q[3]) | (Q[5] & Q[2]) | (Q[5] & Q[1]) | (Q[5] & Q[0]);
    assign decr[6] = (~Q[6] & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[6] & Q[5]) | (Q[6] & Q[4]) | (Q[6] & Q[3]) | (Q[6] & Q[2]) | (Q[6] & Q[1]) | (Q[6] & Q[0]);
    assign decr[7] = (~Q[7] & ~Q[6] & ~Q[5] & ~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[7] & Q[6]) | (Q[7] & Q[5]) | (Q[7] & Q[4]) | (Q[7] & Q[3]) | (Q[7] & Q[2]) | (Q[7] & Q[1]) | (Q[7] & Q[0]);
    
    assign Cout[0] = (incr[0] & Up) | (decr[0] & Dw);
    assign Cout[1] = (incr[1] & Up) | (decr[1] & Dw);
    assign Cout[2] = (incr[2] & Up) | (decr[2] & Dw);
    assign Cout[3] = (incr[3] & Up) | (decr[3] & Dw);
    assign Cout[4] = (incr[4] & Up) | (decr[4] & Dw);
    assign Cout[5] = (incr[5] & Up) | (decr[5] & Dw);
    assign Cout[6] = (incr[6] & Up) | (decr[6] & Dw);
    assign Cout[7] = (incr[7] & Up) | (decr[7] & Dw);

    FDRE #(.INIT(1'b0)) FF_0 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) FF_1 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) FF_2 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) FF_3 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) FF_4 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0)) FF_5 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[5]), .Q(Q[5]));
    FDRE #(.INIT(1'b0)) FF_6 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[6]), .Q(Q[6]));
    FDRE #(.INIT(1'b0)) FF_7 (.C(clkin), .R(1'b0), .CE(CE), .D(Cout[7]), .Q(Q[7]));
    assign sign = Q[7];

endmodule
