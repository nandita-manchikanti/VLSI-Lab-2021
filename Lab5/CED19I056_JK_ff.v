module JK_flip_flop(Q, Q_bar, J, K, clk, reset);
	input J, K;
	input clk, reset;
	output reg Q;
	output Q_bar;
	
	always @(posedge clk, negedge reset)
		if (reset == 1) Q <= 1'b0;
		else
			begin
				case ({J, K})
					2'b00: Q <= Q;		// No change
					2'b01: Q <= 1'b0;	// Reset
					2'b10: Q <= 1'b1;	// Set
					2'b11: Q <= ~Q;		// Toggle
				endcase
			end
			
	assign Q_bar = ~Q;
endmodule

module JK_flip_flop_tb();
	reg[1:0] t_A;
	reg t_clk, t_reset;
	wire t_Q, t_Q_bar;
	integer i;
	
	JK_flip_flop dut(t_Q, t_Q_bar, t_A[1], t_A[0], t_clk, t_reset);
	
	initial
		begin
			t_clk = 1'b0;
			forever #10 t_clk = ~t_clk;
		end
		
	initial
		begin
			t_reset = 1'b1;
			#12 t_reset = 1'b0;
		end
	
	initial
		begin
			t_A = 2'b00;
			for (i = 0; i < 16; i = i + 1)
				begin
					#20 t_A = i;
				end
		end
		
	initial
		begin
			$monitor("time = %0d, clk = %b, reset = %b, J = %b, K = %b, Q = %b, Q_bar = %b", $time, t_clk, t_reset, t_A[1], t_A[0], t_Q, t_Q_bar);
			$dumpfile("jk.vcd");
			$dumpvars();
		end
		
	initial #300 $finish;
endmodule