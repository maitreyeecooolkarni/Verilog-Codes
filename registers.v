module register (
    input  clk,
    input  reset,
    input  bit_in,
    output bit_out
);

  reg [2:0] registerone;
  parameter N = 2;
  integer i;

  always @(posedge clk) begin
    if (reset) begin
      registerone <= 3'b000;
      i <= 0;
    end
    else begin
      if (i <= N) begin
        registerone[i] <= registerone[i-1];
        registerone[0] <= bit_in;
        i <= i + 1;
      end
    end
  end

  assign bit_out = registerone[2];

endmodule
