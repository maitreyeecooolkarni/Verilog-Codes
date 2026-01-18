// Repeated Addition, Datapath module
module datapath(LdA,LdB,LdP,clrP,eqz,decB,clk,data_in);
  input LdA, LdB, LdP, clrP, decB, clk;
  input  [1:0] data_in;
  output eqz;

  wire [1:0] X, Y, Z, Bus, Bout;

  assign Bus = data_in;

  PIPO1 A (X, Bus, LdA, clk);
  CNTR  B (Bout, Bus, LdB, decB, clk);
  PIPO2 P (Y, Z, LdP, clrP, clk);
  ADD   AD (X, Y, Z);
  EQZ   C  (eqz, Bout);
endmodule


module PIPO1(dout,din,ld,clk);
  input [1:0] din;
  input ld, clk;
  output reg [1:0] dout;

  always @(posedge clk) begin
    if(ld)
      dout <= din;
  end
endmodule


module PIPO2(dout,din,ld,clr,clk);
  input [1:0] din;
  input ld, clr, clk;
  output reg [1:0] dout;

  always @(posedge clk) begin
    if(clr)
      dout <= 2'b00;
    else if(ld)
      dout <= din;
  end
endmodule


module ADD(in1,in2,out);
  input  [1:0] in1, in2;
  output [1:0] out;

  assign out = in1 + in2;
endmodule


module EQZ(equal,data);
  input  [1:0] data;
  output equal;

  assign equal = (data == 2'b00);
endmodule


module CNTR(dout,din,ld,sig,clk);
  input  [1:0] din;
  input ld, sig, clk;
  output reg [1:0] dout;

  always @(posedge clk) begin
    if(ld)
      dout <= din;
    else if(sig)
      dout <= dout - 1;
  end
endmodule

  
  
  


  
  
  
