module reg_R (clk, rst, bcd_in, bcd_corr, load, shift, correct, R);
    input clk;
    input rst;
    input [19:0] bcd_in;
    input [19:0] bcd_corr;
    input load;
    input shift;
    input correct;
    output reg [35:0] R;

    always @(posedge clk) begin
        if (rst)
            R <= 36'd0;
        else if (load)
            R <= {bcd_in, 16'd0}; // R = {BCD, BIN=0}
        else if (correct)
            R <= {bcd_corr, R[15:0]}; // Se actualiza solo la parte BCD
        else if (shift)
            R <= R >> 1; // Corrimiento a la derecha
    end
endmodule