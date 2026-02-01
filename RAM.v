//RAM-Random Access Memory modelling

module RAM(clk,read,data_in,data_out,adress,enable);
  input clk;   //Clk pulse when data gets stored.
  input enable;  //If high,then only read write operations 
  input reg read;  //Read function.If zero,write occurs.
  input [7:0]data_in;
  output reg [7:0]data_out; 
  input [9:0]adress;  
  
  reg[7:0]mem_block[0:1023]; //Actual memory store.
  
  always@(posedge clk)
    begin   
    if(enable)
      if(read)
        data_out<=mem_block[adress];
      else
        mem_block[adress]<=data_in;
    en`timescale 1ns/1ps

//Testbench

module RAM_tb;

  reg read;
  reg [7:0] data_in;
  reg enable;
  reg clk;
  reg [9:0] adress;

  wire [7:0] data_out;

  RAM DUT (
    .clk(clk),
    .enable(enable),
    .adress(adress),
    .data_in(data_in),
    .data_out(data_out),
    .read(read)
  );

  // clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    data_in = 0;
    adress = 0;

    $monitor("Time = %0t : clk = %b,data_in=%b,read=%b, data_out = %b",
              $time, clk,data_in,read, data_out);

    @(posedge clk) enable  = 1'b1;
    @(posedge clk) read    = 1'b1;
    @(posedge clk) data_in = 8'b11110000;
    @(posedge clk) adress  = 10'b0000001101;
    @(posedge clk) read =1'b0;
    @(posedge clk) data_in = 8'b11110000;
    @(posedge clk) read = 1'b1;

    #10 $finish;
  end

endmodule
d
endmodule

