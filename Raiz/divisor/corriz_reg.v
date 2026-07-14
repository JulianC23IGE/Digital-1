module corriz_reg(
    input clk,
    input reset,
    input shift,
    input r_A,
    input lsb_dv,

    input [15:0] V_in,   
    input [15:0] C_in,   

    output reg [15:0] C,
    output [15:0] V     
);

    reg [15:0] V_reg;

    assign V = V_reg;

    always @(negedge clk) begin
        if (reset) begin
            C     <= 16'd0; // C = 0
            V_reg <= V_in;  // Load V
        end
        else if (shift) begin
            {C, V_reg} <= {C, V_reg} << 1; 
        end
        else if (r_A) begin
            C <= C_in;
            if (lsb_dv)
                V_reg[0] <= 1'b1; 
            else
                V_reg[0] <= 1'b0;
        end
    end

endmodule