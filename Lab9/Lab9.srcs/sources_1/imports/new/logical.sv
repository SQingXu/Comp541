`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Siqing Xu
// 
// Create Date: 01/29/2017 07:07:00 PM
// Design Name: 
// Module Name: logical
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module logical #(parameter N = 32)(
    input wire [N-1:0] A,B,
    input wire [1:0] op,
    output wire [N-1:0] R
    );
    
    assign R = (op == 2'b00) ? A & B:
               (op == 2'b10) ? A ^ B:
               (op == 2'b11) ? ~(A | B):
               (op == 2'b01) ? A | B :0;
endmodule
