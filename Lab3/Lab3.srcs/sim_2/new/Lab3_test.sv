`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 9/6/2016
// 
////////////////////////////////////////////////////////////////////////////////

module Lab3_test;

   localparam width = 8;

   // Inputs
   logic [width-1:0] A;
   logic [width-1:0] B;
   logic [4:0] ALUfn;

   // Outputs
   wire [width-1:0] R;
   wire FlagN, FlagC, FlagV, FlagZ;

   // Instantiate the Unit Under Test (UUT)
   ALU #(width) uut (.A(A), .B(B), .R(R), .ALUfn(ALUfn),
      .FlagN(FlagN), .FlagC(FlagC), .FlagV(FlagV), .FlagZ(FlagZ)
        );
   
   initial begin
      // Initialize Inputs
      A = 0;
      B = 0;
      ALUfn = 0;

      // Wait 2 ns
      #2;
        
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

      #1 {A, B, ALUfn} = {8'd_10, 8'd_20, `ADD};            // 10 + 20
      #1 {A, B, ALUfn} = {8'd_100, 8'd_30, `ADD};           // 100 + 30
      #1 {A, B, ALUfn} = {8'd_10, 8'd_20, `SUB};            // 10 - 20      
      #1 {A, B, ALUfn} = {8'd_1, 8'd_1, `SUB};              // 1 - 1
      #1 {A, B, ALUfn} = {8'd_2, 8'd_20, `SLL};             // 20 << 2
      #1 {A, B, ALUfn} = {8'd_2, 8'd_20, `SRL};             // 20 >> 2
      #1 {A, B, ALUfn} = {8'd_1, 8'h_FE, `SRA};             // -2 >>> 1
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `AND};  // and
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `OR};   // or
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `XOR};  // xor
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `NOR};  // nor
                                
      // Wait another 5 ns, and then finish simulation
      #5 $finish;
   end
      
endmodule

