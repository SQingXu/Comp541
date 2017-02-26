`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Xu
// 
// Create Date: 02/25/2017 11:50:21 PM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
    input wire BTNC,
    input wire BTNU,
    input wire BTND,
    input wire clock,
    output logic [7:0] segments,
    output logic [7:0] digitselect
    );
    logic clean_BTNC, clean_BTNU, clean_BTND;
    logic [2:0] Input;
    logic [49:0] count;
    logic [1:0] Output;
    
    debouncer d1(BTNC,clock,clean_BTNC);
    debouncer d2(BTNU,clock,clean_BTNU);
    debouncer d3(BTND,clock,clean_BTND);
    
    assign Input = {clean_BTND, clean_BTNC, clean_BTNU};
    fsm myfsm(clock, Input, Output);
    updowncounter mycounter(clock,Output[1],Output[0],count);
    display8digit my8display(count[49:18],clock,digitselect,segments);
    
endmodule
