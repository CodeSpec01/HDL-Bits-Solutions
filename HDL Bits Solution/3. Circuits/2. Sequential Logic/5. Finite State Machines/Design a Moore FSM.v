module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 
    reg [3:1] prev;

    always @(posedge clk) begin
        if (reset) begin
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            fr3 <= 1'b1;
            dfr <= 1'b1;   // Initial state (as if value had been low)
            prev <= 3'b000;
        end else begin
            // Update outputs based on sensor levels
            fr1 <= ~&s[3:1];    // Not all sensors high
            fr2 <= ~|s[3:2];    // S1 might be on, S2/S3 off
            fr3 <= ~|s[3:1];    // No sensor high

            // Supplemental flow logic (based on value change)
            if (s > prev)
                dfr <= 1'b0;
            else if (s < prev)
                dfr <= 1'b1;
            // else dfr remains unchanged

            // Save previous value
            prev <= s;
        end
    end
endmodule
