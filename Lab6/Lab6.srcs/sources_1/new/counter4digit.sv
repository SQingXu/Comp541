`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Xu
// 
// Create Date: 02/21/2017 08:49:17 PM
// Design Name: 
// Module Name: counter4digit
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


module counter4digit(
   input wire clock,
   output logic [7:0] digitselect,
   output logic [7:0] segments
    );
    logic [49:0] value;
    counter mycounter(clock,value);
    display4digit my4display(value[37:22],clock,segments,digitselect);
endmodule
