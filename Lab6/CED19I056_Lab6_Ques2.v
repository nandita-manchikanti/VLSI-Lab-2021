module nonoverlapping(in,out,clk,reset);
	input in,clk,reset;
	output reg out;
	parameter s0=3'b000,
			  s1=3'b001,
			  s2=3'b010,
			  s3=3'b011,
			  s4=3'b100,
			  s5=3'b101,
			  s6=3'b110;
	reg [2:0] cs,ns;		  
	always @(posedge clk)
		begin
			if(reset)
				cs<=s0;
			else
				cs<=ns;
		end
	always @(posedge clk)
		begin
			if(reset)
				out<=1'b0;
			else
				begin
				if ((cs==s3 && in==1'b0) || (cs==s6 && in==1'b1))
					out<=1'b1;
				else
					out<=1'b0;
				end
		end
	always @(cs,in)
		begin
			case(cs)
				s0:	ns = in?s4:s1;	
				s1:	ns = in?s4:s2;
				s2:	ns = in?s4:s3;
				s3:	ns = in?s4:s0;
				s4:	ns = in?s5:s1;
				s5:	ns = in?s6:s1;
				s6:	ns = in?s0:s1;
				default:ns = 4'b000;
			endcase
		end
endmodule

module nonoverlapping_tb();
	reg in,clk,reset;
	wire out;
	nonoverlapping sd2(.in(in),.out(out),.clk(clk),.reset(reset));
	initial begin
		in = 0;
		clk = 0;
		reset = 0;
		forever #10 clk = ~clk;
	end
	initial begin
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 0;
		#20 in = 0;
		#20 in = 0;
		#20 in = 0;
		#20 in = 0;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 1;
		#20 in = 0;
		#20 in = 0;
		#20 $finish;
	end
	initial begin
		$monitor("clk=%d reset=%b in=%b out=%b", clk,reset,in,out);
		$dumpfile("sd2.vcd");
		$dumpvars(0,nonoverlapping_tb);
	end
endmodule
