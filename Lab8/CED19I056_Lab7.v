module RLE (line,out);
    input [3:0]line;
    output integer out;
    integer i;
    reg [2:0] count;
    always@(*)begin
        for(i=3;i>=0;i=i-1)
        begin
            count=1;
            while(line[i]==line[i-1])
            begin
                count=count+1;
                i=i-1;
            end
            if(line[i]==1)
            begin 
                $write("%d1",count);
            end
            else
            begin
                $write("%d0",count);
            end	
        end
    end

endmodule

module RLE_tb();
    reg [3:0] line1;
    reg [3:0] line2;
    reg [3:0] line3;
    reg [3:0] line4;
    wire integer out;

    RLE rle1(line1,out);
    RLE rle2(line2,out);
    RLE rle3(line3,out);
    RLE rle4(line4,out);


    initial begin
        $dumpfile("RLE.vcd");
        $dumpvars(0,RLE_tb);
    end
    initial begin
    #1      $monitor("Array 1\n");
    #1      line1 = 4'b0000;line2 = 4'b0001;line3 = 4'b0010;line4 = 4'b0111;
    #1      $monitor("\n");
        
    #1     $monitor("Array 2\n");
    #1     line1=4'b1011;line2=4'b0111;line3=4'b0011;line4=4'b1000;
    #1     $monitor("\n");	

    #1     $monitor("Array 3\n");
    #1     line1=4'b1111;line2=4'b1110;line3=4'b1101;line4=4'b1000;
    #1     $monitor("\n");

    #1     $monitor("Array 4\n");
    #1     line1=4'b0100;line2=4'b1000;line3=4'b1100;line4=4'b0111;
    #1     $monitor("\n");

    end
endmodule