// Vending Machine

// Vending Machine
module vendingmachine (
    input        clk,
    input        P,
    input        rst,
    input        z1,
    input        z2,
    input  [2:0] C,
    output reg   y1,
    output reg   y2
);

  reg [1:0] state;
  reg [1:0] nextstate;
  reg [2:0] productcost;
  reg [2:0] nxtstateR;

  parameter S0 = 2'b00;  // idle state
  parameter S1 = 2'b01;  // product selection state
  parameter S2 = 2'b10;  // coin acceptance state

  parameter R1 = 3'b010; // 2 rupees
  parameter R2 = 3'b101; // 5 rupees
  parameter R0 = 3'b000; // 5 rupees

  // Sequential block
  always @(posedge clk) begin
    if(rst)
      state<=S0;
    else
    state       <= nextstate;
    productcost <= nxtstateR;
  end

  // Combinational block
  always @(*) begin
    nextstate  = state;
    nxtstateR = productcost; //Default is added else a latch will be inferred
    y1 = 1'b0;
    y2 = 1'b0;

    case (state)

      S0: begin
        if (P)
          nextstate = S1;
      end  //No need to write S0 as already adressed in default
        

      S1: begin
        if (z1) begin
          nxtstateR = R1;
          nextstate = S2;
       end 
        else begin
          nextstate = S0;
        end
        if (z2) begin
          nxtstateR = R2;
          nextstate = S2;
        end 
        else begin
          nextstate = S0;
          nxtstateR = R0;
        end
      end   
      S2: begin
        case (productcost)
          R1: begin
            if (C >= R1)
              y1 = 1'b1;
            nextstate = S0;
          end

          R2: begin
            if (C >= R2)
              y2 = 1'b1;
            nextstate = S0;
          end
        endcase
      end

      default: begin
        nextstate = S0;
      end

    endcase
  end

endmodule


//Testbench
`timescale 1ns/1ps

module tb_vendingmachine;

  reg        clk = 1'b0;
  reg        P   = 1'b0;
  reg        z1  = 1'b0;
  reg        z2  = 1'b0;
  reg [2:0]  C   = 3'b000;
  reg rst = 1'b0;

  wire y1;
  wire y2;

  vendingmachine dut (
    .P   (P),
    .clk (clk),
    .C   (C),
    .y1  (y1),
    .y2  (y2),
    .z1  (z1),
    .z2  (z2),
    .rst (rst)
  );

  always #5 clk = ~clk;

initial begin
  $monitor(
    "t=%0t  | Product1=%b Product2=%b | State=%b | Dispense1=%b Dispense2=%b",
    $time, z1, z2, dut.state, y1, y2
  );
  @(posedge clk) P  = 1'b1;
  @(posedge clk) z1 = 1'b1;
  @(posedge clk) C  = 3'b010;
  
  
  @(posedge clk) P  = 1'b1;
  @(posedge clk) z2 = 1'b1;
  @(posedge clk) C  = 3'b101;
  
  
  #10 $finish;
end
endmodule
//will add more like give spare change and get a better verification where all inputs are checked

