module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter B=3'd1,C=3'd2,E=3'd4,F=3'd5;
    assign Y2 = (y==B) || (y==F) || (y==C&w) || (y == E & w);

endmodule
