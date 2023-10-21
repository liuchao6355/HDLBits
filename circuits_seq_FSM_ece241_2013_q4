module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
   	parameter below_S1=2'b00,S1_S2=2'b01,S2_S3=2'b10,above_S3=2'b11;
    reg[1:0] state,next_state;
    always @(*)begin
        case(s)
            3'b111:next_state = above_S3;
            3'b011:next_state = S2_S3;
            3'b001:next_state = S1_S2;
            default:next_state = below_S1;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= below_S1;
        else
            state <= next_state;
    end
    
    assign fr1 = (state==S2_S3)|(state==S1_S2)|(state==below_S1);
    assign fr2 = (state==S1_S2)|(state==below_S1);
    assign fr3 = (state==below_S1);
    //assign dfr = state>=next_state;
    always@(posedge clk)begin
        if(reset)
            dfr <= 1;
        else if(next_state < state)
            dfr <= 1;
        else if(next_state > state)
            dfr <= 0;
        else
            dfr <= dfr;
    end
endmodule
