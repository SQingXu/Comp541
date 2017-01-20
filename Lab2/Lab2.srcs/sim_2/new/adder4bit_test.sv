module adder4bit_test();

  logic [3:0] A;
  logic [3:0] B;
  logic Cin;
  wire [3:0] Sum;
  wire Cout;
  
  adder4bit my4bitadder(A, B, Cin, Sum, Cout);
  integer i;
  
  initial begin
    A = 0;
    B = 0;
    Cin = 0;
    
    #10;
    for (i = 0; i < 2; i= i+1)
    begin
    #1 A = A + 1; B = B + 2; 
    end
    
    #5 $finish;
  end

endmodule