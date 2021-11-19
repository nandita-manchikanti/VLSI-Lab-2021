`timescale 1ns/1ps
module FA_Behavioral(a,b,cin,sum,cout);
    input a,b,cin;
    output reg sum,cout;
    always @ (*) 
    begin
        sum=a^b^cin;
        cout=(a&b)|(b&cin)|(a&cin);
    end

endmodule

module FPA_tb;
    reg a,b;
    reg cin;
    wire sum;
    wire cout;
    
    FA_Behavioral Beh(a,b,cin,sum,cout);
    
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
        $dumpfile("FA_Behavioral.vcd");
        $dumpvars(0,FPA_tb);
    end
endmodule
