module comparator (
    input  A,
    input  B,
    output less,
    output equal,
    output greater
);

assign less    = (A < B);
assign equal   = (A == B);
assign greater = (A > B);

endmodule

module tb_comparator;

  reg A, B;        
  wire less,greater,equal;        


  comparator dut (
    .A(A),
    .B(B),
    .less(less),
    .greater(greater),
    .equal(equal)
    
  );

  initial begin 
    $monitor("Time=%0t  A=%b B=%b  less=%b greater=%b equal=%b", $time, A, B, less,greater,equal);

  
    A = 0; B = 0;
    #10 A = 0; B = 1;
    #10 A = 1; B = 0;
    #10 $finish;
  end

endmodule

