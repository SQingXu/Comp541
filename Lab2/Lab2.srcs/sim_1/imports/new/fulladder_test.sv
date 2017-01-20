`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
//Siqing Xu 
// 1/10/2017
// 
//////////////////////////////////////////////////////////////////////////////////


module fullfadder_test();

    logic A;
    logic B;
    logic Cin;
    wire Sum;
    wire Cout;
    
    fulladder myfulladder(A, B, Cin, Sum, Cout);
    
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
