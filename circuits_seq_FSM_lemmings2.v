module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    //4bit,parameter
    parameter LEFT=4'b0000,RIGHT=4'b0010,AH_L=4'b0100,AH_R=4'b1000;
    reg[3:0] state,next_state;
    
    initial 
        walk_left = LEFT;
    
    always @(*) begin
        next_state = LEFT;//latch
        case(state)
            LEFT:begin
                if(~ground)
                    next_state = AH_L;
                else if(bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT:begin
                if(~ground)
                    next_state = AH_R;
                else if(bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            AH_L:next_state = ground?LEFT:AH_L;
            AH_R:next_state = ground?RIGHT:AH_R;
        endcase
    end
    //异步复位
    always @(posedge clk, posedge areset) begin
        if(areset)
            state <= LEFT;
        else begin
            state <= next_state;
        end
    end
    
    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
   // always @(posedge clk)
    // 	aaah = ~ground;
    assign aaah = (state[2]==1|state[3]==1);//单个比特比较state[2]==1'b1为什么错误
endmodule
