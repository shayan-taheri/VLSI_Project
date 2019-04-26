/////////////////////////////////////////////////////////////////////
// Engineer: Shayan Taheri                                       ///
// Create Date:    10:06:16 03/28/2014                          ///
// Module Name:    single precision floating-point multiplier  ///
/////////////////////////////////////////////////////////////////

module float_multiply (clk, IN1, IN2, OUT);

input clk;
input [31:0] IN1, IN2;
output [31:0] OUT;

reg [31:0] X1 = 32'b0;
reg [31:0] X2 = 32'b0;
reg [31:0] Y = 32'b0;
reg [1:0] stg = 1'b0;
wire [7:0] wireAdd;
wire [23:0] wireMulX1;
wire [23:0] wireMulX2;
wire [47:0] wireMulRES;

wire [45:0] resx_test1, resx_test2, resx_test3, resx_org, diffx1, diffx2, diffx3, diffx1_out, diffx2_out, diffx3_out;
wire [45:0] resy_test1, resy_test2, resy_test3, resy_org, diffy1, diffy2, diffy3, diffy1_out, diffy2_out, diffy3_out;

always @(posedge clk) begin
   
    if (stg == 0) begin
        
        X1 <= IN1;
        X2 <= IN2;
        Y <= 32'b0;
        stg <= 'd1;
    
    end

end

always @(posedge clk) begin
    
    if (stg == 1) begin
        
        if ((X1[30:0] == 8'b0) || (X2[30:0] == 8'b0)) begin
            
                Y[30:0] <= 31'b0;
        
        end

        else begin
        
            Y[31] <= X1[31] ^ X2[31];
        
            if (wireMulRES [47] == 1) begin
            
                Y[30:23] = wireAdd - 'd127 + 'd1;
                if (diffx1_out <= diffx2_out && diffx1_out <= diffx3_out)
                    Y[22:0] = wireMulRES[46:25]+1;
                else if (diffx2_out <= diffx1_out && diffx2_out <= diffx3_out)
                    Y[22:0] = wireMulRES[46:25]-1;
                else if (diffx3_out <= diffx1_out && diffx3_out <= diffx2_out)
                        Y[22:0] = wireMulRES[46:25];

            end

            else begin
            
                Y[30:23] = wireAdd - 'd127;
                if (diffy1_out <= diffy2_out && diffy1_out <= diffy3_out)
                    Y[22:0] = wireMulRES[45:24]+1;
                else if (diffy2_out <= diffy1_out && diffy2_out <= diffy3_out)
                    Y[22:0] = wireMulRES[45:24]-1;
                else if (diffy3_out <= diffy1_out && diffy3_out <= diffy2_out)
                    Y[22:0] = wireMulRES[45:24];

            end

        end
    
        stg <= 'd0;
    
    end

end


assign wireAdd = X1[30:23] + X2[30:23];
assign wireMulX1 = {1'b1,X1[22:0]};
assign wireMulX2 = {1'b1,X2[22:0]};
assign wireMulRES = wireMulX1 * wireMulX2;


assign resx_test1 = {wireMulRES[46:25]+1, 24'b0};
assign resx_test2 = {wireMulRES[46:25]-1, 24'b0};
assign resx_test3 = {wireMulRES[46:25], 24'b0};
assign resx_org = wireMulRES[46:1];
assign diffx1 = resx_org - resx_test1;
assign diffx2 = resx_org - resx_test2;
assign diffx3 = resx_org - resx_test3;
assign diffx1_out = (diffx1[45] == 1) ? ((~diffx1) + 1) : (diffx1);
assign diffx2_out = (diffx2[45] == 1) ? ((~diffx2) + 1) : (diffx2);
assign diffx3_out = (diffx3[45] == 1) ? ((~diffx3) + 1) : (diffx3);


assign resy_test1 = {wireMulRES[45:24]+1, 24'b0};
assign resy_test2 = {wireMulRES[45:24]-1, 24'b0};
assign resy_test3 = {wireMulRES[45:24], 24'b0};
assign resy_org = wireMulRES[45:0];
assign diffy1 = resy_org - resy_test1;
assign diffy2 = resy_org - resy_test2;
assign diffy3 = resy_org - resy_test3;
assign diffy1_out = (diffy1[45] == 1) ? ((~diffy1) + 1) : (diffy1);
assign diffy2_out = (diffy2[45] == 1) ? ((~diffy2) + 1) : (diffy2);
assign diffy3_out = (diffy3[45] == 1) ? ((~diffy3) + 1) : (diffy3);


assign OUT = Y;

endmodule

