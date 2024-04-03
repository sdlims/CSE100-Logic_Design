`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  Martine
// 
// Create Date: 9/27/2022 09:26:52 PM
// Design Name: 
// Module Name: prelab4
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


module prelab4( ); // no inputs/outputs, this is a wrapper


// registers to hold values for the inputs to your top level

        //State Machine
    reg Go, TimeUp, Anow, Bnow, clkin;
    
        //Time Counter
//    reg Dw, LD, clkin;
//    reg [7:0] Din;

        //Ring Counter
    //reg advance, clkin;  
          
// wires to see the values of the outputs of your top level

        //State Machine
    wire LoadTime, RunTime, LED, IncA, IncB, ShowScore, FlashA, FlashB;
    
        //Time Counter
//    wire DTC;
//    wire [7:0] Q;
    
        //Ring Counter
      //wire [3:0] out;
        
// create one instance of your top level
// and attach it to the registers and wires created above
    stateMachine UUT (
        .Go(Go),
        .TimeUp(TimeUp),
        .Anow(Anow),
        .Bnow(Bnow),
        .clkin(clkin),
        .LoadTime(LoadTime),
        .RunTime(RunTime),
        .LED(LED),
        .IncA(IncA),
        .IncB(IncB),
        .ShowScore(ShowScore),
        .FlashA(FlashA),
        .FlashB(FlashB)
    );

//    timeCounter UUT(
//        .Dw(Dw),
//        .LD(LD),
//        .Din(Din),
//        .clkin(clkin),
//        .DTC(DTC),
//        .Q(Q)
//    );
//      ringCounter UUT(
//          .advance(advance),
//          .clkin(clkin),
//          .out(out)
//      );
    
    
// create an oscillating signal to impersonate the clock provided on the BASYS 3 board

    initial    // Clock process for clkin
    begin
		  clkin = 1'b1;
        forever
        begin
            #40 clkin = ~clkin;
        end
    end
	
// here is where the values for the registers are provided
// time must be advanced after every change
   initial
   begin
   
   //Ring Counter
//   advance = 1'b0;
//   #500;
//   advance = 1'b1;
//   #2000;
//   advance = 1'b0;
   
   //Time Counter
//    Din = 8'b00110011;
//    Dw = 1'b0;
//    LD = 1'b0;
//    #500;
//    LD = 1'b1;
//    Dw = 1'b1;
//    #100;
//    LD = 1'b0;
//    #1000;
//    Dw = 1'b0;
//    #100;
//    Din = 8'b00000111;
//    #100;
//    LD = 1'b1;
//    Dw = 1'b1;
//    #100;
//    LD = 1'b0;
//    #1000;
//    Dw = 1'b0;

    //State Machine
   //Inputs are: Go, TimeUp, Anow, Bnow
   Anow = 1'b0;
   Bnow = 1'b0;
   Go = 1'b0;
   TimeUp = 1'b0;
   #200;
   Go = 1'b1;
   #100;
   Go = 1'b0;
   TimeUp = 1'b1;
   #100;
   Anow = 1'b1;
   #100;
   Bnow = 1'b1;
   #200;
   Anow = 1'b0;
   Bnow = 1'b0;
   Bnow = 1'b0;
   TimeUp = 1'b0;
   #100;
   //Entering Play Phase
   Go = 1'b1;
   #100;
   //Inside Play Phase, set TimeUp == 1
   TimeUp = 1'b1;
   #100;
   //Player B Wins
   Go = 1'b0;
   Bnow = 1'b1;
   #200;
   //Resetting Timer and Bnow, should move to Start Phase
   TimeUp = 1'b0;
   Bnow = 1'b0;
   
   //Testing if Both can win
   
   #100;
   Go = 1'b1;
   //Currently in Play Phase
   #100;
   Go = 1'b0;
   #100;
   TimeUp = 1'b1;
   #100;
   Anow = 1'b1;
   Bnow = 1'b1;
   #200;
   TimeUp = 1'b0;
   Anow = 1'b0;
   Bnow = 1'b0;
   
   //Testing Player A loses to by preemptive switch
   
   #100;
   Go = 1'b1;
   #200;
   Go = 1'b0;
   #100;
   Anow = 1'b1;
   #200;
   TimeUp = 1'b1;
   #100;
   Bnow = 1'b1;
   #200;
   Anow = 1'b0;
   Bnow = 1'b0;
   TimeUp = 1'b0;
   
   //Testing Player B loses to preemptive switch
   
   #100;
   Go = 1'b1;
   #200;
   Go = 1'b0;
   #100;
   Bnow = 1'b1;
   #200;
   TimeUp = 1'b1;
   #100;
   Anow = 1'b1;
   #200;
   Anow = 1'b0;
   Bnow = 1'b0;
   TimeUp = 1'b0;
   
   //Testing if BOTH Players are Stupid
   
   #100;
   Go = 1'b1;
   #200;
   Go = 1'b0;
   #100;
   Bnow = 1'b1;
   Anow = 1'b1;
   #200;
   TimeUp = 1'b1;
   #200;
   Anow = 1'b0;
   Bnow = 1'b0;
   TimeUp = 1'b0;   
   end
endmodule
