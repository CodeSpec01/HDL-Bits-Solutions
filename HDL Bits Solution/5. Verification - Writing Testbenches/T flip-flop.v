module top_module ();
    
    reg clk, reset, t;
    wire q;
    
    tff I1(clk, reset, t, q);
    
    initial begin
        clk = 0;
        reset = 1;
        t = 0;
        #10 reset = 0;t=1;
    end
    
    always #5 clk = ~clk;
    always #10 t = ~t;

endmodule
