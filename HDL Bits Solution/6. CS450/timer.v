module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] count;
    always @(posedge clk) begin
        tc <= 1'b0;
        if(load)
            count = data;
        if (count == 10'd0)
            tc <= 1'b1;
        else
            count = count - 1'b1;
    end

endmodule
