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
      parameter Nloc = 32,
      parameter Dbits = 32
    )(
      input wire clock,
      input wire reset,
      input wire [1:0] asel,
      input wire sext,bsel,
      input wire [4:0] alufn,
      input wire werf,
      input wire [1:0] pcsel,
      input wire [1:0] wasel,
      input wire [1:0] wdsel,
      input wire [Dbits-1 :0] mem_readdata,
      input wire [31:0] instr,
      
      output logic [31:0] pc = 0,
      output wire [Dbits-1 :0] mem_writedata,
      output wire [Dbits-1 :0] mem_addr,
      output wire Z
    );
      logic [$clog2(Nloc)-1:0] ReadAddr1, ReadAddr2, WriteAddr;
      assign ReadAddr1 = instr[25:21];
      assign ReadAddr2 = instr[20:16];
      logic [Dbits-1 : 0] ReadData1, ReadData2, alu_result;
      logic [Dbits-1 : 0] AluDataA, AluDataB;
      logic [Dbits-1 : 0] imme;
      //immediate
      always_comb
        case(sext)
          1'b1: imme <= {{16{instr[15]}},instr[15:0]};
          1'b0: imme <= {16'b0,instr[15:0]};
          default: imme <= {16'b0,instr[15:0]};
        endcase
      //AluDataA
      always_comb
        case(asel)
          2'b00: AluDataA <= ReadData1; //Rs
          2'b01: AluDataA <= instr[10:6];
          2'b10: AluDataA <= 16; 
          default: AluDataA <= 0;
        endcase
      //AluDataB
      always_comb
        case(bsel)
          1'b0: AluDataB <= ReadData2;
          1'b1: AluDataB <= imme;
          default: AluDataB <= 0;
        endcase
      
      //PC
      logic [31:0] pcPlus4;
      assign pcPlus4 = pc + 4;
      always_ff @(posedge clock) begin
        if(reset)
           pc <= 0;
        else
           case(pcsel)
             2'b00: pc <= pcPlus4; //Normal
             2'b01: pc <= pcPlus4 + {{14{instr[15]}},instr[15:0],2'b0}; //BT
             2'b10: pc <= {pcPlus4[31:28],instr[25:0],2'b0}; //J
             2'b11: pc <= ReadData1; //JR
             default: pc <= 0;
           endcase
      end
      
      logic [Dbits-1:0] reg_writedata;
      //reg_writedata
      always_comb
        case(wdsel)
           2'b10: reg_writedata <= mem_readdata;
           2'b01: reg_writedata <= alu_result;
           2'b00: reg_writedata <= pcPlus4;
           default: reg_writedata <= 0;
        endcase
      
       //reg_writeaddr
      always_comb
        case(wasel)
           2'b00: WriteAddr <= instr[15:11];
           2'b01: WriteAddr <= instr[20:16];
           2'b10: WriteAddr <= 31;
           default: WriteAddr <= 0;
        endcase
      
      assign mem_writedata = ReadData2;
      assign mem_addr = alu_result;
      register #(Nloc, Dbits, "mem_data.txt") my_register(clock, werf,ReadAddr1,ReadAddr2,
      WriteAddr,reg_writedata,ReadData1,ReadData2);
      ALU #(Dbits) my_alu(AluDataA, AluDataB, alufn, alu_result, Z);
      
endmodule
