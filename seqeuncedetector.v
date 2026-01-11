//Sequence Detector 0110 mealy machine

module seqdetect (
    input        x,
    input        clk,
    output reg   out
);

  reg [1:0] state;
  reg [1:0] nextstate;

  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;

  // Sequential block (state register)
  always @(posedge clk) begin
    state <= nextstate;
  end

  // Combinational block (next-state and output logic)
  always @(*) begin
    case (state)

      S0: begin
        if (!x)
          nextstate = S1;
        else
          nextstate = S0;
        out = 1'b0;
      end

      S1: begin
        if (x)
          nextstate = S2;
        else
          nextstate = S1;
        out = 1'b0;
      end

      S2: begin
        if (x)
          nextstate = S3;
        else
          nextstate = S1;
        out = 1'b0;
      end

      S3: begin
        if (!x) begin
          nextstate = S1;
          out = 1'b1;
        end else begin
          nextstate = S0;
          out = 1'b0;
        end
      end

      default: begin
        nextstate = S0;
        out = 1'b0;
      end

    endcase
  end

endmodule

//Testbench

`timescale 1ns/1ps

module tb_seqdetect;

  reg        clk = 1'b0;
  reg        x   = 1'b0;
  wire       out;

 
  seqdetect dut (
    .x   (x),
    .clk (clk),
    .out (out)
  );


  always #5 clk = ~clk;

  initial begin
    $monitor("time=%0t | x=%b | state=%b | out=%b",
              $time, x, dut.state, out);

    @(posedge clk) x = 1'b1;
    @(posedge clk) x = 1'b1;
    @(posedge clk) x = 1'b0;
    @(posedge clk) x = 1'b1;
    @(posedge clk) x = 1'b1;
    @(posedge clk) x = 1'b0;
    @(posedge clk) x = 1'b1;
    
  end
