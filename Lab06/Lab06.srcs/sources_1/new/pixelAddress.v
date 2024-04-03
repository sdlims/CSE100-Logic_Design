`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2023 10:53:25 AM
// Design Name: 
// Module Name: VGAController
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


module pixelAddress(
    input clkin,
    output [14:0] colOut, rowOut,
    output Hsync,
    output Vsync
    );
    wire rowReset, colReset;
    //479
    //10'b111011111
    //If at this specific value, rowReset == 1, so resets rows
    assign rowReset = rowOut == 15'd524;
    
    //639
    //10'b1001111111 
    //If at this specific value, colReset == 1, so resets cols
    assign colReset = colOut == 15'd799;
    
    //counts our current pixel address
    countUD15L colCounter (.Up(1'b1), .Din(15'b0), .LD(colReset), .clk(clkin), .Q(colOut));
    countUD15L rowCounter (.Up(colReset), .Din(15'b0), .LD(rowReset & colReset), .clk(clkin), .Q(rowOut));
    
    wire Htemp, Vtemp;
    
    //Hsync
    //low between 655 - 750
    assign Htemp = ~((15'd655 <= colOut) & (15'd750 >= colOut));
    
    //Vsync
    //low between 489 - 490
    assign Vtemp = ~((15'd489 <= rowOut) & (15'd490 >= rowOut));

    FDRE #(.INIT(1'b0)) KEEEEH (.C(clkin), .R(1'b0), .CE(1'b1), .D(Htemp), .Q(Hsync));
    FDRE #(.INIT(1'b0)) QUEEEE (.C(clkin), .R(1'b0), .CE(1'b1), .D(Vtemp), .Q(Vsync));

endmodule
