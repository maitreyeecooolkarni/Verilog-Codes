`timescale 1ns/1ps

module tb_vendingmachine;
  reg        clk = 1'b0;
  reg        P   = 1'b0;
  reg        z1  = 1'b0;
  reg        z2  = 1'b0;
  reg [2:0]  C   = 3'b000;
  reg        rst = 1'b0;

  wire y1;
  wire y2;
  wire[2:0] change;
  

  vendingmachine dut (
    .P      (P),
    .clk    (clk),
    .C      (C),
    .y1     (y1),
    .y2     (y2),
    .z1     (z1),
    .z2     (z2),
    .rst    (rst),     
    .change (change)
  );

  always #5 clk = ~clk;

  initial begin
    $monitor(
      "t=%0t | Product1=%b Product2=%b | State=%b | Dispense1=%b Dispense2=%b CHANGE=%b C=%b",
      $time, z1, z2, dut.state, y1, y2, change,C
    );

    @(posedge clk) P  = 1'b1;
    @(posedge clk) z2 = 1'b1;
    @(posedge clk) C  = 3'b111;
    
    @(posedge clk) P  = 1'b1;
    @(posedge clk) z1 = 1'b1;
    @(posedge clk) C  = 3'b111;
    
    
    #35 $finish;
  end
endmodule
