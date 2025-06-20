module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    
    reg [31:0] prev;
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'd0;
        end else begin
            out <= out | prev & ~in;
        end
        prev <= in;
    end

endmodule
