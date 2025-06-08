module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    
    parameter S000=3'b000, S001=3'b001, S010=3'b010, S011=3'b011, S100=3'b100;
    reg[2:0] state, next_state;
    
    always @* begin
        case(state)
            S000: next_state = x ? S001 : S000;
            S001: next_state = x ? S100 : S001;
            S010: next_state = x ? S001 : S010;
            S011: next_state = x ? S010 : S001;
            S100: next_state = x ? S100 : S011;
            default: next_state = S000;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= S000;
        else
            state <= next_state;
    end
    
    assign z = state == S011 || state == S100;

endmodule
