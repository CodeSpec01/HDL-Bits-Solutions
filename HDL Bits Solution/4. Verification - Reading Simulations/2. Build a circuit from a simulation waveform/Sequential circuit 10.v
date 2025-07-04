module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always @(posedge clk)
        state <= a ^ b ? state : a & b;
    
    assign q = a ^ b ? ~state : state;

endmodule
