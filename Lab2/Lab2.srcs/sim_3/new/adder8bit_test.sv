module adder8bit_test();
  logic [7:0] A;
  logic [7:0] B;
  logic Cin;
  wire [7:0] Sum;
  wire Cout;
  
  adder8bit my8bitadder(.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout)); 
  integer i; 
  initial begin
    A = 0;
    B = 0;
    Cin = 0;
    
    #10
    for (i = 0; i < 10; i = i+1)
    begin
    #1 A = A + 3; B = B + 5;
    end
    
    #5 $finish;
  end
endmodule