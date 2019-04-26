/////////////////////////////////////////////////////////////////////
// Engineer: Shayan Taheri                                       ///
// Create Date:    10:06:16 03/28/2014                          ///
// Module Name:    single precision floating-point multiplier  ///
/////////////////////////////////////////////////////////////////

module float_multiply (clk, reset, IN1, IN2, OUT);

input clk, reset;
input [31:0] IN1, IN2;
output [31:0] OUT;

reg [31:0] X1;
reg [31:0] X2;
reg [31:0] Y;
reg [2:0] stage;
reg [7:0] regAdd;
reg [23:0] regMulX1;
reg [23:0] regMulX2;
reg [47:0] regMulRES;
reg [45:0] resx_test1;
reg [45:0] resx_test2;
reg [45:0] resx_test3;
reg [45:0] resx_org;
reg [45:0] diffx1;
reg [45:0] diffx2;
reg [45:0] diffx3;
reg [45:0] diffx1_out;
reg [45:0] diffx2_out;
reg [45:0] diffx3_out;
reg [45:0] resy_test1;
reg [45:0] resy_test2;
reg [45:0] resy_test3;
reg [45:0] resy_org;
reg [45:0] diffy1;
reg [45:0] diffy2;
reg [45:0] diffy3;
reg [45:0] diffy1_out;
reg [45:0] diffy2_out;
reg [45:0] diffy3_out;

wire [31:0] xor1;
wire [31:0] xor2;
wire [31:0] des1;
wire [31:0] des2;

always @(posedge clk) begin
    
    if ((reset == 1'b1) || ((stage == 3'b111) && ((des1 != 32'b0) || (des2 != 32'b0)))) begin
        
	     X1 <= 32'b0;
	     X2 <= 32'b0;
	     Y <= 32'b0;
	     stage <= 3'b0;
	     regAdd <= 8'b0;
	     regMulX1 <= 24'b0;
	     regMulX2 <= 24'b0;
	     regMulRES <= 48'b0;
	     resx_test1 <= 46'b0;
	     resx_test2 <= 46'b0;
	     resx_test3 <= 46'b0;
	     resx_org <= 46'b0;
	     diffx1 <= 46'b0;
	     diffx2 <= 46'b0;
	     diffx3 <= 46'b0;
	     diffx1_out <= 46'b0;
	     diffx2_out <= 46'b0;
	     diffx3_out <= 46'b0;
	     resy_test1 <= 46'b0;
	     resy_test2 <= 46'b0;
	     resy_test3 <= 46'b0;
	     resy_org <= 46'b0;
	     diffy1 <= 46'b0;
	     diffy2 <= 46'b0;
	     diffy3 <= 46'b0;
	     diffy1_out <= 46'b0;
	     diffy2_out <= 46'b0;
	     diffy3_out <= 46'b0;
    
    end
    
    else if ((reset == 1'b0) && (stage == 3'b000)) begin
        
        X1 <= IN1;
        X2 <= IN2;
        Y <= 32'b0;
        stage <= 3'b001;
    
    end
    
    else if ((reset == 1'b0) && (stage == 3'b001)) begin
        
        regAdd <= X1[30:23] + X2[30:23];
        regMulX1[22:0] <= X1[22:0];
		  regMulX1[23] <= 1'b1;
        regMulX2 <= X2[22:0];
		  regMulX2[23] <= 1'b1;
        stage <= 3'b010;
    
    end
    
    else if ((reset == 1'b0) && (stage == 3'b010)) begin
        
        regMulRES <= regMulX1 * regMulX2;
        stage <= 3'b011;
    
    end
    
    else if ((reset == 1'b0) && (stage == 3'b011)) begin
        
        resx_test1[22:0] <= 23'b0;
	resx_test1[45:23] <= regMulRES[46:24] + 1'b1;
        
	resx_test2[22:0] <= 23'b0;
	resx_test2[45:23] <= regMulRES[46:24] - 1'b1;
		  
        resx_test3[22:0] <= 23'b0;
	resx_test3[45:23] <= regMulRES[46:24];
		  
        resx_org <= regMulRES[46:1];
        
        resy_test1[22:0] <= 23'b0;
	resy_test1[45:23] <= regMulRES[45:23] + 1'b1;
		  
        resy_test2[22:0] <= 23'b0;
	resy_test2[45:23] <= regMulRES[45:23] - 1'b1;
        
	resy_test3[22:0] <= 23'b0;
	resy_test3[45:23] <= regMulRES[45:23];
        
	resy_org <= regMulRES[45:0];
        stage <= 3'b100;
    
    end
    
    else if ((reset == 1'b0) && (stage == 3'b100)) begin
        
        diffx1 <= resx_org - resx_test1;
        diffx2 <= resx_org - resx_test2;
        diffx3 <= resx_org - resx_test3;
        
        diffy1 <= resy_org - resy_test1;
        diffy2 <= resy_org - resy_test2;
        diffy3 <= resy_org - resy_test3;
        stage <= 3'b101;
    
    end
    
    else if ((reset == 1'b0) && (stage == 3'b101)) begin
        
        if (diffx1[45] == 1'b1)
            diffx1_out <= (~diffx1) + 1'b1;
        else diffx1_out <= diffx1;
        
        if (diffx2[45] == 1'b1)
            diffx2_out <= (~diffx2) + 1'b1;
        else diffx2_out <= diffx2;
        
        if (diffx3[45] == 1'b1)
            diffx3_out <= (~diffx3) + 1'b1;
        else diffx3_out <= diffx3;
        
        if (diffy1[45] == 1'b1)
            diffy1_out <= (~diffy1) + 1'b1;
        else diffy1_out <= (diffy1);
        
        if (diffy2[45] == 1'b1)
            diffy2_out <= (~diffy2) + 1'b1;
        else diffy2_out <= diffy2;
        
        if (diffy3[45] == 1'b1)
            diffy3_out <= (~diffy3) + 1'b1;
        else diffy3_out <= diffy3;
        
        stage <= 3'b110;
        end
    
    else if ((reset == 1'b0) && (stage == 3'b110)) begin
        
        if ((X1[30:0] == 31'b0) || (X2[30:0] == 31'b0)) begin
            
            Y[31:0] <= 32'b0;
        
        end
        
        else begin
            
            Y[31] <= X1[31] ^ X2[31];
            
            if (regMulRES [47] == 1'b1) begin
                
                Y[30:23] <= regAdd - 7'b1111110;       // 'd127 + 'd1
                if ((diffx1_out <= diffx2_out) && (diffx1_out <= diffx3_out))
                    Y[22:0] <= regMulRES[46:24] + 1'b1;
                else if ((diffx2_out <= diffx1_out) && (diffx2_out <= diffx3_out))
                    Y[22:0] <= regMulRES[46:24] - 1'b1;
                else if ((diffx3_out <= diffx1_out) && (diffx3_out <= diffx2_out))
                    Y[22:0] <= regMulRES[46:24];
            
            end
            
            else begin
                
                Y[30:23] <= regAdd - 7'b1111111;
                if ((diffy1_out <= diffy2_out) && (diffy1_out <= diffy3_out))
                    Y[22:0] <= regMulRES[45:23] + 1'b1;
                else if ((diffy2_out <= diffy1_out) && (diffy2_out <= diffy3_out))
                    Y[22:0] <= regMulRES[45:23] - 1'b1;
                else if ((diffy3_out <= diffy1_out) && (diffy3_out <= diffy2_out))
                    Y[22:0] <= regMulRES[45:23];
            
            end
        
        end
        
        stage <= 3'b111;
    
    end

end

assign xor1 = IN1 ^ X1;
assign xor2 = IN2 ^ X2;

assign des1 = xor1[0] + xor1[1] + xor1[2] + xor1[3] + xor1[4] + xor1[5] + xor1[6] + xor1[7] + xor1[8] + xor1[9] + xor1[10] + xor1[11] + xor1[12] + xor1[13] + xor1[14] + xor1[15] + xor1[16] + xor1[17] + xor1[18] + xor1[19] + xor1[20] + xor1[21] + xor1[22] + xor1[23] + xor1[24] + xor1[25] + xor1[26] + xor1[27] + xor1[28] + xor1[29] + xor1[30] + xor1[31];

assign des2 = xor2[0] + xor2[1] + xor2[2] + xor2[3] + xor2[4] + xor2[5] + xor2[6] + xor2[7] + xor2[8] + xor2[9] + xor2[10] + xor2[11] + xor2[12] + xor2[13] + xor2[14] + xor2[15] + xor2[16] + xor2[17] + xor2[18] + xor2[19] + xor2[20] + xor2[21] + xor2[22] + xor2[23] + xor2[24] + xor2[25] + xor2[26] + xor2[27] + xor2[28] + xor2[29] + xor2[30] + xor2[31];

assign OUT = Y;

endmodule

