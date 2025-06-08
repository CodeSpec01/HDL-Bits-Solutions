module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    
    reg t;
    
    always @(posedge clk)begin
        if(reset)
            q <= 32'h1;
        else begin
            t = q[0];
            q = q[31:1];
            q[31] = t;
            q[21] = q[21] ^ t;
            q[1] = q[1] ^ t;
            q[0] = q[0] ^ t;
        end
    end

endmodule
