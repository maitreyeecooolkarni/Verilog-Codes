module accumulator(LdA,clr,in1,clk);
  input LdA;
  input clr,clk;
  input [1:0]in1;
  
  wire [1:0] X,Z;  //X is reg output Z is adder output
  module accumalator(LdA,clr,in1,clk);
  input LdA;
  input clr,clk;
  input [1:0]in1;
  
  wire [1:0] X,Z;  //X is reg output Z is adder output
  
    //data_in is basically the input 
  
  //PIPOA(Dout,Din,clr,ld)
  PIPOA A(X,Z,clr,LdA,clk);
  //ADD(Output,input1,input2)
  ADD AD(Z,in1,X);
endmodule

module PIPOA(dout,din,clr,ld,clk);
  input [1:0] din;
  input clk,clr,ld;
  output reg [1:0]dout;
  
  always@(posedge clk)
    begin
    if(clr)
      dout<=2'b00;
  else if(ld)
     dout<=din;
    end
endmodule


module ADD(out,in1,in2);
  input [1:0]in1,in2;
  output [1:0] out;
  
  assign out=in1+in2;
  
endmodule

module controller(LdA,clr,clear);
  input clear,clk;
  output reg LdA,clr;
  
  always@(*)
    begin
      if(clear)begin
      LdA=0;clr=1;
      end
    else
      begin
      LdA=1;clr=0;
      end
    end
endmodule

    //data_in is basically the input 
  

  PIPOA A(X,Z,clr,LdA,clk);

  ADD AD(Z,in1,X);
endmodule

module PIPOA(dout,din,clr,ld,clk);
  input [1:0] din;
  input clk,clr,ld;
  output reg [1:0]dout;
  
  always@(posedge clk)
    begin
    if(clr)
      dout<=2'b00;
  else if(ld)
     dout<=din;
    end
endmodule


module ADD(out,in1,in2);
  input [1:0]in1,in2;
  output [1:0] out;
  
  assign out=in1+in2;
  
endmodule

module controller(LdA,clr,clear);
  input clear;
  output reg LdA,clr;
  
  always@(*)
    begin
      if(clear)begin
      LdA=0;clr=1;
      end
    else
      begin
      LdA=1;clr=0;
      end
    end
endmodule
