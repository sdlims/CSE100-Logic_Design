`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 01:25:12 PM
// Design Name: 
// Module Name: TopMod
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


module TopMod(
    input [14:0] sw,
    input btnD,
    input btnU,
    input btnL,
    input btnR,
    input btnC,
    input clkin,
    output [3:0] an,
    output dp,
    output [15:0] led,
    output [6:0] seg
    );
    wire clk;
    
    labCnt_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    
    
    //Holds UTC and DTC
    wire [1:0] drain;
    
    //Holds output of countUD15L
    wire [14:0] Qout;
   
   //Holds some other random wires 
    wire upInput;
    wire [3:0] ringOut;
    wire [3:0] selectOut;
      
    //Edge Detectors
    wire downInput;
    wire uInput;
    
    EdgeDetector edDetect1(.clk(clk), .x(btnD), .z(downInput));
    EdgeDetector edDetect2(.clk(clk), .x(btnU), .z(uInput));
    
    //Some kind of mysterious box with Q, btnC, and clk; Goes into upInput
    //~(Qout[14:2] & 13'b1111111111111) & 
    //assign upInput = ( ~(((1'b1 & Qout[14]) & (1'b1 & Qout[13]) & (1'b1 & Qout[12]) & (1'b1 & Qout[11]) & (1'b1 & Qout[10]) & (1'b1 & Qout[9]) & (1'b1 & Qout[8]) & (1'b1 & Qout[7]) & (1'b1 & Qout[6]) & (1'b1 & Qout[5]) & (1'b1 & Qout[4]) & (1'b1 & Qout[3]) & (1'b1 & Qout[2]))) & btnC) | (uInput);
    assign upInput = ( ~(&Qout[14:2]) & btnC) | (uInput);

    //counterUD15L Stuff
    countUD15L counter(.Din(sw[14:0]), .Up(upInput), .Dw(downInput), .LD(btnL), .clk(clk), .UTC(drain[0]), .DTC(drain[1]), .Q(Qout));
    
    //Sets led[15] to UTC and led[0] to DTC
    assign led[15] = drain[0] & ringOut[3];
    assign led[0] = drain[1] & ringOut[0];
    
    //assign rest of leds to 0
    assign led[14:1] = 13'b0;  
    
    
    //Start the RingCounter 
    RingCounter rngCnt(.clk(clk), .advance(digsel), .out(ringOut));
    
    //Alternate which AN is being changed
    Selector select(.n({1'b0,Qout}), .sel(ringOut), .h(selectOut));
    
    assign an[3:0] = ~ringOut[3:0];
    
    //Display to AN    
    hex7seg display(.n(selectOut), .seg(seg));
    
endmodule
