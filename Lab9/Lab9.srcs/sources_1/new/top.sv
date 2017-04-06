`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Siqing Xu
// 
// Create Date: 04/05/2017 08:06:19 PM
// Design Name: 
// Module Name: top
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


module top#(
     parameter imem_init = "sqr_imem.mem",
     parameter dmem_init = "sqr_dmem.mem"
   )(
     input wire clk, reset
    );
    wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
    wire mem_wr;
    
    mips mips(clk, reset, pc, instr, mem_wr, mem_addr, mem_writedata, mem_readdata);
    imem #(.Nloc(64), .Dbits(32), .initfile(imem_init)) imem(pc[31:0],instr);
    dmem #(.Nloc(64), .Dbits(32), .initfile(dmem_init)) dmem(clk, mem_wr, mem_addr, mem_writedata, mem_readdata);
endmodule
