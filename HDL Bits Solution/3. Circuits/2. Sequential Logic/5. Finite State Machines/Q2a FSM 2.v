module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    parameter A = 2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0] state, next_state;
    
    always @* begin
        case(state)
            A: begin
                casez(r)
                    3'bzz1: next_state = B;
                    3'bz10: next_state = C;
                    3'b100: next_state = D;
                    default: next_state = A;
                endcase
            end
            B: next_state = r[1] ? B : A;
            C: next_state = r[2] ? C : A;
            D: next_state = r[3] ? D : A;
        endcase
    end
    
    always @(posedge clk) 
        state <= resetn ? next_state : A;
    
    assign g = {(state == D), (state == C), (state == B)};

endmodule
