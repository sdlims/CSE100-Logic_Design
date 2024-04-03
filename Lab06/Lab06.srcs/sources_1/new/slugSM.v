`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2023 11:47:24 AM
// Design Name: 
// Module Name: slugSM
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


module slugSM(
    input tPT, tPB, tB, tP, tS, clk,
    input Up, timeUp,
    output Rise, Impaled, Fall
    );
    
    //Wire time
    wire [6:0] presentState, nextState;
    wire FALL, JUMP, PLAT_T, PLAT_B, IMPALED, BUG, POND, N_FALL, N_JUMP, N_PLAT_T, N_PLAT_B, N_IMPALED, N_BUG, N_POND, Dw; 
    
    assign Dw = ~Up;
    assign FALL = presentState[0];
    assign JUMP = presentState[1];
    assign PLAT_T = presentState[2];
    assign PLAT_B = presentState[3];
    assign IMPALED = presentState[4];
    assign BUG = presentState[5];
    assign POND = presentState[6];
    
    assign nextState[0] = N_FALL;
    assign nextState[1] = N_JUMP;
    assign nextState[2] = N_PLAT_T;
    assign nextState[3] = N_PLAT_B;
    assign nextState[4] = N_IMPALED;
    assign nextState[5] = N_BUG;
    assign nextState[6] = N_POND;
    
    assign N_FALL = (FALL & Dw) | (Dw & JUMP) | (~tPT & PLAT_T) | (timeUp & Dw & BUG) | (Dw & ~tPB & PLAT_B);
    assign N_JUMP = (Up & JUMP) | (Up & FALL) | (~tPB & PLAT_B) | (timeUp & Up & BUG);
    assign N_PLAT_T = (tPT & FALL) | (tPT & PLAT_T);
    assign N_PLAT_B = (tPB & JUMP) | (tPB & PLAT_B);
    assign N_IMPALED = (tS & FALL) | (tS & JUMP) | (tS & IMPALED);
    assign N_BUG = (tB & FALL) | (tB & JUMP) | (~timeUp & BUG);
    assign N_POND = (tP & Dw & FALL) | (tP & POND);
    
    //FLIPFLOPS
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .R(1'b0), .D(nextState[0]), .Q(presentState[0]));
    FDRE #(.INIT(1'b0)) Q123456_FF[6:1] (.C({6{clk}}),.R({6{1'b0}}), .CE({6{1'b1}}), .D(nextState[6:1]), .Q(presentState[6:1]));
    
    //OUTPUT LOGIC
    assign Impaled = IMPALED;
endmodule
