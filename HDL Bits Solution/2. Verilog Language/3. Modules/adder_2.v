module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum

);//
    
    wire [15:0] w1, w2;
    wire co1, co2;
    
    add16(a[15:0], b[15:0], 0, w1, co1);
    add16(a[31:16], b[31:16], co1, w2, co2);
    
    assign sum = {w2, w1};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
    
    assign sum = a ^ b ^ cin;
    assign cout = (a&b)|(a&cin)|(b&cin);

endmodule
