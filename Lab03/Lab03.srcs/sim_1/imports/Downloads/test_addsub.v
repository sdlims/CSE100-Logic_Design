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


module test_add( ); // no inputs/outputs, this is a wrapper

//    reg clkin;
//    reg Up;
//    reg Dw;
//    reg LD;
//    reg [4:0] Din;
//    wire [4:0] Q;
//    wire UTC;
//    wire DTC;

    reg [14:0] sw;
    reg btnD;
    reg btnU;
    reg btnL;
    reg btnR;
    reg btnC;
    reg clkin;
    wire [3:0] an;
    wire dp;
    wire [15:0] led;
    wire [6:0] seg;
    
    
// create one instance of your top level
// and attach it to the registers and wires created above
    TopMod UUT (
//    .clk(clkin),
//    .Up(btnU),
//    .Dw(btnD),
//    .LD(btnL),
//    .Din(Din),
//    .Q(Q),
//    .UTC(UTC),
//    .DTC(DTC)

    .sw(sw),
    .btnD(btnD),
    .btnU(btnU),
    .btnL(btnL),
    .btnR(btnR),
    .btnC(btnC),
    .an(an),
    .dp(dp),
    .led(led),
    .clkin(clkin),
    .seg(seg)
    );
    
    
// create an oscillating signal to impersonate the clock provided on the BASYS 3 board
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

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
	 // add your test vectors here
	 // to set signal foo to value 0 use
	 // foo = 1'b0;
	 // to set signal foo to value 1 use
	 // foo = 1'b1;
	 //always advance time my multiples of 500ns
	 // to advance time by 100ns use the following line
	 
	 //Up = 1, Should Increment by 1
	 
	 #2000
	 
	 sw = 15'b111111111100000;
	 btnC = 1'b0;
	 btnR = 1'b0;
	 btnL = 1'b0;
	 btnD = 1'b0;
	 btnU = 1'b0;
	 
	 #1000
	 btnL = 1'b1;
	 
	 #500
	 btnL = 1'b0;
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnD = 1'b1;
	 btnU = 1'b0;
	 #200
	 btnD = 1'b0;
	 #200
	 btnD = 1'b1;
	 #200
	 btnD = 1'b0;
	 #200
	 btnD = 1'b1;	 
	 #200
	 btnD = 1'b0;
	 #200
	 btnD = 1'b1;
	 #200
	 btnD = 1'b0;
	 #200
	 btnD = 1'b1;	
	 #200
	 btnD = 1'b0;
	 #200
	 btnC = 1'b1;
	 #2000
	 btnC = 1'b0;
	 #200	 	 
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;
	 #200
	 btnU = 1'b0;
	 #200
	 btnU = 1'b1;	 
// you will need to add more ....
          
    end

endmodule
