module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter P0=4'd0,P1=4'd1,P2=4'd2,P3=4'd3,S0=4'd4,S1=4'd5,S2=4'd6,S3=4'd7,C0=4'd8,D0=4'd9;
    reg [3:0] state, next_state;
    
    always @* begin
        case(state)
            P0: next_state = data ? P1 : P0;
            P1: next_state = data ? P2 : P0;
            P2: next_state = data ? P2 : P3;
            P3: next_state = data ? S0 : P0;
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = C0;
            C0: next_state = done_counting ? D0 : C0;
            D0: next_state = ack ? P0 : D0;
            default: next_state = P0;
        endcase
    end
    
    always @(posedge clk)
        state <= reset ? P0 : next_state;
    
    assign shift_ena = (state == S0 || state == S1 || state == S2 || state == S3);
    assign counting = state == C0;
    assign done = state == D0;

endmodule
