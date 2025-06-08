module top_module (
    input clk,
    input reset,
    input in,
    output reg [7:0] out_byte,
    output reg done
);

    parameter START=3'd0, DATA=3'd1, PARITY=3'd2, CHECK=3'd4, STOP=3'd5;
    reg [2:0] state, next_state, counter, counter_next;
    reg done_reg, done_reg_next;
    
    always @* begin
        counter_next = counter;
        done_reg_next = 1'd0;
        case(state)
            START: begin
                counter_next <= 3'd0;
                next_state = in ? START : DATA;
            end
            DATA: begin
                counter_next = counter + 1;
                out_byte[counter] = in;
                next_state = counter == 3'd7 ? PARITY : DATA;
            end
            PARITY: begin
                counter_next <= 3'd0;
                next_state = ^out_byte ^ in ? CHECK : STOP;
            end
            CHECK: begin
                counter_next <= 3'd0;
                next_state = in ? START : STOP;
                done_reg_next = in;
            end
            STOP: begin
                counter_next = 3'd0;
                next_state = in ? START : STOP;
            end
            default: begin
                next_state = START;
                counter_next <= 3'd0;
                done_reg = 1'd0;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= START;
            counter <= 3'd0;
            done_reg <= 1'd0;
        end
        else begin
            state <= next_state;
            counter <= counter_next;
            done_reg <= done_reg_next;
        end
    end
    
    assign done = done_reg;

endmodule