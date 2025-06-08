module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);

    always @(posedge clk) begin
        if(shift_ena)begin
            q <= {q, data};
        end
        else if (count_ena) begin
            q <= q - 1'b1;
        end
        else
            q <= q;
    end
        
endmodule
