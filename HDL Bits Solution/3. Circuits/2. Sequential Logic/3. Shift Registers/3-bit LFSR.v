module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    wire qi1, qi2, qi3;
    
    submodule s1(KEY[0], KEY[1], SW[0], LEDR[2], LEDR[0]);
    submodule s2(KEY[0], KEY[1], SW[1], LEDR[0], LEDR[1]);
    submodule s3(KEY[0], KEY[1], SW[2], LEDR[1] ^ LEDR[2], LEDR[2]);
        
endmodule
        
module submodule (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    always @(posedge clk) begin
        Q = L ? r_in : q_in;
    end

endmodule