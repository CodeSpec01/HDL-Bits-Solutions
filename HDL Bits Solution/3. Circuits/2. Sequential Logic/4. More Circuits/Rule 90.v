module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q );
    
    reg [511:0] t1 = 512'd0;
    reg [511:0] t2 = 512'd0;
    
    integer i;
    always @(posedge clk) begin
        if(load) begin
            q <= data;
            t1 <= data[511:1];
            t2 <= {data[510:0], 1'b0};
        end
        else begin
            q = t1 ^ t2;
            t1 <= q[511:1];
            t2 <= {q[510:0], 1'b0};
        end
    end
                

endmodule
