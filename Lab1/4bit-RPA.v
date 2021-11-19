`timescale 1ns / 1ps
module FA_Structural(a,b,cin,sum,cout);
	input a,b,cin;
    output sum,cout;
    wire x,y,z;

    xor(x,a,b);
    xor(sum,x,cin);
    and(y,cin,x);
    and(z,a,b);
    or(cout,y,z);
endmodule

module RPA(a,b,cin,sum,cout);
	input[3:0] a,b; 
	input cin;
	output[3:0] sum;
	output cout;
	wire c0,c1,c2;
	
	FA_Structural fa1(a[0],b[0],cin,sum[0],c0);
	FA_Structural fa2(a[1],b[1],c0,sum[1],c1);
	FA_Structural fa3(a[2],b[2],c1,sum[2],c2);
	FA_Structural fa4(a[3],b[3],c2,sum[3],cout);
endmodule
	
module RPA_tb;
	reg[3:0] a,b;
	reg cin;
	wire[3:0] sum;
	wire cout;
	
	RPA rpa(a,b,cin,sum,cout);
	
	initial begin
		#0   a=4'b0000;b=4'b0000;cin=0;
		#10  a=4'b0000;b=4'b0000;cin=1;
		#10  a=4'b0000;b=4'b1111;cin=0;
		#10  a=4'b0000;b=4'b1111;cin=1;
        #10  a=4'b0011;b=4'b1111;cin=1;
	end
	
	initial begin
		$monitor("%d: a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
		$dumpfile("RPA.vcd");
		$dumpvars(0,RPA_tb);
	end
endmodule
