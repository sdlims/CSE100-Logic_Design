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


// registers to hold values for the inputs to your top level
    reg [15:0] sw;
    reg btnU, btnR, clkin;
// wires to see the values of the outputs of your top level
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    wire [15:0] led;
    
// create one instance of your top level
// and attach it to the registers and wires created above
    top_lab2 UUT (
     .sw(sw),
     .btnU(btnU),
     .btnR(btnR), 
     .clkin(clkin),
     .seg(seg),
     .an(an),
     .led(led),
     .dp(dp)
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
	 sw = 16'h0507;
	 btnR=1'b0;
	 btnU=1'b0;
	 #500;
	 sw = 16'h0280;
	 #200;
	 btnU=1'b1;
         #2000;

// you will need to add more ....
          
    end

endmodule
