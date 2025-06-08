module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    parameter S0 = 10'd1, S1 = 10'd2, S2 = 10'd4, S3 = 10'd8, S4 = 10'd16, S5 = 10'd32, S6 = 10'd64, S7 = 10'd128, S8 = 10'd256, S9 = 10'd512;
    
   always @(*) begin
       next_state = 10'd0;
       if(state[0])begin
           if(in)
               next_state[1] = 1;
           else
				next_state[0] = 1;
       end
        if(state[1]) begin
           if(in)
               next_state[2] = 1; 
           else
               next_state[0] = 1;
       end
        if(state[2]) begin
           if(in)
               next_state[3] = 1;
           else
               next_state[0] = 1;
       end
        if(state[3]) begin
           if(in)
               next_state[4] = 1;
               else
                   next_state[0] = 1;
       end
        if(state[4]) begin
           if(in)
               next_state[5] = 1;
           else
               next_state[0] = 1;
       end
        if(state[5]) begin
           if(in)
               next_state[6] = 1;
           else
               next_state[8] = 1;
       end
        if(state[6]) begin
           if(in)
               next_state[7] = 1;
           else
               next_state[9] = 1;
       end
        if(state[7]) begin
           if(in)
               next_state[7] = 1;
           else
               next_state[0] = 1;
       end
        if(state[8]) begin
           if(in)
               next_state[1] = 1;
           else
               next_state[0] = 1;
       end
        if(state[9]) begin
           if(in)
               next_state[1] = 1;
               else
                   next_state[0] = 1;
       end
    end

    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];

endmodule
