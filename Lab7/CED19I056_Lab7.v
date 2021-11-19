`timescale 1ns/1ps

module alu(A,B,ALU_Sel,ALU_Result,flagCarry,flagZero,flagNeg,flagoverflow,flagparity);
    input signed [7:0] A,B;            
    input [3:0] ALU_Sel;

    output reg flagCarry=1'b0;
    output reg flagZero=1'b0;
    output reg flagNeg=1'b0;
    output reg flagparity=1'b0;
    output reg flagoverflow=1'b0;
    reg signed [15:0] Mul_result;
    output reg signed [7:0] ALU_Result;

   parameter [3:0] ADD         = 4'b0000;
   parameter [3:0] SUB         = 4'b0001;
   parameter [3:0] MUL         = 4'b0010;
   parameter [3:0] DIV         = 4'b0011;
   parameter [3:0] AND         = 4'b0100;
   parameter [3:0] OR          = 4'b0101;
   parameter [3:0] XOR         = 4'b0110;
   parameter [3:0] NAND        = 4'b0111;
   parameter [3:0] NOR         = 4'b1000;
   parameter [3:0] XNOR        = 4'b1001;
   parameter [3:0] SL          = 4'b1010;
   parameter [3:0] SR          = 4'b1011;
   parameter [3:0] RLwithCarry = 4'b1100;
   parameter [3:0] RRwithCarry = 4'b1101;
   parameter [3:0] COMP         = 4'b1110;
   reg signed [7:0] temp;

    always @(A,B,ALU_Sel)
        begin
            case(ALU_Sel)
            ADD: 
                begin
                    $display("ADD");	
                    temp = A + B;
                    if(A[7]==1 && B[7]==1 && temp[7]==0)
                        begin
                            flagoverflow=1'b1;
                            ALU_Result=temp-128;
                        end
                    else if(A[7]==0 && B[7]==0 && temp[7]==1)
                        begin
                            flagCarry=1'b1;
                            flagoverflow=1'b1;
                            ALU_Result=temp+128;
                        end
                    else
                        begin
                            flagoverflow=1'b0;
                            ALU_Result=temp;
                        end
                end
            SUB:
                begin
                    $display("SUB");
                    temp = A - B;
                    if(A[7]==1 && B[7]==0 && temp[7]==0)
                        begin
                            flagoverflow=1'b1;
                            ALU_Result=temp-128;
                        end
                    else if(A[7]==0 && B[7]==1 && temp[7]==1)
                        begin
                            flagCarry=1'b1;
                            flagoverflow=1'b1;
                            ALU_Result=temp+128;
                        end
                    else
                        begin
                            flagoverflow=1'b0;
                            ALU_Result=temp;
                        end
                end
            MUL:
                begin
                    $display("MUL");
                    ALU_Result = A * B;
                    Mul_result = A * B;
                    $display("MUL_result:%d",Mul_result);
                    //considering overflow if the result doesnot fit in 8 bits
                    if(Mul_result[15]|Mul_result[14]|Mul_result[13]|Mul_result[12]|Mul_result[11]|Mul_result[10]|Mul_result[9]|Mul_result[8]==1)
                        begin
                            flagCarry=1'b1;
                            flagoverflow=1'b1;
                        end
                    else
                        begin
                            flagCarry=1'b0;
                            flagoverflow=1'b0;
                        end
                end
            DIV:
                begin
                    $display("DIV");
                    {flagoverflow,ALU_Result}= A / B;
                    flagCarry=1'b0;
                end
            AND:
                begin
                    $display("AND");
                    ALU_Result = A & B;
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            OR:
                begin
                    $display("OR");
                    ALU_Result = A | B;
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            XOR:
                begin
                    $display("XOR");
                    ALU_Result = A ^ B;
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            NAND:
                begin
                    $display("NAND");
                    ALU_Result = ~(A & B);
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            NOR:
                begin
                    $display("NOR");
                    ALU_Result = ~(A | B);
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            XNOR:
                begin
                    $display("XNOR");
                    ALU_Result = ~(A ^ B);
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            SL:
                begin
                    $display("SL");
                    ALU_Result[0]=0;
                    ALU_Result[7:0]=A[6:0];
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            SR:
                begin
                    $display("SR");
                    ALU_Result[7]=0;
                    ALU_Result[6:0]=A[7:1];
                    flagCarry=1'b0;
                    flagoverflow=1'b0;
                end
            RLwithCarry:
                begin
                    $display("RLwithCarry");
                    flagCarry=A[7];
                    ALU_Result[7:0]={A[6:0],flagCarry};
                    flagoverflow=1'b0;
                end 
            RRwithCarry:
                begin
                    $display("RRwithCarry");
                    flagCarry=A[0];
                    ALU_Result[7:0]={flagCarry,A[7:1]};
                    flagoverflow=1'b0;
                end
            COMP:
                begin
                    $display("COMP");
                    if(A==B)
                        begin
                            ALU_Result=1'b1;
                            flagCarry=1'b0;
                            flagoverflow=1'b0;
                        end
                    else
                        begin
                            ALU_Result=1'b0;
                            flagCarry=1'b0;
                            flagoverflow=1'b0;
                        end
                end
        endcase
        flagZero = (ALU_Result==0);
        flagNeg = (ALU_Result[7]==1);
        flagparity = (ALU_Result[0]^ALU_Result[1]^ALU_Result[2]^ALU_Result[3]^ALU_Result[4]^ALU_Result[5]^ALU_Result[6]^ALU_Result[7]);
    end
endmodule

module tb_alu;

 reg signed [7:0] A,B;
 reg [3:0] ALU_Sel;
 wire signed [7:0] ALU_Out;
 wire flagCarry;
 wire flagZero;
 wire flagNeg;
 wire flagparity;
 wire flagoverflow;
 
alu test_unit(A,B,ALU_Sel,ALU_Out,flagCarry,flagZero,flagNeg,flagoverflow,flagparity);
    initial begin
      #0    A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0000;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0001;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0010;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0011;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0100;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0101;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0110;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b0111;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1000;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1001;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1010;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1011;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1100;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1101;
      #10   A = 8'b01011101; B = 8'b11010110; ALU_Sel = 4'b1110;
    end

    initial begin
        $monitor("a=%d b=%d ALU_Sel=%b ALU_Out=%d ALU_Out=%b flagCarry=%b flagOverflow=%b flagZero=%b flagNeg=%b flagParity=%b"
        ,A,B,ALU_Sel,ALU_Out,ALU_Out,flagCarry,flagoverflow,flagZero,flagNeg,flagparity);
        $dumpfile("ALU.vcd");
		$dumpvars(0,tb_alu);
    end
endmodule