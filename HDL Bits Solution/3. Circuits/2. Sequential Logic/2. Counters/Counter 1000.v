module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    
    wire [3:0] o1, o2, o3;
    assign c_enable = { o1 == 4'd9 && o2 == 4'd9,o1 == 4'd9, 1'b1};
    assign OneHertz = o1 == 4'd9 && o2 == 4'd9 && o3 == 4'd9;

    bcdcount counter0 (clk, reset, c_enable[0], o1);
    bcdcount counter1 (clk, reset, c_enable[1], o2);
    bcdcount counter2 (clk, reset, c_enable[2], o3);

endmodule
