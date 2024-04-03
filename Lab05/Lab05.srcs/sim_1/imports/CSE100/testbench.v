`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  Martine
// 
// Create Date: 9/27/2022 09:26:52 PM
// Design Name: 
// Module Name: test_add
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


module testbench( ); // no inputs/outputs, this is a wrapper


// registers to hold values for the inputs to your top level
        //State Machine
    //reg left, right, clkin;
    
        //Counter
     //reg clkin, Up, Dw;
     
        //LEDShifter
    //reg left, right, crossing, qsec, clkin;
    
        //TOPMOD
     reg btnR, btnL, btnU, clkin;
     
// wires to see the values of the outputs of your top level
        //State Machine
    //wire Up, Dw;
    
        //Counter
     //wire [7:0] Q;
     
        //LEDShifter
    //wire [7:0] out;
    
        //TOPMOD
    wire [15:0] led;
    wire [6:0] seg;
    wire [3:0] an;
    
// create one instance of your top level
// and attach it to the registers and wires created above
//    StateMachine UUT (
//     .left(left),
//     .right(right),
//     .clkin(clkin), 
//     .Up(Up),
//     .Dw(Dw)
//    );
//    count8UL UUT(
//        .clkin(clkin),
//        .Up(Up),
//        .Dw(Dw),
//        .Q(Q)
//    );  
//    LEDShifter UUT(
//        .left(left),
//        .right(right),
//        .crossing(crossing),
//        .qsec(qsec),
//        .clkin(clkin),
//        .out(out)
//    ); 
    TopMod UUT(
    .btnR(btnR),
    .btnL(btnL),
    .btnU(btnU),
    .clkin(clkin),
    .led(led),
    .seg(seg),
    .an(an)
    );
    
// create an oscillating signal to impersonate the clock provided on the BASYS 3 board
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 0;

    initial    // Clock process for clkin
    begin
        #OFFSET
		  clkin = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
        end
    end
	
// here is where the values for the registers are provided
// time must be advanced after every change
   initial
   begin
   
   //STATE MACHINE
   
//   //Initialize to 0
//   left = 1'b0;
//   right = 1'b0;
   
//   //Scenario 1: Left -> Right, resulting in Dw going high
//   #200;
//        //Crossing left sensor
//   left = 1'b1;
   
//   #200;
//        //Crossing both sensors
//   right = 1'b1;
   
//   #200;
//        //Leaving left sensor
//   left = 1'b0;
   
//   #200;
//        //Exiting sensors: Dw should be 1
//   right = 1'b0;
//   #500;
   
//   //Scenario 2: Right -> Left, resulting in Up going high
//   #200;
//        //Crossing right sensor
//   right = 1'b1;
   
//   #200;
//    //Crossing left sensor
//   left = 1'b1;
   
//   #200;
//        //Leaving right sensor
//   right = 1'b0;
   
//   #200;
//        //Leaving both sensors, Up should be 1
//   left = 1'b0;
//   #500;
   
   
//   //Scenario 3: Faking Left, nothing should happen besides state transitions
//   #200;
//        //Crossing left sensor
//   left = 1'b1;
   
//   #200;
//        //Crossing both sensors
//   right = 1'b1;
   
//   #200;
//        //Leaving right sensor
//   right = 1'b0;
   
//   #200;
//        //Leaving both sensors, since we didn't pass Left -> Right, Dw should be 0
//   left = 1'b0;
//   #500;
   
//   //Scenario 4: Faking Right, nothing should happen besides state transitions
//    #200;
//        //Crossing right sensor
//    right = 1'b1;  
    
//    #200;
//        //Crossing left sensor
//    left = 1'b1;
    
//    #200;
//        //Leaving left sensor
//    left = 1'b0;
    
//    #200;
//        //Leaving both sensors, since we didn't pass Right -> Left, Up should be 0
//    right = 1'b0;
//    #500;
    
//    //Scenario 5: The object is removed during BOTH state, should return to IDLE
//    #200;
//        //Crossing left sensor
//    left = 1'b1;
    
//    #200;
//        //Crossing right sensor
//    right = 1'b1;
//    #200;
    
//        //Object removed, should return to IDLE state
//    left = 1'b0;
//    right = 1'b0;
//    #500;
    
//    //Scenario 6: Convoluted Left -> Right movement
//   #200;
//        //Crossing left sensor
//   left = 1'b1;
   
//   #200;
//        //Crossing both sensors
//   right = 1'b1;
   
//   #200;
//   right = 1'b0;
   
//   #200;
//   right = 1'b1;
   
//   #200;
//        //Leaving left sensor
//   left = 1'b0;
   
//   #200;
//        //Went back to left sensor
//   left = 1'b1;
        
//   #200;
//        //Left left sensor again (haha)
//   left = 1'b0;
   
//   #200;
//        //Exiting sensors: Dw should be 1
//   right = 1'b0;
//   #500;
   
//    //Scenario 7: Convoluted Right -> Left movement
    
    
    // COUNTER
    
    //Initialize to 0
//    Up = 1'b0;
//    Dw = 1'b0;
    
//    //Testing Dw
//    #100;
//    Dw = 1'b1;
//    #100;
//    Dw = 1'b0;
//    #100;
//    Dw = 1'b1;
//    #100;
//    Dw = 1'b0;
//    #100;
//    Dw = 1'b1;
//    #100;
//    Dw = 1'b0;
//    #100;
//    Dw = 1'b1;
//    #100;
//    Dw = 1'b0;
//    #100;
    
//    //Testing Up
//    #200;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;
//    Up = 1'b1;
//    #100;
//    Up = 1'b0;
//    #100;

    //LEDShifter
//    left = 1'b0;
//    right = 1'b0;
//    crossing = 1'b0;
//    qsec = 1'b1;
//    #200;
    
//    //Right is high, crossing is low: LEDs should be shifting
//    right = 1'b1;
//    #500;
    
//    //Make crossing high: Should stop the shifting
//    crossing = 1'b1;
    
//    //Making crossing low again: Should resume RIGHT shifting
//    #200;
//    crossing = 1'b0;
    
//    //Right goes low, should STILL be flashing
//    #200;
//    right = 1'b0;
//    #500;
    
//    //Now left is high, should result in changing directions
//    left = 1'b1;


    //TOP MOD
    //Time to stress
    btnR = 1'b0;
    btnL = 1'b0;
    btnU = 1'b0;
    
    //Simulating Right -> Left
    //Should increment Counter to 1
    //LEDs should start switching
    
    #200;
    btnR = 1'b1;
    
    #200;
    btnL = 1'b1;
    
    #200;
    btnR = 1'b0;
    
    #200;
    btnL = 1'b0;
    #500;
    
    
    end

endmodule
