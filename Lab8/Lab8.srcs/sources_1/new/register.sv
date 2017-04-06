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


module register#(
     parameter Nloc = 16,
     parameter Dbits = 4,
     parameter initfile = "mem_data.txt"
    )(
     input wire clock,
     input wire wr,
     input wire [$clog2(Dbits) - 1: 0] ReadAddr1, ReadAddr2, WriteAddr,
     
     input wire [Dbits-1: 0] WriteData,
     output logic [Dbits-1 : 0] ReadData1, ReadData2
    );
    
    logic [Dbits-1 : 0] rf [Nloc-1:0];
    initial $readmemh(initfile, rf, 0, Nloc-1);
    
    always_ff @(posedge clock) begin
       if(wr)
          rf[WriteAddr] <= WriteData;
    end 
    
    assign ReadData1 = (ReadAddr1 == 0)? 0: rf[ReadAddr1];
    assign ReadData2 = (ReadAddr2 == 0)? 0: rf[ReadAddr2];
endmodule