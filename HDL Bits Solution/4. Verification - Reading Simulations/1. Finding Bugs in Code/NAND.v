module top_module (input a, input b, input c, output out);//
    
    wire w;

    andgate inst1 ( w, b, c, 1'b1, 1'b1, a );
    not(out, w);

endmodule
