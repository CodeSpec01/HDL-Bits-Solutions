module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state, next_state;
    reg [2:0] bit_count, bit_count_next;
    reg done_reg, done_reg_next;
    
    always @(*) begin
        bit_count_next = bit_count;
        done_reg_next = 1'b0;
        
        case (state)
            S0: begin
                bit_count_next = 3'b000;
                if (in == 1'b0)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                bit_count_next = bit_count_next + 1;
                out_byte[bit_count] = in;
				if (bit_count == 3'd7)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                bit_count_next = 3'b000;
                if (in == 1'b1) begin
                    next_state = S0;
                    done_reg_next  = 1'b1;
                end else begin
                    next_state = S3;
                end
            end

            S3: begin
                bit_count_next = 3'b000;

                if (in == 1'b1) 
                    next_state = S0;
                else
                    next_state = S3;
            end

            default: begin
                next_state = S0;
                bit_count_next = 3'b000;
                done_reg_next = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
            bit_count <= bit_count_next;
            done_reg <= done_reg_next;
        end
    end

    assign done = done_reg;

endmodule
