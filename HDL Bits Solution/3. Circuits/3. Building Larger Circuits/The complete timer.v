module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter P0=4'd0,P1=4'd1,P2=4'd2,P3=4'd3,S0=4'd4,S1=4'd5,S2=4'd6,S3=4'd7,C0=4'd8,D0=4'd9;
    reg [3:0] state, next_state, count_next;
    reg [9:0] timer_reg, timer_next;
    
    always @* begin
        timer_next = 10'd0;
        count_next = count;
        case(state)
            P0: next_state = data ? P1 : P0;
            P1: next_state = data ? P2 : P0;
            P2: next_state = data ? P2 : P3;
            P3: next_state = data ? S0 : P0;
            S0: begin
                count_next[3] = data;
                next_state = S1;
            end
            S1: begin
                next_state = S2;
                count_next[2] = data;
            end
            S2: begin
                count_next[1] = data;
                next_state = S3;
            end
            S3: begin
                count_next[0] = data;
                next_state = C0;
            end
            C0: begin
                if(timer_reg == 10'd999) begin
                    timer_next = 10'd0;
                    if(count == 4'd0)
                        next_state = D0;
                    else begin
                        count_next = count - 1'b1;
                        next_state = C0;
                    end
                end
                else begin
                    next_state = C0;
                    timer_next = timer_reg + 1'b1;
                end
            end
            D0: next_state = ack ? P0 : D0;
            default: next_state = P0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= P0;
            count <= 4'd0;
            timer_reg <= 10'd0;
        end
        else begin
            state <= next_state;
            count <= count_next;
            timer_reg <= timer_next;
        end
    end
    
    assign counting = state == C0;
    assign done = state == D0;

endmodule
