`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2023 11:34:57 AM
// Design Name: 
// Module Name: platformSM
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


module platformSM(
    input Go,
    input clk,
    input Impaled,
    input flashBug,
    //Edge is to detect whether the platform's left edge is at exactly 25 pixels
    input Edge,
    output Move,
    output Stop
    );
    
        
    //Declare some wires
    wire [2:0] presentState, nextState;
    wire IDLE, MOVING, STOP, NEXT_IDLE, NEXT_MOVING, NEXT_STOP;
    
    //READABILITY
    assign IDLE = presentState[0];
    assign MOVING = presentState[1];
    assign STOP = presentState[2];
    
    assign nextState[0] = NEXT_IDLE;
    assign nextState[1] = NEXT_MOVING;
    assign nextState[2] = NEXT_STOP;
    
    //NEXT STATE LOGIC
    assign NEXT_IDLE = (~Go & IDLE);
    assign NEXT_MOVING = (Go & ~Impaled & IDLE) | (~Impaled & MOVING) | (~flashBug & MOVING) | (~flashBug & ~Impaled & STOP);
    assign NEXT_STOP = (flashBug & MOVING) | (Impaled & Edge & MOVING) | (Impaled & Edge & STOP) | (flashBug & STOP);
    
    //FLIPFLOP LOGIC
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .R(1'b0), .D(nextState[0]), .Q(presentState[0]));
    FDRE #(.INIT(1'b0)) Q12_FF[2:1] (.C({2{clk}}), .CE({2{1'b1}}), .R({2{1'b0}}), .D(nextState[2:1]), .Q(presentState[2:1]));
        
    //OUTPUT LOGIC
    assign Move = MOVING;
    assign Stop = STOP;
endmodule
