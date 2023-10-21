//错误的代码，还未解决
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT=3'd0,RIGHT=3'd1,AL_L=3'd2,AL_R=3'd3,DIG_L=3'd4,DIG_R=3'd5,DEAD=3'd6,SPLAT=3'd7;
    reg[2:0] state,next_state;
    reg[4:0] count;
    
    initial 
        count = 5'd0;
    
    always @(*) begin
        case(state)
            LEFT:begin
                count = 5'd0;
                if(~ground)
                    next_state = AL_L;
                else if(dig)
                    next_state = DIG_L;
                else if(bump_left)
                    next_state = RIGHT;
                else
                    next_state = state;
                    
            end
            RIGHT:begin
                count = 5'd0;
                if(~ground)
                    next_state = AL_R;
                else if(dig)
                    next_state = DIG_R;
                else if(bump_right)
                    next_state = LEFT;
                else
                    next_state = state;
                    
            end
            AL_L:begin
                if(count>5'd20 & ~ground)
                    next_state = SPLAT;
                else if(count <=5'd20 & ~ground)
                    next_state = AL_L;
                else
                    next_state = LEFT;
            end
            AL_R:begin
                if(count>5'd20 & ~ground)
                    next_state = SPLAT;
                else if(count <=5'd20 & ~ground)
                    next_state = AL_R;
                else
                    next_state = RIGHT;
            end
               
            DIG_L:begin next_state = ground?DIG_L:AL_L;count = 5'd0;end
            DIG_R:begin next_state = ground?DIG_R:AL_R;count = 5'd0;end
            SPLAT:begin if(ground == 1'b1)
                    next_state = DEAD;
                else begin
                    next_state = SPLAT;
                    count = count +1 ;
                end
            end
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if(areset)
            state = LEFT;
        else if(~areset&state==DEAD)
            state = state;
        else
            state = next_state;
    end
    
    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
    assign aaah = (state==AL_L)|(state==AL_R);
    assign digging = (state==DIG_L)|(state==DIG_R);

endmodule
