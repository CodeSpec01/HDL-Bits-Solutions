module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter A=1'b0, B=1'b1;
    reg state, next_state;
    reg [1:0] count, next_count;
    
    always @* begin
        next_count = 2'd0;
        case(state)
            A: begin
                next_count = count + 1'b1;
                next_state = count == 2'd3 ? B : A;
            end
            B: next_state = B;
        endcase
    end
    
    always @(posedge clk) begin
        state = reset ? A : next_state;
        count = next_count;
    end
    
    assign shift_ena = state == A;

endmodule
