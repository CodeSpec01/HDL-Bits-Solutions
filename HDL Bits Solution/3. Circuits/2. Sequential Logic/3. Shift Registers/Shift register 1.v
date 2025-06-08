module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg [3:0] t = 4'd0;
    assign out = t[0];
    
    always @(posedge clk)begin
        if(~resetn)
            t <= 4'd0;
        else begin
            t <= t[3:1];
            t[3] <= in;
        end
    end

endmodule
