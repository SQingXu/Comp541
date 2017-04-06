`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2017 11:21:22 PM
// Design Name: 
// Module Name: datapath
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


module datapath#(
      parameter Abits = 5,
      parameter Nloc = 32,
      parameter Dbits = 32
    )(
      input wire clock,
      input wire RegWrite,
      input wire [$clog2(Nloc)-1:0] ReadAddr1, ReadAddr2, WriteAddr,
      input wire [4:0] ALUFN,
      input wire [Dbits-1 : 0] WriteData,
      
      output wire [Dbits-1 : 0] ReadData1, ReadData2, ALUResult,
      output wire FlagZ
    );
    
      register #(Nloc, Dbits, "mem_data.txt") my_register(clock, RegWrite,ReadAddr1,ReadAddr2,
      WriteAddr,WriteData,ReadData1,ReadData2);
      ALU #(Dbits) my_alu(ReadData1, ReadData2, ALUFN, ALUResult, FlagZ);
      
endmodule
