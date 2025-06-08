module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic
    reg [3:0]state;

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset)begin
        if(areset)begin
            state <= 4'd1;
        end
        else begin
            state[0] <= state[0]&~in | state[2]&~in;
            state[1] <= state[0]&in | state[1]&in | state[3]&in;
            state[2] <= state[1]&~in | state[3]&~in;
            state[3] <= state[2]&in;
        end
    end

    // Output logic
    assign out = state[3];
    
endmodule
