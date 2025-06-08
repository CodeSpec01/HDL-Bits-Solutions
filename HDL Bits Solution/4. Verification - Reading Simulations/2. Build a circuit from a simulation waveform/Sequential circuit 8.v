module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    always @(negedge clock)
        q <= a;
    
    always @(clock)
        p <= clock ? a : p;

endmodule
