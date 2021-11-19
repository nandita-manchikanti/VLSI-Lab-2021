// BOOTH MULTIPLIER
//CED19I056

module booth_multiplier(a,b,prod);
   input signed [3:0]a,b;
   output signed [7:0]prod;
   
   reg [3:0] AC,QR;
   reg[8:0] res,result = 9'b0;
   reg[2:0]temp;
   reg Q1;
   integer count;
  
   always@(a , b)
     begin
	    AC = 4'b0000;
        QR = b;
        Q1 = 1'b0;

	    for(count=4;count>=0;count=count-1)
		begin
		  if(count == 0)
          begin
		    result = res;
          end

		  res =  {AC,QR,Q1};
		  temp = {res[1],res[0]};
		  
          case(temp)
            2'b01:AC = AC + a;
            2'b10:AC = AC + (~a) + 4'b0001;
            default:AC = AC;
          endcase

		  res = {AC,QR,Q1};
		  res = {res[8],res[8:1]};
		  AC = res[8:5];
		  QR = res[4:1];
		  Q1 = res[0];
         end
     end
     assign prod = result[8:1];	
endmodule

module booth_multiplication_tb();
    reg signed [3:0] a,b;
    wire signed[7:0] product;

    booth_multiplier mul_booth(a,b,product);

    initial begin
	    #0   a=4'b0010; b=4'b1011;
		#10  a=4'b0110; b=4'b1100;
		#10  a=4'b0101; b=4'b0110;
		#10  a=4'b1100; b=4'b1000;
		#10  a=4'b1001; b=4'b1000;
		#10  a=4'b1111; b=4'b1010;
		#10  a=4'b1001; b=4'b1101;
		#10  a=4'b0100; b=4'b1101;
		#10  a=4'b1110; b=4'b1111;
		#10  a=4'b0011; b=4'b1011;
		#10  a=4'b1001; b=4'b1111;
    end
	
	initial 
	begin
	    $monitor("%d : %d  x  %d  =  %d ",$time,a,b,product);
		$dumpfile("mul_booth.vcd");
        $dumpvars(0,booth_multiplication_tb);
	end
endmodule