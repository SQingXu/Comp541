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


module ram#(
     parameter Nloc = 16,
     parameter Dbits = 4,
     parameter initfile = "mem_data.txt"
    )(
     input wire clock,
     input wire wr,
     input wire [$clog2(Dbits) - 1: 0] addr,
     
     input wire [Dbits-1: 0] din,
     output logic [Dbits-1 : 0] dout
    );
    
    logic [Dbits-1 : 0] mem [Nloc-1:0];
    initial $readmemh(initfile, mem, 0, Nloc-1);
    
    always_ff @(posedge clock) begin
       if(wr)
          mem[addr] <= din;
    end 
    
    assign dout = mem[addr];
endmodule
