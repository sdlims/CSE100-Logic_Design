`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 02:21:28 PM
// Design Name: 
// Module Name: stateMachine
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


module stateMachine(
    input Go,
    input TimeUp,
    input Anow,
    input Bnow,
    input clkin,
    output LoadTime,
    output RunTime,
    output LED,
    output WIN,
    output IncA,
    output IncB,
    output ShowScore,
    output FlashA,
    output FlashB
    );
    
    //Create some wires that will hold values
    wire [8:0] presentState, nextState;
    wire START, BOTH_LOSE, A_LOSE, B_LOSE, PLAY, A_WIN, B_WIN, BOTH_WIN, WAITING;
    wire NEXT_START, NEXT_BOTH_LOSE, NEXT_A_LOSE, NEXT_B_LOSE, NEXT_PLAY, NEXT_A_WIN, NEXT_B_WIN, NEXT_BOTH_WIN, NEXT_WAITING;
    wire stay, leave;
    
    //Assign stay and leave
    assign stay = ~Go;
    assign leave = Go;
    
    //Create names to make everything easier
    assign START = presentState[0];
    assign A_LOSE = presentState[1];
    assign B_LOSE = presentState[2];
    assign BOTH_LOSE = presentState[3];
    assign PLAY = presentState[4];
    assign A_WIN = presentState[5];
    assign B_WIN = presentState[6];
    assign BOTH_WIN = presentState[7];
    assign WAITING = presentState[8];
    
    assign nextState[0] = NEXT_START;
    assign nextState[1] = NEXT_A_LOSE;
    assign nextState[2] = NEXT_B_LOSE;
    assign nextState[3] = NEXT_BOTH_LOSE;
    assign nextState[4] = NEXT_PLAY;
    assign nextState[5] = NEXT_A_WIN;
    assign nextState[6] = NEXT_B_WIN;
    assign nextState[7] = NEXT_BOTH_WIN;
    assign nextState[8] = NEXT_WAITING;
    
    //Logic
    assign NEXT_START = (leave & A_WIN) | (leave & B_WIN) | (leave & BOTH_WIN) | (leave & A_LOSE) | (leave & B_LOSE) | (leave & BOTH_LOSE) | (~(Go) & START);
    assign NEXT_A_LOSE = ((Anow & ~(TimeUp) & WAITING) | (stay & A_LOSE)) & ~((Anow & Bnow & WAITING & ~(TimeUp)) | (stay & BOTH_LOSE));
    assign NEXT_B_LOSE = ((Bnow & ~(TimeUp) & WAITING) | (stay & B_LOSE)) & ~((Anow & Bnow & WAITING & ~(TimeUp)) | (stay & BOTH_LOSE));
    assign NEXT_BOTH_LOSE = (Anow & Bnow & WAITING & !(TimeUp)) | (stay & BOTH_LOSE);
    assign NEXT_PLAY = (TimeUp & PLAY & ~(Anow | Bnow)) | (WAITING & TimeUp);
    assign NEXT_A_WIN = ((~Bnow & Anow & TimeUp & PLAY) | (stay & A_WIN));
    assign NEXT_B_WIN = ((~Anow & Bnow & TimeUp & PLAY) | (stay & B_WIN));
    assign NEXT_BOTH_WIN = (Anow & Bnow & TimeUp & PLAY) | (Anow & Bnow & BOTH_WIN);
    assign NEXT_WAITING = (START & Go) | (WAITING & ~TimeUp & ~(Anow | Bnow));
    
    //Output Logic
    assign LoadTime = Go;
    assign RunTime = ~TimeUp & ~(WIN);
    assign IncB = ((Anow & ~TimeUp & WAITING) | (Bnow & TimeUp & PLAY) | (Anow & Bnow & TimeUp & PLAY)) & ~(Bnow & ~TimeUp & WAITING);
    assign IncA = ((Bnow & ~TimeUp & WAITING) | (Anow & TimeUp & PLAY) | (Anow & Bnow & TimeUp & PLAY)) & ~(Anow & ~TimeUp & WAITING);
    assign ShowScore = (stay & BOTH_LOSE) | (stay & B_LOSE) | (stay & A_LOSE) | (stay & A_WIN) | (stay & B_WIN) | (stay & BOTH_WIN);
    assign LED = PLAY;
    assign WIN = A_WIN | B_WIN | BOTH_WIN | A_LOSE | B_LOSE | BOTH_LOSE | START;
    
    //CHANGE FLASH LOGIC
    assign FlashA = (stay & B_LOSE) | (stay & A_WIN) | (stay & BOTH_WIN);
    assign FlashB = (stay & A_LOSE) | (stay & B_WIN) | (stay & BOTH_WIN);
    
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clkin), .CE(1'b1), .R(1'b0), .D(nextState[0]), .Q(presentState[0]));
    FDRE #(.INIT(1'b0)) Q1234567_FF[8:1] (.C({8{clkin}}),.R({8{1'b0}}), .CE({8{1'b1}}), .D(nextState[8:1]), .Q(presentState[8:1]));
endmodule
