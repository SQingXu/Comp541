`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2017 08:29:08 PM
// Design Name: 
// Module Name: mips
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


module mips(
    input wire clock,
    input wire reset,
    output wire [31:0] pc,
    input wire [31:0] instr,
    output wire mem_wr,
    output wire [31:0] mem_addr,
    output wire [31:0] mem_writedata,
    input wire [31:0] mem_readdata
    );
    wire [1:0] pcsel, wdsel,wasel;
    wire [4:0] alufn;
    wire Z, sext, bsel, dmem_wr, werf;
    wire [1:0] asel;
    
    controller c(.op(instr[31:26]), .func(instr[5:0]),.Z(Z),
                 .pcsel(pcsel),.wasel(wasel),.sext(sext),.bsel(bsel),
                 .wdsel(wdsel),.alufn(alufn),.wr(mem_wr),.werf(werf),
                 .asel(asel));
    datapath#(.Nloc(32),.Dbits(32)) dp(.clock(clock),.werf(werf),.reset(reset),
              .asel(asel),.sext(sext),.bsel(bsel),.wasel(wasel),.wdsel(wdsel),.pcsel(pcsel),
              .mem_readdata(mem_readdata),.instr(instr),.pc(pc),.alufn(alufn),
              .mem_writedata(mem_writedata),.mem_addr(mem_addr),.Z(Z));
endmodule
