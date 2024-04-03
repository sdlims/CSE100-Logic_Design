`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2023 11:20:49 AM
// Design Name: 
// Module Name: bugSM
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


module bugSM(
    input Go,
    input clk,
    input touchSlug,
    input timeUp,
    output Inc,
    output flashBug
    );
    
    //Declare some wires
    wire [2:0] presentState, nextState;
    wire IDLE, MOVING, TOUCHING, NEXT_IDLE, NEXT_MOVING, NEXT_TOUCHING;
    
    //READABILITY
    assign IDLE = presentState[0];
    assign MOVING = presentState[1];
    assign TOUCHING = presentState[2];
    
    assign nextState[0] = NEXT_IDLE;
    assign nextState[1] = NEXT_MOVING;
    assign nextState[2] = NEXT_TOUCHING;
    
    //NEXT STATE
    assign NEXT_IDLE = (~Go & IDLE);
    assign NEXT_MOVING = (Go & IDLE) | (~touchSlug & MOVING) | (timeUp & TOUCHING);
    assign NEXT_TOUCHING = (touchSlug & MOVING) | (~timeUp & TOUCHING);
    
    //FLIPFLOPS
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .R(1'b0), .D(nextState[0]), .Q(presentState[0]));
    FDRE #(.INIT(1'b0)) Q12_FF[2:1] (.C({2{clk}}), .R({2{1'b0}}), .CE({2{1'b1}}), .D(nextState[2:1]), .Q(presentState[2:1]));
    
    //OUTPUT LOGIC
    assign Inc = touchSlug & MOVING;
    assign flashBug = ~timeUp & TOUCHING;
endmodule
