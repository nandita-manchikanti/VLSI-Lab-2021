module encoder8to3(Ip0,Ip1,Ip2,Ip3,Ip4,Ip5,Ip6,Ip7,a,b,c); 
     input Ip0,Ip1,Ip2,Ip3,Ip4,Ip5,Ip6,Ip7;
     output a,b,c;
     
       or(c,Ip7,Ip6,Ip5,Ip4);
       or(b,Ip7,Ip6,Ip3,Ip2);
       or(a,Ip7,Ip5,Ip3,Ip1);

endmodule

module encoder8to3_tb();
  reg Ip0,Ip1,Ip2,Ip3,Ip4,Ip5,Ip6,Ip7;
  wire Op0,Op1,Op2;
  encoder8to3 c(Ip0,Ip1,Ip2,Ip3,Ip4,Ip5,Ip6,Ip7,Op0,Op1,Op2);

 initial begin
    #0 Ip0 = 1; Ip1=0; Ip2=0; Ip3=0; Ip4=0; Ip5=0; Ip6=0; Ip7=0;
    #1 Ip0 = 0; Ip1=1; Ip2=0; Ip3=0; Ip4=0; Ip5=0; Ip6=0; Ip7=0;
    #2 Ip0 = 0; Ip1=0; Ip2=1; Ip3=0; Ip4=0; Ip5=0; Ip6=0; Ip7=0;
    #3 Ip0 = 0; Ip1=0; Ip2=0; Ip3=1; Ip4=0; Ip5=0; Ip6=0; Ip7=0;
    #4 Ip0 = 0; Ip1=0; Ip2=0; Ip3=0; Ip4=1; Ip5=0; Ip6=0; Ip7=0;
    #5 Ip0 = 0; Ip1=0; Ip2=0; Ip3=0; Ip4=0; Ip5=1; Ip6=0; Ip7=0;
    #6 Ip0 = 0; Ip1=0; Ip2=0; Ip3=0; Ip4=0; Ip5=0; Ip6=1; Ip7=0;
    #7 Ip0 = 0; Ip1=0; Ip2=0; Ip3=0; Ip4=0; Ip5=0; Ip6=0; Ip7=1;
  end  
      
  initial begin
      $display("Input : 0|1|2|3|4|5|6|7 ----> Output : 0|1|2");
      $display("----------------------------------------------");
      $monitor("Input : %b|%b|%b|%b|%b|%b|%b|%b ----> Output : %b|%b|%b",Ip0,Ip1,Ip2,Ip3,Ip4,Ip5,Ip6,Ip7,Op0,Op1,Op2);
      $dumpfile("8x3encoder.vcd");
      $dumpvars(0,encoder8to3_tb);
  end
endmodule
