module decoder3to8(a,b,c,Op0,Op1,Op2,Op3,Op4,Op5,Op6,Op7); 
    input  a,b,c; 
    input EN;
    output Op0,Op1,Op2,Op3,Op4,Op5,Op6,Op7;
    and(Op0,~a,~b,~c);
    and(Op1,~a,~b,c);
    and(Op2,~a,b,~c);
    and(Op3,~a,b,c);
    and(Op4,a,~b,~c);
    and(Op5,a,~b,c);
    and(Op6,a,b,~c);
    and(Op7,a,b,c);
endmodule

module decoder3to8_tb();
 reg Ip0,Ip1,Ip2;
 wire Op0,Op1,Op2,Op3,Op4,Op5,Op6,Op7;
 decoder3to8 c(Ip0,Ip1,Ip2,Op0,Op1,Op2,Op3,Op4,Op5,Op6,Op7);

 initial begin
    #0 Ip0 = 0;Ip1=0;Ip2=0;
    #1 Ip0 = 0;Ip1=0;Ip2=1;
    #2 Ip0 = 0;Ip1=1;Ip2=0;
    #3 Ip0 = 0;Ip1=1;Ip2=1;
    #4 Ip0 = 1;Ip1=0;Ip2=0;
    #5 Ip0 = 1;Ip1=0;Ip2=1;
    #6 Ip0 = 1;Ip1=1;Ip2=0;
    #7 Ip0 = 1;Ip1=1;Ip2=1;

  end  

  initial begin
      $monitor("Input %b%b%b Output %b%b%b%b%b%b%b",Ip0,Ip1,Ip2,Op0,Op1,Op2,Op3,Op4,Op5,Op6,Op7);
      $dumpfile("3x8decoder.vcd");
      $dumpvars(0,decoder3to8_tb);
  end
endmodule
