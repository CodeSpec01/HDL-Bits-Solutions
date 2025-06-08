module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done);
    
    // State transition logic (combinational)
    parameter B1 = 2'd1, B2 = 2'd2, B3 = 2'd3, DONE = 2'd4;
    reg [1:0] state, next_state;
    reg [7:0]out;
    
    always @* begin
        case (state)
            B1: begin
                if(in[3]) begin
                    next_state <= B2;
                    out_bytes[23:16] <= in;
                    out <= in;
                end
                else
                    next_state = B1;
            end
            B2:begin
                next_state <= B3;
                out_bytes[15:8] <= in;
                out_bytes[23:16] <= out;
            end
            B3: begin
                next_state <= DONE;
                out_bytes[7:0] <= in;
            end
            DONE: begin
                if(in[3]) begin
                    next_state <= B2;
                    out <= in;
                end
                else
                    next_state = B1;
            end
            default: next_state = B1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk)begin
        if(reset)
            state = B1;
        else
            state = next_state;
    end
 
    // Output logic
    assign done = state == DONE;

endmodule
