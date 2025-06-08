module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter S0=2'd0, S1=2'd1, S2=2'd2, S3=2'd3;
    reg [1:0]state, next_state, count, count_next;
    reg z_next, z_reg;
    
    always @* begin
        next_state = state;
        count_next = count;
        z_next = 1'd0;
        case(state)
            S0: begin 
                next_state = s ? S1 : S0;
                count_next = 2'd0;
            end
            S1: begin
                count_next = w ? count + 1 : count;
                next_state = S2;
            end
            S2: begin
                count_next = w ? count + 1 : count;
                next_state = S3;
            end
            S3: begin
                count_next = w ? count + 1 : count;
                next_state = S1;
                if(count_next == 2'd2)
                    z_next = 1'd1;
                count_next = 1'd0;
            end
            default: begin
                count_next = 2'd0;
                next_state = S0;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= S0;
            count <= 2'd0;
            z_reg <= 1'd0;
        end
        else begin
            state <= next_state;
            count <= count_next;
            z_reg <= z_next;
        end
    end
    
    assign z = z_reg;

endmodule
