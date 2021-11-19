// iverilog FA_Structural.v 
// ./a.out
//Implement full adder in stuctural verilog

`timescale 1ns/1ps
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

module FPA_tb;
	reg a,b;
	reg cin;
	wire sum;
	wire cout;

	
	FA_Structural str(a,b,cin,sum,cout);
	
	initial begin
	
		#0   a=0;b=0;cin=0;
		#10  a=0;b=0;cin=1;
		#10  a=0;b=1;cin=0;
		#10  a=0;b=1;cin=1;
        #10  a=1;b=0;cin=0;
		#10  a=1;b=0;cin=1;
		#10  a=1;b=1;cin=0;
		#10  a=1;b=1;cin=1;

	end
	
	initial begin
		$monitor("%d: a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
		$dumpfile("FA.vcd");
		$dumpvars(0,FPA_tb);
	end
endmodule