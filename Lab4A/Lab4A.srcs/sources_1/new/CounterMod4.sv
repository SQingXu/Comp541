`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2017 08:52:56 PM
// Design Name: 
// Module Name: CounterMod4
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


module CounterMod4(
   input wire clock,
   input wire reset,
   output logic [1:0] value = 0
    );
    
    always_ff @(posedge clock) begin
      value <= reset ? 2'b00 : (value+1);
    end 
endmodule
