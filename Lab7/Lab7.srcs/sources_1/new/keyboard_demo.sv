//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 11/12/2015 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module keyboard_demo(
	input wire clock,
	input wire ps2_data,
	input wire ps2_clk,
	output wire [7:0] segments,
   	output wire [7:0] digitselect
   );

	wire [31:0] keyb_char;
 
	keyboard keyb(clock, ps2_clk, ps2_data, keyb_char);
   
	display8digit disp(keyb_char, clock, segments, digitselect);

endmodule
