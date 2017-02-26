`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2017 11:40:51 PM
// Design Name: 
// Module Name: updowncounter
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


module updowncounter(
    input wire clock,
    input wire direction,//0 is up, 1 is down
    input wire paused, //0 is going, 1 is paused
    output logic [49:0] count = 0
    );
    
    always_ff @(posedge clock) begin
       count <= (paused == 1)? count:
                ((direction == 0)? count + 1: count - 1);      
    end
endmodule
