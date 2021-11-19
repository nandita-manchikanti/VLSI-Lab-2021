// iverilog 4*4_mul_Behavioural.v 
// ./a.out
// Implement 4*4 array multiplier in behavioural verilog

module multiplier(a,b,prod);
        input[3:0] a;
        input[3:0] b;
        output[7:0] prod;
        reg [7:0] result;
        reg[2:0] i;

        always @(*)
        begin
            result=0;
            for(i=0;i<4;i=i+1)
                begin
                if(b[i]==1'b1)
                    begin
                        result = result+(a<<i);
                    end
                end
        end
        assign prod = result;
endmodule

module mul_tb();
	reg [3:0]a,b;
	wire [7:0]c;

    multiplier m(a,b,c);
	
	initial begin
		#00  a=1 ;  b=11;
		#100  a=2;   b=12;
		#100  a=3;   b=13;
		#100  a=4;   b=15;
        #100  a=5;   b=16;
        #100  a=6;   b=7;
        #100  a=7;   b=4;
        #100  a=8;   b=2;
        #100  a=9;   b=8;
        #100  a=10;  b=9;
        #100  a=11;  b=5;
        #100  a=12;  b=12;
        #100  a=13;  b=14;
        #100  a=14;  b=11;
	end
	
	initial begin
		$monitor("%d: a=%d b=%d cout=%d",$time,a,b,c);
		$dumpfile("mul.vcd");
		$dumpvars(0,mul_tb);
	end
endmodule