`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Xu
// 
// Create Date: 02/25/2017 06:32:26 PM
// Design Name: 
// Module Name: fsm
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


module fsm(
    input wire clock,
    //input wire RESET,
    input wire [2:0] pushedButton,
    output logic [1:0] Output
    );
    logic up = pushedButton[0];
    logic center = pushedButton[1];
    logic down = pushedButton[2];
    
    enum{State1, State2, State3, State4, State5, State6, State7, State8} state, next_state;
    
    always_ff @(posedge clock) begin
      state <= next_state;
    end
    
    always_comb //01 input means up pressed, 10 means pause pressed, 11 means down pressed
      case(state)
          //State1 means counting up
          State1: next_state <= (center == 1)? State2: 
                                (down == 1)? State5: State1;
          State2: next_state <= (center == 0)? State3: State2;
          State3: next_state <= (center == 1)? State4:
                                (down == 1)? State7:State3;
          State4: next_state <= (center == 0)? State1: State4;
          State5: next_state <= (center == 1)? State6:
                                (up == 1)? State1:State5;
          State6: next_state <= (center == 0)? State7: State6;
          State7: next_state <= (center == 1)? State8:
                                (up == 1)? State3: State7;
          State8: next_state <= (center == 0)? State5: State8;
          default: next_state <= State1;
       endcase
       
       always_comb
         case(state)
            State1:Output <= 2'b00;
            State2:Output <= 2'b01;
            State3:Output <= 2'b01;
            State4:Output <= 2'b00;
            State5:Output <= 2'b10;
            State6:Output <= 2'b11;
            State7:Output <= 2'b11;
            State8:Output <= 2'b10;
            default: Output <= 2'b00;
         endcase
       
    
endmodule
