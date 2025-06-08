module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [2:0] cout;

    fa(x[0], y[0], 0, sum[0], cout[0]);
    fa(x[1], y[1], cout[0], sum[1], cout[1]);
    fa(x[2], y[2], cout[1], sum[2], cout[2]);
    fa(x[3], y[3], cout[2], sum[3], sum[4]);

endmodule

module fa(input a, input b, input cin, output sum, output cout);
    
    assign sum = a ^ b ^ cin;
    assign cout = a&b | a&cin | b&cin;
    
endmodule
