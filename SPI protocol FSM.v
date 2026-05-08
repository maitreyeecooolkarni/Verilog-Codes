// SPI communication

module SPI(
    CS,
    clk,
    MOSI,
    MISO,
    out1,
    out2,
    reset,
);
    input reset;
    output reg CS;

    input clk;

    input [7:0] MOSI;
    input [7:0] MISO;

    output reg out1, out2;

    reg nxtout1, nxtout2;

    reg [3:0] state;
    reg [3:0] nextstate;


    parameter idle = 4'b0000;
    parameter bit1 = 4'b0001;
    parameter bit2 = 4'b0010;
    parameter bit3 = 4'b0011;
    parameter bit4 = 4'b0100;
    parameter bit5 = 4'b0101;
    parameter bit6 = 4'b0110;
    parameter bit7 = 4'b0111;
    parameter bit8 = 4'b1000;
    parameter stop = 4'b1001;


    // Sequential state update
  always @(posedge clk or posedge reset) begin
        if(reset)
           state<=4'b0000;
        else
           state <= nextstate;

           out1 <= nxtout1;
           out2 <= nxtout2;
    end


    // Combinational next-state logic
    always @(*) begin

        case(state)

            idle: begin
                CS = 0;
                nextstate = bit1;
                nxtout1 = 0;
                nxtout2 = 0;
            end

            bit1: begin
                nxtout1 = MISO[0];
                nxtout2 = MOSI[0];
                nextstate = bit2;
            end

            bit2: begin
                nxtout1 = MISO[1];
                nxtout2 = MOSI[1];
                nextstate = bit3;
            end

            bit3: begin
                nxtout1 = MISO[2];
                nxtout2 = MOSI[2];
                nextstate = bit4;
            end

            bit4: begin
                nxtout1 = MISO[3];
                nxtout2 = MOSI[3];
                nextstate = bit5;
            end

            bit5: begin
                nxtout1 = MISO[4];
                nxtout2 = MOSI[4];
                nextstate = bit6;
            end

            bit6: begin
                nxtout1 = MISO[5];
                nxtout2 = MOSI[5];
                nextstate = bit7;
            end

            bit7: begin
                nxtout1 = MISO[6];
                nxtout2 = MOSI[6];
                nextstate = bit8;
            end

            bit8: begin
                nxtout1 = MISO[7];
                nxtout2 = MOSI[7];
                nextstate = stop;
            end

            stop: begin
                CS = 1;
                nextstate = idle;
            end

        endcase

    end

endmodule
