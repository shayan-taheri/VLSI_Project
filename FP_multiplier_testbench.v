// Floating-Point Multiplier TestBench

`timescale 1ns/10ps

module float_tb();

reg CLK;
reg [31:0] in1;
reg [31:0] in2;
wire [31:0] out;

initial begin
    CLK = 1'b0;
    in1 = 32'b01000001010110100000000000000000;
    in2 = 32'b10111110001000000000000000000000;
    end

// clock period = 100
always begin
    #20
    CLK = ~CLK;
end


// Module Under Test

float_multiply finst ( .clk(CLK), .IN1(in1), .IN2(in2), .OUT(out) );

endmodule
