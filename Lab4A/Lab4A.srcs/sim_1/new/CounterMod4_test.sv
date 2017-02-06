////////////////////////////////////////////////////////////////////////////////
// Montek Singh
// Feb 2, 2016
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module CounterMod4_test;

    // Inputs to uut
    logic clock;
    logic reset;

    // Outputs of uut
    wire [1:0] value;

    // Instantiate the Unit Under Test (UUT)
    CounterMod4 uut (
        .clock(clock), 
        .reset(reset), 
        .value(value)
    );

    integer i;

    initial begin
        
        // Initialize Inputs
        clock = 0;
        reset = 0;

        // Wait 5 ns before starting
        #5;
      
        // Let us count for 5 clock cycles
        // Each clock cycle is 2ns (1ns high and 1ns low)
        for(i=0; i<5; i=i+1) begin
          #1 clock = ~clock;
          #1 clock = ~clock;
        end
        
        // Reset the counter
        reset = 1; 
        #1 clock = 1;
        #1 reset = 0; clock = 0; 

        // Let us count again 3 clock cycles
        for(i=0; i<3; i=i+1) begin
          #1 clock = ~clock;
          #1 clock = ~clock;
        end
        
        #2 $finish;
        
    end
      
endmodule

