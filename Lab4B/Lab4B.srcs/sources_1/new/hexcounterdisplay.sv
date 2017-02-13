`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Xu
// 
// Create Date: 02/08/2017 10:39:10 PM
// Design Name: 
// Module Name: hexcounterdisplay
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


module hexcounterdisplay(
    input wire clock,
    output logic [7:0] digitselect = ~(8'b0000_0001),
    output logic [7:0] segments
    );
    logic [31:0] value;
    counter1second clock_counter(clock,value);
    hexto7seg x_seg(value[29:26],segments);
endmodule
