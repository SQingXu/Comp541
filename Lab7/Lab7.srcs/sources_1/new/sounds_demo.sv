//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 11/18/2015 
//
// This is a quick demo to show how to use my tone generator.
//   The sound will cycle from C4 to C5, over and over, with each
//   note being played for approx 1 second.
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module sounds_demo(
    input wire clock,       // 100 MHz clock
    output wire audPWM,
    output wire audEn
    );
    
    assign audEn = 1;       // Always on; could be turned off
    
    logic [31:0] count=0;
    always_ff @(posedge clock)
        count <= count + 1;
        
    // These are periods (in units of 10 ns) for the notes on the normal C4 scale,
    //   i.e.:  C4, D4, E4, F4, G4, A4, B4, C5
    wire [31:0] notes_periods[0:7] = {382219, 340530, 303370, 286344, 255102, 227273, 202478, 191113};
    
    // cycle through note 0 to 7, over and over, in approx. 1 sec increments
    wire [2:0] note_to_play = count[29:27];
    wire [31:0] period = notes_periods[note_to_play];
    
    sounds snd(
       clock,           // 100 MHz clock
       period,          // sound period in tens of nanoseconds
                        // period = 1 means 10 ns (i.e., 100 MHz)      
       audPWM);
       
endmodule
