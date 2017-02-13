`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.sv"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2017 04:20:49 PM
// Design Name: 
// Module Name: vgadisplaydriver
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


module vgadisplaydriver(
    input wire clock,
    output wire [3:0] red,green,blue,
    output wire hsync, vsync
    );
    
    wire [`xbits - 1:0] x;
    wire [`ybits - 1:0] y;
    wire activevideo;
    
    vgatimer  myvgatimer(clock, hsync, vsync, activevideo, x, y);
    
    assign red[3:0] = (activevideo == 1) ? (x/4)%16 : 4'b0;
    assign green[3:0] = (activevideo == 1) ? (y/4)%16 :4'b0;
    assign blue[3:0] = (activevideo == 1) ? ((x/4)%16 + (y/4)%16): 4'b0;
endmodule
