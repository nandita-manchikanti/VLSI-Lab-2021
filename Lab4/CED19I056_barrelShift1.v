//CED19I056
//barrel shifter (i)

module mux4x1(a, b, c, d, s0, s1 ,out);
    output out;
    input a, b, c, d, s0, s1;
    wire s0bar, s1bar, T1, T2, T3;
    assign s1bar= ~s1;
    assign s0bar= ~s0;
    
    and(T1, a, s0bar, s1bar);
    and(T2, b, s0, s1bar);
    and(T3, c, s0bar, s1);
    and(T4, d, s0, s1);
    or(out, T1, T2, T3, T4);
endmodule

module barrel_shift(w0,w1,w2,w3,s0,s1,y0,y1,y2,y3);
    input w0,w1,w2,w3,s0,s1;
    output y0,y1,y2,y3;

   mux4x1 a(w0,w1,w2,w3,s0,s1,y0);
   mux4x1 b(w1,w2,w3,w0,s0,s1,y1);
   mux4x1 c(w2,w3,w0,w1,s0,s1,y2);
   mux4x1 d(w3,w0,w1,w2,s0,s1,y3);
   
endmodule

module barrel_shift_tb();
    reg w0,w1,w2,w3,s0,s1;
    wire y0,y1,y2,y3;

    barrel_shift c(w0,w1,w2,w3,s0,s1,y0,y1,y2,y3);

    initial begin
	    #0   w0=1;w1=1;w2=0;w3=1;s0=0;s1=0;
        #10  w0=1;w1=1;w2=0;w3=1;s0=1;s1=0;
        #20  w0=1;w1=1;w2=0;w3=1;s0=0;s1=1;
        #30  w0=1;w1=1;w2=0;w3=1;s0=1;s1=1;
    end
	
	initial 
	begin
        $display("Input--->Output for S1S0");
        $monitor("%b%b%b%b--->%b%b%b%b for %b%b ",w3,w2,w1,w0,y3,y2,y1,y0,s1,s0);
		$dumpfile("barrel_shifter1.vcd");
        $dumpvars(0,barrel_shift_tb);
	end
endmodule