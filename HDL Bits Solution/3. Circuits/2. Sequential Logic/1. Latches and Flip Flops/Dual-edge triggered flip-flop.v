module top_module (
    input clk,
    input d,
    output reg q
);
    reg q_pos, q_neg;
    always @(posedge clk) q_pos <= d;
    always @(negedge clk) q_neg <= d;
    always @(clk)begin
        if(~clk)
            q <= q_neg;
        else
            q <= q_pos;
    end

endmodule
