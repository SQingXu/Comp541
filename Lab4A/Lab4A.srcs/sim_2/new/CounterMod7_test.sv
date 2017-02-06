////////////////////////////////////////////////////////////////////////////////
// Montek Singh
// Feb 2, 2016
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module CounterMod7_test;

    // Inputs to uut
    logic clock;
    logic reset;

    // Outputs of uut
    wire [2:0] value;

    // Instantiate the Unit Under Test (UUT)
    CounterMod7 uut (
        .clock(clock), 
        .reset(reset), 
        .value(value)
    );

    integer i;

    initial begin
        
        // Initialize Inputs
        clock = 0;
        reset = 0;

        // Wait 2 ns and then reset the counter
        #1 reset = 1;
        #1 clock = 1;
        #1 reset = 0; clock = 0; 
      
        // Let us count for 8 clock cycles
        // Each clock cycle is 2ns (1ns high and 1ns low)
        for(i=0; i<8; i=i+1) begin
          #1 clock = ~clock;
          #1 clock = ~clock;
        end
        
        // Wait 2 ns and then reset the counter
        reset = 1;
        #1 clock = 1;
        #1 reset = 0; clock = 0; 

        // Let us count again 2 clock cycles
        for(i=0; i<2; i=i+1) begin
          #1 clock = ~clock;
          #1 clock = ~clock;
        end
        
        #2 $finish;
        
    end
      
endmodule
