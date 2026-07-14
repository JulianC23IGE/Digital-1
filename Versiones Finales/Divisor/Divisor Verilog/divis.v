module divis (
    input clk,
    input rst,
    input start,

    input [15:0] V, // Dividendo V
    input [15:0] R, // Divisor R

    output [15:0] Result, 
    output done
);
    wire reset, shift, dec, lsb_DV, r_A;
    wire W_C;
    wire W_A;
    
    wire [4:0] A_count;
    wire [15:0] Result_resta;
    wire [15:0] Reg_C;

    corriz_reg corriz_reg0 (
        .clk(clk),
        .reset(reset),
        .shift(shift),
        .r_A(r_A),
        .lsb_dv(lsb_DV), 
        .V_in(V),
        .C_in(Result_resta),
        .C(Reg_C),
        .V(Result)
    );

    rest rest0(
        .C_in(Reg_C),
        .R(R),
        .W_C(W_C),
        .C(Result_resta)
    );

    cont cont0(
        .clk(clk),
        .reset(reset),
        .dec(dec),
        .A(A_count)
    );

    check check0(
        .A(A_count),
        .W_A(W_A)
    );

    ctrl ctrl0(
        .clk(clk),
        .rst(rst),
        .start(start),
        .W_C(W_C),
        .W_A(W_A),
        .reset(reset),
        .shift(shift),
        .dec(dec),
        .lsb_DV(lsb_DV),
        .r_A(r_A),
        .done(done)
    );

endmodule