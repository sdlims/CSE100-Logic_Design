`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2023 09:14:08 PM
// Design Name: 
// Module Name: StateMachine
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


module StateMachine(
    //Inputs represent the IR sensors and clk
        //left = left sensor
        //right = right sensor
    input left,
    input right,
    input clkin,
    
    //Outputs determine whether or not something crossed left -> right or right -> left
        //Up = right -> left
        //Dw = left -> right
    output Up,
    output Dw,
    output Crossing
    );
    
    wire [6:0] presentState, nextState;
    wire IDLE, L_LEFT, L_BOTH, L_RIGHT, R_RIGHT, R_BOTH, R_LEFT;
    wire NEXT_IDLE, NEXT_L_LEFT, NEXT_L_BOTH, NEXT_L_RIGHT, NEXT_R_RIGHT, NEXT_R_BOTH, NEXT_R_LEFT;
    
    //For Readability
    assign IDLE = presentState[0];
    assign L_LEFT = presentState[1];
    assign L_BOTH = presentState[2];
    assign L_RIGHT = presentState[3];
    assign R_RIGHT = presentState[4];
    assign R_BOTH = presentState[5];
    assign R_LEFT = presentState[6];
    
    assign nextState[0] = NEXT_IDLE;
    assign nextState[1] = NEXT_L_LEFT;
    assign nextState[2] = NEXT_L_BOTH;
    assign nextState[3] = NEXT_L_RIGHT;
    assign nextState[4] = NEXT_R_RIGHT;
    assign nextState[5] = NEXT_R_BOTH;
    assign nextState[6] = NEXT_R_LEFT;
    
    //STATE LOGIC
    assign NEXT_IDLE  = (IDLE & ~left & ~right) | (IDLE & left & right) | (L_LEFT & ~left & ~right) | (L_BOTH & ~left & ~right) | (L_RIGHT & ~left & ~right) | (R_RIGHT & ~left & ~right) | (R_BOTH & ~left & ~right) | (R_LEFT & ~left & ~right);
    assign NEXT_L_LEFT  = (L_LEFT & left & ~right) | (IDLE & left & ~right) | (L_BOTH & left & ~right);
    assign NEXT_L_BOTH  = (L_BOTH & left & right) | (L_LEFT & left & right) | (L_RIGHT & left & right);
    assign NEXT_L_RIGHT  = (L_RIGHT & ~left & right) | (L_BOTH & ~left & right);
    assign NEXT_R_RIGHT  = (R_RIGHT & ~left & right) | (IDLE & ~left & right) | (R_BOTH & ~left & right);
    assign NEXT_R_BOTH  = (R_BOTH & left & right) | (R_RIGHT & left & right) | (R_LEFT & left & right);
    assign NEXT_R_LEFT  = (R_LEFT & left & ~right) | (R_BOTH & left & ~right);
    
    //FLIP-FLOPS
    
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clkin), .CE(1'b1), .R(1'b0), .D(nextState[0]), .Q(presentState[0]));
    FDRE #(.INIT(1'b0)) Q123456_FF[6:1] (.C({6{clkin}}),.R({6{1'b0}}), .CE({6{1'b1}}), .D(nextState[6:1]), .Q(presentState[6:1]));
    
    //OUTPUT LOGIC
    assign Up = R_LEFT & ~left & ~right;
    assign Dw = L_RIGHT & ~left & ~right;
    assign Crossing = L_LEFT | L_BOTH | L_RIGHT | R_RIGHT | R_BOTH | R_LEFT;
    
endmodule
