`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 11:17:01 AM
// Design Name: 
// Module Name: hexSeg
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


module hexSeg(
    input [3:0] n,
    output [6:0] seg
    );
    //assign seg[0] = (sw[3] | sw[2] | sw[1] | ~sw[0])&(sw[3] | ~sw[2] | sw[1] | sw[0])&(~sw[3] |sw[2] | ~sw[1] | ~sw[0])&(~sw[3] | ~sw[2] | sw[1] | ~sw[0]);
    //assign seg[1] = (sw[3] | ~sw[2] | sw[1] | ~sw[0])&(sw[3] | ~sw[2] | ~sw[1] | sw[0])&(~sw[3] | sw[2] | ~sw[1] | ~sw[0])&(~sw[3] | ~sw[2] | sw[1] | sw[0])&(~sw[3] | ~sw[2] | ~sw[1] | sw[0])&(~sw[3] | ~sw[2] | ~sw[1] | ~sw[0]);
    //assign seg[2] = (sw[3] | sw[2] | ~sw[1] | sw[0])&(~sw[3] | ~sw[2] | sw[1] | sw[0])&(~sw[3] | ~sw[2] | ~sw[1] | sw[0])&(~sw[3] | ~sw[2] | ~sw[1] | ~sw[0]);
    //assign seg[3] = (sw[3] | sw[2] | sw[1] | ~sw[0])&(sw[3] | ~sw[2] | sw[1] | sw[0])&(sw[3] | ~sw[2] | ~sw[1] | ~sw[0])&(~sw[3] | sw[2] | sw[1] | ~sw[0])&(~sw[3] | sw[2] | ~sw[1] | sw[0])&(~sw[3] | ~sw[2] | ~sw[1] | ~sw[0]);
    //assign seg[4] = (sw[3] | sw[2] | sw[1] | ~sw[0])&(sw[3] | sw[2] | ~sw[1] | ~sw[0])&(sw[3] | ~sw[2] | sw[1] | sw[0])&(sw[3] | ~sw[2] | sw[1] | ~sw[0])&(sw[3] | ~sw[2] | ~sw[1] | ~sw[0])&(~sw[3] | sw[2] | sw[1] | ~sw[0]);
    //assign seg[5] = (sw[3] | sw[2] | sw[1] | ~sw[0])&(sw[3] | sw[2] | ~sw[1] | sw[0])&(sw[3] | sw[2] | ~sw[1] | ~sw[0])&(sw[3] | ~sw[2] | ~sw[1] | ~sw[0])&(~sw[3] | ~sw[2] | sw[1] | ~sw[0]);
    //assign seg[6] = (sw[3] | sw[2] | sw[1] | sw[0])&(sw[3] | sw[2] | sw[1] | ~sw[0])&(sw[3] | ~sw[2] | ~sw[1] | ~sw[0])&(~sw[3] | ~sw[2] | sw[1] | sw[0]);
    assign seg[0] = (~n[3] & ~n[2] & ~n[1] & n[0])|(~n[3] & n[2] & ~n[1] & ~n[0])|(n[3] & ~n[2] & n[1] & n[0])|(n[3] & n[2] & ~n[1] & n[0]);
    assign seg[1] = (~n[3] & n[2] & ~n[1] & n[0])|(~n[3] & n[2] & n[1] & ~n[0])|(n[3] & ~n[2] & n[1] & n[0])|(n[3] & n[2] & ~n[1] & ~n[0])|(n[3] & n[2] & n[1] & ~n[0])|(n[3] & n[2] & n[1] & n[0]);
    assign seg[2] = (~n[3] & ~n[2] & n[1] & ~n[0])|(n[3] & n[2] & ~n[1] & ~n[0])|(n[3] & n[2] & n[1] & ~n[0])|(n[3] & n[2] & n[1] & n[0]);
    assign seg[3] = (~n[3] & ~n[2] & ~n[1] & n[0])|(~n[3] & n[2] & ~n[1] & ~n[0])|(~n[3] & n[2] & n[1] & n[0])|(n[3] & ~n[2] & ~n[1] & n[0])|(n[3] & ~n[2] & n[1] & ~n[0])|(n[3] & n[2] & n[1] & n[0]);
    assign seg[4] = (~n[3] & ~n[2] & ~n[1] & n[0])|(~n[3] & ~n[2] & n[1] & n[0])|(~n[3] & n[2] & ~n[1] & ~n[0])|(~n[3] & n[2] & ~n[1] & n[0])|(~n[3] & n[2] & n[1] & n[0])|(n[3] & ~n[2] & ~n[1] & n[0]);
    assign seg[5] = (~n[3] & ~n[2] & ~n[1] & n[0])|(~n[3] & ~n[2] & n[1] & ~n[0])|(~n[3] & ~n[2] & n[1] & n[0])|(~n[3] & n[2] & n[1] & n[0])|(n[3] & n[2] & ~n[1] & n[0]);
    assign seg[6] = (~n[3] & ~n[2] & ~n[1] & ~n[0])|(~n[3] & ~n[2] & ~n[1] & n[0])|(~n[3] & n[2] & n[1] & n[0])|(n[3] & n[2] & ~n[1] & ~n[0]);
endmodule
