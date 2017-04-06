//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/22/2016 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module datapath_test;


   parameter Abits = 5;        // Number of bits in register address
   parameter Dbits = 32;       // Number of bits in data (regs, ALU)
   parameter Nloc = 32;        // Number of registers 
   
   // Inputs
   logic clock;
   logic WR;
   logic [Abits-1:0] RA1;
   logic [Abits-1:0] RA2;
   logic [Abits-1:0] WA;
   logic [4:0] ALUFN;
   logic [Dbits-1:0] WD;

   // Outputs
   wire [Dbits-1:0] RD1;
   wire [Dbits-1:0] RD2;
   wire [Dbits-1:0] ALUResult;
   wire FlagZ;

   // Instantiate the Unit Under Test (UUT)
   datapath #(Abits, Dbits, Nloc) uut(
      .clock(clock), 
      .RegWrite(WR), 
      .ReadAddr1(RA1), 
      .ReadAddr2(RA2), 
      .WriteAddr(WA), 
      .ALUFN(ALUFN), 
      .WriteData(WD), 
      .ReadData1(RD1), 
      .ReadData2(RD2), 
      .ALUResult(ALUResult), 
      .FlagZ(FlagZ)
   );

   initial begin
      // Initialize Inputs
      clock = 0;
      WR = 0;
      RA1 = 0;
      RA2 = 0;
      WA = 0;
      ALUFN = 0;
      WD = 0;

        
      // Add stimulus here
      // Inputs change every 1 ns, going from 000 to 111
      `define ADD 5'b0xx01
      `define SUB 5'b1xx01
      `define SLL 5'bx0010
      `define SRL 5'bx1010
      `define SRA 5'bx1110
      `define AND 5'bx0000
      `define OR  5'bx0100
      `define XOR 5'bx1000
      `define NOR 5'bx1100
      `define LT  5'b1x011
      `define LTU 5'b1x111

      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd0,5'd0,5'd0,`ADD,32'd5};  // store 5 in reg 0
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd0,5'd0,5'd1,`ADD,32'd1};  // store 1 in reg 1
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd0,5'd1,5'd2,`ADD,32'd7};  // compute 0+1=1, 7 in reg 2
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd2,5'd1,5'd3,`ADD,32'd11};  // compute 7+1=8, 11 in reg 3
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd2,5'd3,5'd4,`ADD,32'd3};  // compute 7+11=18, 3 in reg 4
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd3,5'd5,`SUB,32'd8};  // compute 3-11=-8, 8 in reg 5
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd5,5'd3,5'd6,`XOR,32'd40};  // compute 8^11=3, 40 in reg 6
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd3,5'd7,`SLL,32'd4};  // compute B<<A, 11<<3=88, 4 in reg 7
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd6,5'd8,`SRL,32'hFFFF_FF00};  // compute 40>>3=5, -256 in reg 8
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd4,5'd8,5'd9,`SRA,32'h0000_FFFF};  // compute -256>>>3=-32, 0000FFFF in reg 9
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd9,5'd8,5'd10,`AND,32'd10};  // compute FFFFFF00 & 0000FFFF, 10 in reg 10
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd8,5'd9,5'd11,`OR,32'd16};  // compute FFFFFF00 | 0000FFFF, 16 in reg 11
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd9,5'd8,5'd12,`NOR,32'hFFFF_FFF0}; // compute ~(FFFFFF00 | 0000FFFF), -16 in reg 12
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd11,5'd13,`LT,32'd0};  // compute 10 LT 16?, 0 in reg 13
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd11,5'd10,5'd14,`LT,32'd0};  // compute 16 LT 10?, 0 in reg 14
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd11,5'd15,`LTU,32'd0}; // compute 10 LTU 16?, 0 in reg 15
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd12,5'd16,`LT,32'd0}; // 10 LT 32'hFFFFFFF0 (-16), 0 in reg 16
      #1 {WR,RA1,RA2,WA,ALUFN,WD} = {1'b1,5'd10,5'd12,5'd17,`LTU,32'd0};  // 10 LTU 32'hFFFFFFF0 (big +ve number), 0 in reg 17
      
            
      // Wait another 1 ns, and then finish simulation
      #1 $finish;
   end
   
   initial begin
      #0.5 clock = 0;
      forever
         #0.5 clock = ~clock;
   end
   

   // SELF-CHECKING CODE
   
   selfcheck c();  // c(checker_RD1, checker_RD2, checker_ALUResult, checker_FlagZ);
   
   wire ERROR = ERROR_RD1 | ERROR_RD2 | ERROR_ALUResult | ERROR_FlagZ;
   wire ERROR_RD1 = (RD1 != c.RD1)? 1'bX : 1'b0;
   wire ERROR_RD2 = (RD2 != c.RD2)? 1'bX : 1'b0;
   wire ERROR_ALUResult = (ALUResult != c.ALUResult)? 1'bX : 1'b0;
   wire ERROR_FlagZ = (FlagZ != c.FlagZ)? 1'bX : 1'b0;


   //initial begin
   //   $monitor("#%5d {RD1, RD2, ALUResult, FlagZ} <= {32'h%h, 32'h%h, 32'h%h, 1'b%b};", $time, RD1, RD2, ALUResult, FlagZ);
   //end
   
endmodule


// CHECKER MODULE
module selfcheck();
   logic [31:0] RD1, RD2;
   logic [31:0] ALUResult;
   logic FlagZ;
      
   initial begin
      fork
         #0 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000000, 32'h00000000, 32'h00000000, 1'b1};
         #3 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000000, 32'h00000001, 32'h00000001, 1'b0};
         #4 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000007, 32'h00000001, 32'h00000008, 1'b0};
         #5 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000007, 32'h0000000b, 32'h00000012, 1'b0};
         #6 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'h0000000b, 32'hfffffff8, 1'b0};
         #7 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000008, 32'h0000000b, 32'h00000003, 1'b0};
         #8 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'h0000000b, 32'h00000058, 1'b0};
         #9 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'h00000028, 32'h00000005, 1'b0};
         #10 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000003, 32'hffffff00, 32'hffffffe0, 1'b0};
         #11 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000ffff, 32'hffffff00, 32'h0000ff00, 1'b0};
         #12 {RD1, RD2, ALUResult, FlagZ} <= {32'hffffff00, 32'h0000ffff, 32'hffffffff, 1'b0};
         #13 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000ffff, 32'hffffff00, 32'h00000000, 1'b1};
         #14 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'h00000010, 32'h00000001, 1'b0};
         #15 {RD1, RD2, ALUResult, FlagZ} <= {32'h00000010, 32'h0000000a, 32'h00000000, 1'b1};
         #16 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'h00000010, 32'h00000001, 1'b0};
         #17 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'hfffffff0, 32'h00000000, 1'b1};
         #18 {RD1, RD2, ALUResult, FlagZ} <= {32'h0000000a, 32'hfffffff0, 32'h00000001, 1'b0};
      join
   end
endmodule

