module dff(d,clk,q,rst);
	input wire d,clk,rst;
	output reg q;
	initial
		q = 1'b0;
	always @(posedge clk)
		begin
			if(rst==1'b1)
			begin
				q <= 0;
			end
			else
			begin
				case(d)
					1'b0:q <= 1'b0;
					1'b1:q <= 1'b1;
				endcase
			end
		end
endmodule

module Overlapping(in,out,clk,rst);
	input in,clk,rst;
	output out;
	wire [15:0]w;
	wire i1,i2,i3,i4,a,b,c,d;

	and(w[0],a,in);
	and(w[1],b,c,d,in);
	or(i1,w[0],w[1]);

	and(w[2],~a,~c,in);
	and(w[3],~a,~d,in);
	and(w[4],~b,c,d);
	and(w[5],b,~c,~d);
	or(i2,w[2],w[3],w[4],w[5]);

	and(w[6],~b,~c,d,~in);
	and(w[7],~b,c,~d,~in);
	and(w[8],b,~c,d,in);
	and(w[9],b,c,~d,in);
	or(i3,w[6],w[7],w[8],w[9]);

	and(w[10],c,~d);
	and(w[11],b,~d,in);
	and(w[12],~b,~d,~in);
	and(w[13],~b,~a,in);
	and(w[14],b,d,~in);
	or(w[15],w[10],w[11],w[12]);
	or(i4,w[15],w[13],w[14]);

	dff da(i1,clk,a,rst);
	dff db(i2,clk,b,rst);
	dff dc(i3,clk,c,rst);
	dff dd(i4,clk,d,rst);
	and(out,~c,~d);

endmodule

module Overlapping_tb();
	reg in,clk,rst;
	wire out;
	Overlapping ol(.in(in),.out(out),.clk(clk),.rst(rst));
	initial begin
		in = 0;
		clk = 0;
		rst = 0;
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
		$monitor("clk=%d reset=%b in=%b out=%b", clk,rst,in,out);
		$dumpfile("overlapping.vcd");
		$dumpvars(0,Overlapping_tb);
	end
endmodule