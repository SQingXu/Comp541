`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Jordan Elliott
//////////////////////////////////////////////////////////////////////////////////


module SoundAccel(
    input wire clock, //100MHz clock
    
    //Sound
    output wire audPWM,
    output wire audEn,
    
    //Accel
    output wire aclSCK,
    output wire aclMOSI,
    input wire aclMISO,
    output wire aclSS,
    
    //Display
    output wire [7:0] segments,
    output wire [7:0] digitselect
    );
    
    wire unsigned [31:0] period;
    wire [31:0] display;
    
    //Accelerometer data
    wire [8:0] accelX, accelY;      // The accelX and accelY values are 9-bit values, ranging from 9'h 000 to 9'h 1FF
    wire [11:0] accelTmp;           // 12-bit value for temperature
        
    assign audEn = 1;
    
    //Displays x and y accel values on 7-segment display
    assign display[31:0] = {7'b0, accelX, 7'b0, accelY};

    //Period varies with Y accel (left to right)
    //Longer period means lower pitched tone
    assign period[31:0] = {11'b0, accelY, 12'b0};
    
    accelerometer accel(clock, aclSCK, aclMOSI, aclMISO, aclSS, accelX, accelY, accelTmp);
    sounds sound(clock, period, audPWM);
    display8digit d8(display, clock, segments, digitselect);
    
endmodule
