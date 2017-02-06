`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Xu
// 
// Create Date: 02/05/2017 10:10:46 PM
// Design Name: 
// Module Name: CounterMod7
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


module CounterMod7(
    input wire clock,
    input wire reset,
    output logic [2:0] value
    );
    
    always_ff @(posedge clock) begin
      value <= reset ? 0: (value == 6)? 0:(value + 1); 
    end
endmodule
