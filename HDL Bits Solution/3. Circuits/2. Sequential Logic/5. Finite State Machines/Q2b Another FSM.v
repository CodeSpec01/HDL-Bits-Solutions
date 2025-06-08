module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
); 
    
    parameter S0=4'd0, S1=4'd1,S2=4'd2,S3=4'd3,S4=4'd4,S5=4'd5,S6=4'd6,S7=4'd7,S8=4'd8;
    reg [3:0] state, next_state;
    
    always @* begin
        f = 1'b0;
        g = 1'b0;
        case(state)
            S0: next_state = S1;
            S1: begin
                next_state = S2;
                f = 1'b1;
            end
            S2: next_state = x ? S3 : S2;
            S3: next_state = x ? S3 : S4;
            S4: next_state = x ? S5 : S2;
            S5: begin
                g = 1'b1;
                next_state = y ? S7 : S6;
            end
            S6: begin
                g = 1'b1;
                next_state = y ? S7 : S8;
            end
            S7: begin
                g = 1'b1;
                next_state = S7;
            end
            S8: next_state = S8;
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk) begin
        state <= resetn ? next_state : S0;
    end
                    

endmodule
