`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Siqing Xu
// 
// Create Date: 01/29/2017 07:17:37 PM
// Design Name: 
// Module Name: shifter
// Project Name: Lab3
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


module shifter #(parameter N = 32)(
    input wire signed [N-1:0] IN,
    input wire [$clog2(N)-1:0] shamt,
    input wire left, logical,
    output wire [N-1:0] OUT
    );
    assign OUT = left ? (IN << shamt) :
                  (logical ? IN >> shamt : IN >>> shamt);
                  
endmodule
