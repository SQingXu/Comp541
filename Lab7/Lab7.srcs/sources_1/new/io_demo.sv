`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Siqing Xu
// 
// Create Date: 03/21/2017 09:49:03 PM
// Design Name: 
// Module Name: io_demo
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


module io_demo(
    input wire clock,
    //keyboard
    input wire ps2_clk,
    input wire ps2_data,
    
    //Sound
    output wire audPWM,
    output wire audEn,
        
    //Accel
    output wire aclSCK,
    output wire aclMOSI,
    input wire aclMISO,
    output wire aclSS,
    
    //LED
    output logic [15:0] LED

    );
    
    wire [8:0] accelX, accelY;
    wire [11:0] accelTemp;
    wire [31:0] notes_periods[0:7] = {382219, 340530, 303370, 286344, 255102, 227273, 202478, 191113};
    logic [31:0] key_char;
    wire [31:0] period;
    
    keyboard keyb(clock, ps2_clk, ps2_data, key_char);
    accelerometer accel(clock, aclSCK, aclMOSI, aclMISO, aclSS, accelX, accelY, accelTemp);
    logic [15:0] enable_char = key_char[15:0];
    logic [7:0] use_char = key_char[7:0];
    assign audEn = (enable_char == {8'b0,8'b00010101})? 1
                  :(enable_char == {8'b0,8'b00011101})? 1
                  :(enable_char == {8'b0,8'b00100100})? 1
                  :(enable_char == {8'b0,8'b00101101})? 1
                  :(enable_char == {8'b0,8'b00101100})? 1
                  :(enable_char == {8'b0,8'b00110101})? 1
                  :(enable_char == {8'b0,8'b00111100})? 1
                  :(enable_char == {8'b0,8'b01000011})? 1
                  :0; 
    
    assign period = (use_char == 8'b00010101)? notes_periods[0]
                   :(use_char == 8'b00011101)? notes_periods[1]
                   :(use_char == 8'b00100100)? notes_periods[2]
                   :(use_char == 8'b00101101)? notes_periods[3]
                   :(use_char == 8'b00101100)? notes_periods[4]
                   :(use_char == 8'b00110101)? notes_periods[5]
                   :(use_char == 8'b00111100)? notes_periods[6]
                   :(use_char == 8'b01000011)? notes_periods[7]
                   : 32'b0;
                   
    sounds snd(clock, period, audPWM);
    
    logic [3:0] selectLight = accelY[8:5];
    assign LED = 
       selectLight == 4'b0000 ? {15'b0, 1'b1}
      :selectLight == 4'b0001 ? {14'b0, 1'b1, 1'b0}
      :selectLight == 4'b0010 ? {13'b0, 1'b1, 2'b0}
      :selectLight == 4'b0011 ? {12'b0, 1'b1, 3'b0}
      :selectLight == 4'b0100 ? {11'b0, 1'b1, 4'b0}
      :selectLight == 4'b0101 ? {10'b0, 1'b1, 5'b0}
      :selectLight == 4'b0110 ? {9'b0, 1'b1, 6'b0}
      :selectLight == 4'b0111 ? {8'b0, 1'b1, 7'b0}
      :selectLight == 4'b1000 ? {7'b0, 1'b1, 8'b0}
      :selectLight == 4'b1001 ? {6'b0, 1'b1, 9'b0}
      :selectLight == 4'b1010 ? {5'b0, 1'b1, 10'b0}
      :selectLight == 4'b1011 ? {4'b0, 1'b1, 11'b0}
      :selectLight == 4'b1100 ? {3'b0, 1'b1, 12'b0}
      :selectLight == 4'b1101 ? {2'b0, 1'b1, 13'b0}
      :selectLight == 4'b1110 ? {1'b0, 1'b1, 14'b0}
      :{1'b1,15'b0} ;
    
    
endmodule
