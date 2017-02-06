////////////////////////////////////////////////////////////////////////////////
// Montek Singh
// Sep 14, 2016
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module xycounter_test;

   localparam width = 5, height = 3;  // You are welcome to play with these values
   // Inputs to uut
   logic clock;
   logic enable;

   // Outputs of uut
   wire [$clog2(width)-1:0] x;
   wire [$clog2(height)-1:0] y;
      
   xycounter #(width, height) uut (
      .clock(clock), .enable(enable), .x(x), .y(y)
   );

    initial begin
    #50 $finish;
    end
    
  initial begin
    clock = 0;
    // Each clock cycle is 2ns (1ns high and 1ns low)
    forever begin
      #1 clock = ~clock;
      #1 clock = ~clock;
    end
    end
    
  initial begin
    enable = 1;
    # 12 enable = 0;
    # 4 enable = 1;
  end
           
endmodule