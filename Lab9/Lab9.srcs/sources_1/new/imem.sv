`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Siqing XU
// 
// Create Date: 03/25/2017 10:21:33 PM
// Design Name: 
// Module Name: ram
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


module imem#(
     parameter Nloc = 64,
     parameter Dbits = 32,
     parameter initfile = "mem_data.txt"
    )(
     input wire [31: 0] addr,
     output logic [Dbits-1 : 0] dout
    );
    
    logic [Dbits-1 : 0] mem [Nloc-1:0];
    initial $readmemh(initfile, mem, 0, Nloc-1);
    
    assign dout = mem[addr[31:2]];
endmodule