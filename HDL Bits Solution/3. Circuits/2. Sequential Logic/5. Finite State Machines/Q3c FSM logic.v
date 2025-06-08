module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    parameter S000=3'b000, S010=3'b010, S011=3'b011, S100=3'b100;
    
    always @* begin
        Y0 <= (y == S000 || y == S010) ? x : ~x;
        z <= (y == S011 || y == S100);
    end

endmodule
