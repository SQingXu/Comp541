`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Xu
// 
// Create Date: 02/25/2017 03:03:15 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer #(parameter N=20)(
    input wire raw,
    input wire clock,
    output logic clean = 0
    );
    
    logic [N:0] count = 0;
    always_ff @(posedge clock) begin
       count <= (raw != clean) ? count + 1 : 0;
       clean <= (count[N] == 1) ? raw:clean;
    end
    
    
    
endmodule
