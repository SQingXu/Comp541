`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2017 09:13:42 PM
// Design Name: 
// Module Name: counter8digit
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


module counter8digit(
    input wire clock,
    output logic [7:0] segments,
    output logic [7:0] digitselect
    );
    logic [49:0] value;
    counter mycounter(clock,value);
    display8digit my8display(value[49:18],clock,digitselect,segments);
    
endmodule
