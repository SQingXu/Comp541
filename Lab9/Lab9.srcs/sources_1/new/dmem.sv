`default_nettype none
`timescale 1ns / 1ps
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


module dmem#(
     parameter Nloc = 64,
     parameter Dbits = 32,
     parameter initfile = "mem_data.txt"
    )(
     input wire clock,
     input wire wr,
     input wire [31: 0] addr,
     
     input wire [Dbits-1: 0] din,
     output logic [Dbits-1 : 0] dout
    );
    
    logic [Dbits-1 : 0] mem [Nloc-1:0]; 
    initial $readmemh(initfile, mem, 0, Nloc-1);
    
    always_ff @(posedge clock) begin
       if(wr)
          mem[addr[31:2]] <= din;
    end 
    
    assign dout = mem[addr[31:2]];
endmodule
