//////////////////////////////////////////////////////////////////////////////////
// Montek Singh 
// 9/29/2015
//
// NOTE:  This tester requires the definition of the debouncer() module to be
//	changed to make the debounce interval parameterized.  In particular,
//	remove the "localparam N=20" line, and make the module parametrizable at
//	instantiation by declaring it as:
//
//		module debouncer #(parameter N=20)( // ...
//
//	For simulation purposes, N=20 is obviously too long.  Hence, the tester
//	instantiate a debouncer with N=4, so the debounce interval is only 16
//	clock ticks, not 2^20.  The debouncer's output should change on the 17th
//	clock tick once the raw input stops bouncing.
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module tester_debounce();

    // Inputs to uut
    logic clock=0;
    logic rawX=0;

    // Outputs of uut
    wire cleanX;

    // Instantiate the Unit Under Test (UUT)
    debouncer #(4) uut (
        .raw(rawX),
        .clock(clock), 
        .clean(cleanX)
    );

    initial begin       // generate the clock
        forever begin   // Each clock cycle is 1ns (0.5 ns high and 0.5 ns low)
          #0.5 clock = ~clock;
          #0.5 clock = ~clock;
        end
    end
    
    initial begin
        #100 $finish;   // terminate simulation after 100 ns
    end

    integer i;
    initial begin
        #10;
        for(i=0; i<30; i++) begin
            #0.33 rawX = $urandom_range(0,1); 	// unsigned random number from 0 to 1
        end
        #0.33 rawX = 1;
        
        #30;
        for(i=0; i<30; i++) begin
            #0.33 rawX = $urandom_range(0,1);
        end
        #0.33 rawX = 0;
    end    

endmodule
