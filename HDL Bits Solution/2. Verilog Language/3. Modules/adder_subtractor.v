module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);    
    wire [15:0] w1, w2;
    wire [31:0] t1;
    assign t1 = b ^ {32{sub}};

    wire co;
    add16(a[15:0], t1[15:0], sub, w1, co);
    add16(a[31:16], t1[31:16], co, w2);
    assign sum = {w2, w1};
endmodule
