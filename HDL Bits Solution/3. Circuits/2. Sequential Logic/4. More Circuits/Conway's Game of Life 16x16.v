module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [255:0] next_q;

    integer i, j, r, c, idx, n_idx;
    integer di, dj;
    integer neighbors;

    always @(*) begin
        next_q = q;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = 0;

                for (di = -1; di <= 1; di = di + 1) begin
                    for (dj = -1; dj <= 1; dj = dj + 1) begin
                        if (di == 0 && dj == 0)
                            continue;

                        r = (i + di + 16) % 16;
                        c = (j + dj + 16) % 16;
                        n_idx = r * 16 + c;

                        neighbors = neighbors + q[n_idx];
                    end
                end

                idx = i * 16 + j;
                if (neighbors < 2 || neighbors > 3)
                    next_q[idx] = 0;
                else if (neighbors == 3)
                    next_q[idx] = 1;
                else
                    next_q[idx] = q[idx];
            end
        end
    end
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
            

endmodule
