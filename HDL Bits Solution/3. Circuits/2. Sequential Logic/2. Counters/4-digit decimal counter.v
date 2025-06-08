module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q
);
    wire unused;
    
    bcdcounter c1(clk, 1'b1, reset, ena[1], q[3:0]);
    bcdcounter c2(clk, ena[1], reset, ena[2], q[7:4]);
    bcdcounter c3(clk, ena[2], reset, ena[3], q[11:8]);
    bcdcounter c4(clk, ena[3], reset, unused, q[15:12]);

endmodule

module bcdcounter (
    input clk,
    input enable,
    input reset,
    output ena,
    output reg [3:0] q
);
    assign ena = (q == 4'd9) && enable;  // Combinational output

    always @(posedge clk) begin
        if (reset)
            q <= 4'd0;
        else if (enable) begin
            if (q == 4'd9)
                q <= 4'd0;
            else
                q <= q + 1;
        end
    end
endmodule

