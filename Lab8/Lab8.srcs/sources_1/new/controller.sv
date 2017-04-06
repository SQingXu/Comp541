//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/11/2016
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

// These are non-R-type.  OPCODES defined here:

`define LW     6'b 100011
`define SW     6'b 101011

`define ADDI   6'b 001000
`define ADDIU  6'b 001001			// NOTE:  addiu *does* sign-extend the imm
`define SLTI   6'b 001010
`define SLTIU  6'b 001011
`define ORI    6'b 001101
`define LUI    6'b 001111

`define BEQ    6'b 000100
`define BNE    6'b 000101
`define J      6'b 000010
`define JAL    6'b 000011


// These are all R-type, i.e., OPCODE=0.  FUNC field defined here:

`define ADD    6'b 100000
`define SUB    6'b 100010
`define AND    6'b 100100
`define OR     6'b 100101
`define XOR    6'b 100110
`define NOR    6'b 100111
`define SLT    6'b 101010
`define SLTU   6'b 101011
`define SLL    6'b 000000
`define SLLV   6'b 000100
`define SRL    6'b 000010
`define SRA    6'b 000011
`define JR     6'b 001000  


module controller(
   input  wire [5:0] op, 
   input  wire [5:0] func,
   input  wire Z,
   output wire [1:0] pcsel,
   output wire [1:0] wasel, 
   output wire sext,
   output wire bsel,
   output wire [1:0] wdsel, 
   output logic [4:0] alufn, 			// will become wire because updated in always_comb
   output wire wr,
   output wire werf, 
   output wire [1:0] asel
   ); 

  assign pcsel = ((op == 6'b0) & (func == `JR)) ? 2'b11   // controls 4-way multiplexer
               : (op == `J | op == `JAL) ? 2'b10
               : ((op == `BEQ) & (Z == 1))|((op == `BNE) & (Z == 0)) ? 2'b01
               : 2'b00;

  logic [9:0] controls;
  assign {werf, wdsel[1:0], wasel[1:0], asel[1:0], bsel, sext, wr} = controls[9:0];

  always_comb
     case(op)                                     // non-R-type instructions
        `LW: controls <= 10'b 1_10_01_00_1_1_0;     // LW
        `SW: controls <= 10'b 0_10_01_00_1_1_1;     // SW
      `ADDI,                                        // ADDI
     `ADDIU, 
     `SLTIU,                                       // ADDIU
      `SLTI: controls <= 10'b 1_01_01_00_1_1_0;     // SLTI
       `ORI: controls <= 10'b 1_01_01_00_1_0_0;     // ORI
       `LUI: controls <= 10'b 1_01_01_10_1_x_0;
       `BNE,
       `BEQ: controls <= 10'b 0_xx_xx_00_0_1_0;
       `J:   controls <= 10'b 0_xx_xx_xx_x_x_0;
       `JAL: controls <= 10'b 1_00_10_xx_x_x_0;
      // add remaining non-R-type instructions here
      6'b000000:                                    
         case(func)                              // R-type
             `AND,
             `OR,
             `XOR,
             `NOR,
             `SLT,
             `SLTU,
             `SLLV,
             `ADD: controls <= 10'b 1_01_00_00_0_x_0; // ADD
             `SUB: controls <= 10'b 1_01_00_00_0_x_0; // SUB
             `SRL,
             `SRA,
             `SLL: controls <= 10'b 1_01_00_01_0_x_0;
             `JR:  controls <= 10'b 0_xx_xx_xx_x_x_0;
              // add remaining R-type instructions here
            default:   controls <= 10'b 0_xx_xx_xx_x_x_0; // unknown instruction, turn off register and memory writes
         endcase
      default: controls <= 10'b 0_xx_xx_xx_x_x_0;  // unknown instruction, turn off register and memory writes
    endcase
    

  always_comb
    case(op)                        // non-R-type instructions
        `LW,                          // LW
        `SW,                          // SW
      `ADDI,                          // ADDI
     `ADDIU: alufn <= 5'b 0xx01;      // ADDIU
      `SLTI: alufn <= 5'b 1x011;      // SLTI
     `SLTIU: alufn <= 5'b 1x111;
       `ORI: alufn <= 5'b x0100;
       `LUI: alufn <= 5'b x0010;
       `BEQ,                          // BEQ
       `BNE: alufn <= 5'b 1xx01;      // BNE
        // add remaining non-R-type instructions here
      6'b000000:                      
         case(func)                 // R-type
             `ADD: alufn <= 5'b 0xx01; // ADD
             `SUB: alufn <= 5'b 1xx01; // SUB
             `AND: alufn <= 5'b x0000;
             `OR:  alufn <= 5'b x0100;
             `XOR: alufn <= 5'b x1000;
             `NOR: alufn <= 5'b x1100;
             `SLT: alufn <= 5'b 1x011;
            `SLTU: alufn <= 5'b 1x111;
             `SLL: alufn <= 5'b x0010;
            `SLLV: alufn <= 5'b x0010;
             `SRL: alufn <= 5'b x1010;
             `SRA: alufn <= 5'b x1110;
              `JR: alufn <= 5'b xxxxx;
             // add remaining R-type instructions here
            default:   alufn <= 5'b xxxxx; // ???
         endcase
      default: alufn <= 5'b xxxxx;        // J, JAL
    endcase
    
endmodule
