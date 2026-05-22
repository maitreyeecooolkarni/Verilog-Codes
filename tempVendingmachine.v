module vendingmachine (
    input        clk,
    input        P,
    input        rst,
    input        z1,
    input        z2,
    input  [2:0] C,
    output reg   y1,
    output reg   y2,
  output reg[2:0]change
);

  reg [1:0] state;
  reg [1:0] nextstate;
  reg [2:0] productcost;
  reg [2:0] nxtstateR;
  reg [2:0] moneycheck;
  reg [2:0] nxtstateM;
  
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;

  parameter R1 = 3'b010;  //2 rupees
  parameter R2 = 3'b101;  //5 rupees
  parameter R0 = 3'b000;

  // Sequential block
  always @(posedge clk) begin
    if (rst)
      state <= S0;
    else
      state <= nextstate;

    productcost <= nxtstateR;
    moneycheck  <= nxtstateM;
  end

  // Combinational block
  always @(*) begin
    nextstate  = state;
    nxtstateR = productcost;
    nxtstateM = moneycheck;
    y1 = 1'b0;
    y2 = 1'b0;
    change = 3'b000;

    case (state)
      S0: begin
        if (P)
          nextstate = S1;
      end

      S1: begin
        if (z1) begin
          nxtstateR = R1;
          nextstate = S2;
        end
        else if (z2) begin
          nxtstateR = R2;
          nextstate = S2;
        end
        else begin
          nxtstateR = R0;
          nextstate = S0;
        end
      end

      S2: begin
        case (productcost)
          R1: begin
            if (C >= R1) begin
              nxtstateM = C;
              nextstate = S3;
            end
          end

          R2: begin
            if (C >= R2) begin
              nxtstateM = C;
              nextstate = S3;
            end
          end
        endcase
      end

      S3: begin
        case (productcost)
          R1: begin
            change = moneycheck - R1;
            y1 = 1'b1;
          end
          R2:begin 
            change = moneycheck - R2;
            y2 = 1'b1;
          end
        endcase
        nextstate = S0;
      end

      default: begin
        nextstate = S0;
      end

    endcase
  end
endmodule

//State 1 - IDLE(Vending machine does nothing
//State 2- P is the input to start the machine
//State 3 - checks the money recieved as input
//State 4 - Returns money
