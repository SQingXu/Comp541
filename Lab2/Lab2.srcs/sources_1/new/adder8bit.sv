`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2017 09:53:05 PM
// Design Name: 
// Module Name: adder8bit
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


module adder8bit(
  input wire [7:0] A,
  input wire [7:0] B,
  input wire Cin,
  output wire [7:0] Sum,
  output wire Cout
    );
    
    wire C3;
    adder4bit A0(A[3:0],B[3:0],Cin,Sum[3:0],C3);
    adder4bit A1(A[7:4],B[7:4], C3, Sum[7:4], Cout);
    
endmodule
