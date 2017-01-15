`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2017 10:38:41 AM
// Design Name: 
// Module Name: halfadder_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module halfadder_test();

    logic A;
    logic B;
    logic Cin;
    wire Sum;
    
    halfadder myhalfadder(A, B, Cin, Sum);
    
    initial begin
    // Initialize Inputs
        A = 0;
        B = 0;
        Cin = 0;
    // Wait, say, 10 ns before inputs start changing
        #10;
    
    // Add stimulus here
    // Inputs change every 1 ns, going from 000 to 111
        #1 {A, B, Cin} = 3'b001;
        #1 {A, B, Cin} = 3'b010;
        #1 {A, B, Cin} = 3'b011;
        #1 {A, B, Cin} = 3'b100;
        #1 {A, B, Cin} = 3'b101;
        #1 {A, B, Cin} = 3'b110;
        #1 {A, B, Cin} = 3'b111;
    // Wait another 5 ns, and then finish simulation
        #5 $finish;
    end
    
endmodule
