module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    
    genvar i;
    generate 
        for(i = 0; i < 8; i = i + 1) begin : somename
            singlebit (in[i], clk, pedge[i]);
        end
    endgenerate

endmodule

module singlebit(input in, input clk, output reg out);
    
    reg prev;
    always @(posedge clk)begin
        out <= in & ~prev;
        prev <= in;
    end
    
endmodule
