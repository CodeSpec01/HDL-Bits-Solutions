module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;
    reg out;

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            present_state <= B;           // Synchronous reset to B
        end else begin
            // State transition logic
            case (present_state)
                A: next_state = (in == 1'b0) ? B : A;
                B: next_state = (in == 1'b1) ? B : A;
                default: next_state = B;
            endcase

            present_state <= next_state;  // State flip-flop update
        end
    end

    // Output logic (Moore — depends only on current state)
    always @(present_state) begin
        case (present_state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
