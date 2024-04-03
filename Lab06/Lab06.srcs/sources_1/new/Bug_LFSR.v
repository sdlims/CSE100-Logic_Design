`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2023 10:25:53 AM
// Design Name: 
// Module Name: Bug_LFSR
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


module Bug_LFSR(
    input clk,
    input CE,
    output [8:0] Q
    );
    
    wire [7:0] rnd;
    wire inp;
    
    assign inp = rnd[0] ^ rnd[3] ^ rnd[4] ^ rnd[1];
    FDRE # (.INIT(1'b1)) Q0_FF (.C(clk), .R(1'b0), .CE(CE), .D(inp), .Q(rnd[0]));
    FDRE # (.INIT(1'b0)) Q1_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[0]), .Q(rnd[1]));
    FDRE # (.INIT(1'b0)) Q2_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[1]), .Q(rnd[2]));
    FDRE # (.INIT(1'b0)) Q3_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[2]), .Q(rnd[3]));
    FDRE # (.INIT(1'b0)) Q4_FF (.C(clk), .R(1'b0), .CE(CE), .D(rnd[3]), .Q(rnd[4]));
    
    wire [1:0] out;
        //inp = 0
        //inp = 1
    assign out = ({~inp, inp} & 2'b01) | ({~inp, inp} & 2'b10);
    
    assign Q[8:7] = out;
    assign Q[6:5] = 2'b0;
    assign Q[4:0] = rnd[4:0];
    
endmodule
