module elevator(destinationfloor,presentfloor)
    input destinationfloor;
    output presentfloor;
    reg direction;
    reg elevator_state;

    parameter elevator_state_idle = 0;
    parameter elevator_state_up=1;
    parameter elevator_state_down=2;

    initial presentfloor = 0;
    initial direction = 1;
    initial elevator_state = elevator_state_idle;

    always @(*) begin
        if(elevator_state == elevator_state_idle) begin
            if(destinationfloor > presentfloor) begin
                elevator_state = elevator_state_up;
            end else if(destinationfloor < presentfloor) begin
                elevator_state = elevator_state_down;
            end else begin
                elevator_state = elevator_state_idle;
            end
        end else if(elevator_state == elevator_state_up) begin
            if(destinationfloor == presentfloor) begin
                elevator_state = elevator_state_idle;
            end else begin
                presentfloor = presentfloor + direction;
            end
        end else if(elevator_state == elevator_state_down) begin
            if(destinationfloor == presentfloor) begin
                elevator_state = elevator_state_idle;
            end else begin
                presentfloor = presentfloor + direction;
            end
        end
    end
endmodule

module Controller(intake, elevator, out);
    input [11:0]intake;
    reg elevator;
    output out;
    
    reg [5:0]presentfloor;
    reg [5:0]destinationfloor;

    assign presentfloor = intake[5:0];
    assign destinationfloor = intake[11:6];

    reg [6:0]pf1;
    reg [6:0]pf2;
    reg [6:0]pf3;
    reg [6:0]pf4;

    ele1 elevator(destinationfloor,pf1);
    ele2 elevator(destinationfloor,pf2);
    ele3 elevator(destinationfloor,pf3);
    ele4 elevator(destinationfloor,pf4);

    always(destinationfloor) 
    begin
        if(destinationfloor-pf1 < destinationfloor-pf2)
            pf1 = destinationfloor;
        else
            pf2 = destinationfloor;
        if(destinationfloor-pf3 < destinationfloor-pf4)
            pf3 = destinationfloor;
        else
            pf4 = destinationfloor;
    end
endmodule

module LIFT_tb()
    reg [11:0]intake;
    wire output;

    Controller c1(intake);

    initial begin
		#0   intake=12'b000000 000010
		#10  intake=12'b000011 000101
        #10  intake=12'b000010 000101
		#10  intake=12'b000111 001011
	end
endmodule





