`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 10/2/2015 
//
//////////////////////////////////////////////////////////////////////////////////

module displaydriver_10x4_test();

   // Inputs
   logic clk;

   // Outputs
   wire [3:0] red;
   wire [3:0] green;
   wire [3:0] blue;
   wire hsync;
   wire vsync;
 
   // Instantiate the Unit Under Test (UUT)
   vgadisplaydriver uut (.*);

   initial begin      // Generate clock
      clk = 1;
      forever
         #5 clk = ~clk;
   end
   
   initial begin
      #4000 $finish;
   end
      
   //initial begin
   //   $monitor("#%05d {hsync, vsync, red, green, blue} <= {2'b%b%b, 4'd%d, 4'd%d, 4'd%d};", $time, hsync, vsync, red, green, blue);
   //end
   
   selfcheck c();
   wire ERROR_hsync = (hsync != c.hsync)? 1'bx : 1'b0;
   wire ERROR_vsync = (vsync != c.vsync)? 1'bx : 1'b0;
   wire ERROR_red   = (red != c.red)? 1'bx : 1'b0;
   wire ERROR_green = (green != c.green)? 1'bx : 1'b0;
   wire ERROR_blue  = (blue != c.blue)? 1'bx : 1'b0;
   
endmodule


module selfcheck();
   logic hsync, vsync;
   logic [3:0] red, green, blue;
   initial begin
      fork
      #0000 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #0030 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 1, 4'd 0, 4'd 0};
      #0070 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 2, 4'd 4, 4'd 0};
      #0110 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 3, 4'd 4, 4'd 0};
      #0150 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 4, 4'd 8, 4'd 0};
      #0190 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 5, 4'd 8, 4'd 0};
      #0230 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 6, 4'd12, 4'd 0};
      #0270 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 7, 4'd12, 4'd 0};
      #0310 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 8, 4'd 0, 4'd 0};
      #0350 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 9, 4'd 0, 4'd 0};
      #0390 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #0430 {hsync, vsync, red, green, blue} <= {2'b01, 4'd 0, 4'd 0, 4'd 0};
      #0510 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #0550 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 1, 4'd 2};
      #0590 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 1, 4'd 1, 4'd 2};
      #0630 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 2, 4'd 5, 4'd 2};
      #0670 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 3, 4'd 5, 4'd 2};
      #0710 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 4, 4'd 9, 4'd 2};
      #0750 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 5, 4'd 9, 4'd 2};
      #0790 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 6, 4'd13, 4'd 2};
      #0830 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 7, 4'd13, 4'd 2};
      #0870 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 8, 4'd 1, 4'd 2};
      #0910 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 9, 4'd 1, 4'd 2};
      #0950 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #0990 {hsync, vsync, red, green, blue} <= {2'b01, 4'd 0, 4'd 0, 4'd 0};
      #1070 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #1110 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 2, 4'd 4};
      #1150 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 1, 4'd 2, 4'd 4};
      #1190 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 2, 4'd 6, 4'd 4};
      #1230 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 3, 4'd 6, 4'd 4};
      #1270 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 4, 4'd10, 4'd 4};
      #1310 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 5, 4'd10, 4'd 4};
      #1350 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 6, 4'd14, 4'd 4};
      #1390 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 7, 4'd14, 4'd 4};
      #1430 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 8, 4'd 2, 4'd 4};
      #1470 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 9, 4'd 2, 4'd 4};
      #1510 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #1550 {hsync, vsync, red, green, blue} <= {2'b01, 4'd 0, 4'd 0, 4'd 0};
      #1630 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #1670 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 3, 4'd 6};
      #1710 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 1, 4'd 3, 4'd 6};
      #1750 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 2, 4'd 7, 4'd 6};
      #1790 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 3, 4'd 7, 4'd 6};
      #1830 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 4, 4'd11, 4'd 6};
      #1870 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 5, 4'd11, 4'd 6};
      #1910 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 6, 4'd15, 4'd 6};
      #1950 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 7, 4'd15, 4'd 6};
      #1990 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 8, 4'd 3, 4'd 6};
      #2030 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 9, 4'd 3, 4'd 6};
      #2070 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #2110 {hsync, vsync, red, green, blue} <= {2'b01, 4'd 0, 4'd 0, 4'd 0};
      #2190 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #2670 {hsync, vsync, red, green, blue} <= {2'b01, 4'd 0, 4'd 0, 4'd 0};
      #2750 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #2790 {hsync, vsync, red, green, blue} <= {2'b10, 4'd 0, 4'd 0, 4'd 0};
      #3230 {hsync, vsync, red, green, blue} <= {2'b00, 4'd 0, 4'd 0, 4'd 0};
      #3310 {hsync, vsync, red, green, blue} <= {2'b10, 4'd 0, 4'd 0, 4'd 0};
      #3350 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #3790 {hsync, vsync, red, green, blue} <= {2'b01, 4'd 0, 4'd 0, 4'd 0};
      #3870 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 0, 4'd 0, 4'd 0};
      #3950 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 1, 4'd 0, 4'd 0};
      #3990 {hsync, vsync, red, green, blue} <= {2'b11, 4'd 2, 4'd 4, 4'd 0};
      join
   end
endmodule