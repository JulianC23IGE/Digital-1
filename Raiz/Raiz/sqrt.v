module sqrt (
    input clk,
    input rst,
    input start,
    input [15:0] Radicando,

    output [7:0] Raiz,
    output done
);

    wire reset, shift_ops, load_si, load_no, dec;
    wire W_I, W_RV;
    
    wire [3:0]  I_count;
    wire [15:0] Reg_A;
    wire [15:0] Reg_R;
    wire [15:0] Reg_V;
    wire [15:0] R_restado;

    //========================================================
    // INSTANCIACIÓN DE LOS SUBMÓDULOS
    //========================================================

    raiz_reg raiz_reg0 (
        .clk(clk),
        .reset(reset),
        .shift_ops(shift_ops),
        .load_si(load_si),
        .load_no(load_no),
        .A_in(Radicando),
        .R_next_si(R_restado),
        .R_next_no(Reg_R),
        .A(Reg_A),
        .R(Reg_R),
        .Q(Raiz),
        .V(Reg_V)
    );

    op_artm op_artm0 (
        .R(Reg_R),
        .V(Reg_V),
        .W_RV(W_RV),
        .R_resta(R_restado)
    );

    cont cont0 (
        .clk(clk),
        .reset(reset),
        .dec(dec),
        .I(I_count)
    );

    // Conexión corregida: .W_I en lugar de .W_A
    check check0 (
        .I(I_count),
        .W_I(W_I)
    );

    ctrl ctrl0 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .W_I(W_I),
        .W_RV(W_RV),
        .reset(reset),
        .shift_ops(shift_ops),
        .load_si(load_si),
        .load_no(load_no),
        .dec(dec),
        .done(done)
    );

endmodule