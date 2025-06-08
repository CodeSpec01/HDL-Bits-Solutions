module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4;
    reg [2:0] state, next_state;
    
    always @* begin
        case(state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;
        endcase
    end
    
    always @(posedge clk) begin
        state <= reset ? S0 : next_state;
    end
    
    assign start_shifting = state == S4;

endmodule
