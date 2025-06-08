module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] w1, w2, w3;
    my_dff8(clk, d, w1);
    my_dff8(clk, w1, w2);
    my_dff8(clk, w2, w3);
    
    always @(sel)
        begin
            if (sel == 0)
                q = d;
            else if (sel == 1)
                q = w1;
            else if (sel == 2)
                q = w2;
            else
                q = w3;
        end

endmodule
