`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2017 02:41:57 PM
// Design Name: 
// Module Name: seebounce
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


module seebounce(
    input wire X,
    input wire clock,
    output logic [7:0] segments,
    output logic [7:0] digitselect
    );
    
    logic [31:0] numBounce = 0;
    always_ff @(posedge X) begin
      numBounce <= numBounce + 1'b1;
    end
    
    display8digit mydisplay8(numBounce,clock,digitselect,segments);
    
endmodule
