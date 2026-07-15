module reg_R (clk, rst, bin_in, bcd_corr, load, shift, correct, R);
    input clk;
    input rst;
    input [15:0] bin_in;
    input [19:0] bcd_corr;
    input load;
    input shift;
    input correct;
    output reg [35:0] R;

    always @(posedge clk) begin
        if (rst)
            R <= 36'd0;
        else if (load)
            R <= {20'b0, bin_in};
        else if (correct)
            R <= {bcd_corr, R[15:0]};
        else if (shift)
            R <= R << 1;
    end
endmodule