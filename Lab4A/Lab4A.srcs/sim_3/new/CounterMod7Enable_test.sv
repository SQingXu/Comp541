`timescale 1ns / 1ps
`default_nettype none

module CounterMod7Enable_test;

    // Inputs to uut
    logic clock;
    logic reset;
    logic enable;

    // Outputs of uut
    wire [2:0] value;

    // Instantiate the Unit Under Test (UUT)
    CounterMod7Enable uut (
        .clock(clock), 
        .reset(reset), 
        .enable(enable), 
        .value(value)
    );

    integer i;

    initial begin
        clock = 0;
        // Each clock cycle is 2ns (1ns high and 1ns low)
        for(i=0; i<12; i=i+1) begin
          #1 clock = ~clock;
          #1 clock = ~clock;
        end
        #2 $finish;
    end
    
    initial begin
        reset = 1;  // Reset the counter in the beginning
        #2 reset = 0;
        #12 reset = 1; // Reset counter again
        #2 reset = 0;
    end

    initial begin
        enable = 1;
        # 12 enable = 0;
        # 6 enable = 1;
    end
    
endmodule
