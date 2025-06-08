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
    
         
    parameter WALK_LEFT = 3'd0, WALK_RIGHT = 3'd1, FALL_LEFT = 3'd2, FALL_RIGHT = 3'd3, DIG_LEFT = 3'd4, DIG_RIGHT = 3'd5, DEAD = 3'd6;
    reg [2:0]state, next_state;
    reg [4:0] timer;
    
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if(timer >= 5'd20)
                        next_state = DEAD;
                    else
                    	next_state = WALK_LEFT;
                end
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if(timer >= 5'd20)
                        next_state = DEAD;
                    else
                    	next_state = WALK_RIGHT;
                end
                else
                    next_state = FALL_RIGHT;
            end
            DIG_LEFT: begin
                if(~ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if(~ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            DEAD: next_state = DEAD;
            default: next_state = state;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)begin
            state <= WALK_LEFT;
            timer <= 5'd0;
        end
        else begin
            state <= next_state;
            if(state == FALL_LEFT || state == FALL_RIGHT)begin
                if(timer <= 20)
                    timer = timer + 1;
            end
            else begin
                timer = 5'd0;
            end
        end
    end

    assign walk_left  = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
    assign digging = (state == DIG_LEFT) || (state == DIG_RIGHT);

endmodule
