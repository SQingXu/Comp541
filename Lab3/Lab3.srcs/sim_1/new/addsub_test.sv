`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 1/25/2017
// 
////////////////////////////////////////////////////////////////////////////////

module addsub_test;

   localparam N=8; 	// Try changing this to 32
    
   // Inputs
   logic [N-1:0] A;
   logic [N-1:0] B;
   logic Subtract;

   // Outputs
   wire [N-1:0] Result;
   wire FlagN, FlagC, FlagV;

   // Instantiate the Unit Under Test (UUT)
   // The parameter #(N) instantiates an N-bit addsub
   addsub #(N) uut (A, B, Subtract, Result, FlagN, FlagC, FlagV);     

   integer i;

   initial begin
      // Initialize Inputs
      A = 0;
      B = 0;
      Subtract = 0;

      // Wait 5 ns for global reset to finish
      #5;
        
      // Let us try some additions
      for(i=0; i<4; i=i+1)
      begin
        #1 A = A + 11; B = B + 15;
      end
        
      // Let us try some subtractions
      #5 Subtract = 1; A = 50; B = 10;
      for(i=0; i<4; i=i+1)
      begin
         #1 A = A - 10; B = B + 10;
      end
      
      #5 $finish;
   end
   
   initial begin
      // define time to be displayed in ns, with 2 decimals, and a width of 10 characters
      $timeformat(-9, 2, " ns", 10);
      $monitor("At time %t:  A=%d, B=%d, Subtract=%b, ToBornottoB=%b, Result=%d (%b)", 
               $time, A, B, Subtract, uut.ToBornottoB, Result, Result);
   end
   
endmodule

