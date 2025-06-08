module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [0:7]data;
    wire [2:0] i = {A, B, C};
    assign Z = data[i];
    
    always @(posedge clk) begin
        if(enable) begin
            data = data[0:6];
            data[0] = S;
        end
    end
            

endmodule
