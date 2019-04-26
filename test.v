// Floating-Point Multiplier TestBench

`timescale 1ns/10ps

module float_tb();

reg CLK, RESET;
reg [31:0] in1;
reg [31:0] in2;
wire [31:0] out;

initial begin
  RESET = 1'b1;
  CLK = 1'b0;
  #80;
  CLK = 1'b1;
  RESET = 1'b0;
  in1 = 32'b01000001010110100000000000000000;
  in2 = 32'b10111110001000000000000000000000;
  #150;
  in1 = 32'b01011101010110100000011111110000;
  in2 = 32'b00001110001000110000000111000000;
end


// clock period = 100
always begin
  #50;
  CLK = ~CLK;
end

// Module Under Test

float_multiply finst ( .clk(CLK), .reset(RESET), .IN1(in1), .IN2(in2), .OUT(out) );

endmodule