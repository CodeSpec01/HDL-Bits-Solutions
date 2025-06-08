module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    
    wire w1;
    xnor(w1, in1, in2);
    xor(out, w1, in3);

endmodule
