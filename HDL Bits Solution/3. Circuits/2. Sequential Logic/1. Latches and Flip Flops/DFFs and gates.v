module top_module (
    input clk,
    input x,
    output z
); 
    
    reg q1 = 0;
    reg q2 = 0;
    reg q3 = 0;
    wire w1, w2, w3;
    assign w1 = x ^ q1;
    assign w2 = x & ~q2;
    assign w3 = x | ~q3;
    
    assign z = ~(q1 | q2 | q3);
    dff(w1, clk, q1);
    dff(w2, clk, q2);
    dff(w3, clk, q3);

endmodule

module dff(input d, input clk, output q);
    
    always @(posedge clk) begin
        q = d;
    end
    
endmodule
