module TFF(d,clk,reset,q);
    input clk, reset;
    input wire d;
    output reg q;

    initial 
        q = 1'b0;

    always@(posedge clk or posedge reset)
    begin
        if(reset)
            q <= 1'b0;
        else
            q <= (d&(~q)) | ((~d)&q);
    end
endmodule

module mod9(clk,reset,q);
    input clk, reset;
    output [4:1] q;
    wire [4:1]inputs;

    assign inputs[1] = ~q[4];
    assign inputs[2] = q[1];
    assign inputs[3] = q[1]&q[2];
    assign inputs[4] = q[4]|q[1]&q[2]&q[3];

    TFF tff_1(inputs[1], clk, reset, q[1]);
    TFF tff_2(inputs[2], clk, reset, q[2]);
    TFF tff_3(inputs[3], clk, reset, q[3]);
    TFF tff_4(inputs[4], clk, reset, q[4]);
endmodule


module mod9tb;
    reg clk, reset;
    wire [4:1] q;

    initial
        begin
            $dumpfile("mod9.vcd");
            $dumpvars(0, mod9tb);
        end

    mod9 counter(clk, reset, q);


    initial
        begin
            reset=0;
            clk =0;
        end

    always #5  
        clk =  ! clk; 

    initial
        $monitor($time, ": clk=%b, rst=%b, q in decimal=%d , q in binary=%b", clk, reset, q,q);

    initial
        #130 $finish;
endmodule
