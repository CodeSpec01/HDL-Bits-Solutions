module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] w1, w2, w3;
    wire co;
    add16(a[15:0], b[15:0], 0, w1, co);
    add16(a[31:16], b[31:16], 0, w2);
    add16(a[31:16], b[31:16], 1, w3);
    always @(co)
        begin
            case(co)
                1'b0: sum = {w2, w1};
                1'b1: sum = {w3, w1};
            endcase
        end
endmodule
