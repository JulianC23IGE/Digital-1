module bcd2bin (
    input clk,
    input rst,
    input start,
    input [19:0] bcd_in, 
    output done,
    output [15:0] bin_out 
);

    // Cables de interconexión
    wire z_wire;
    wire load_wire, shift_wire, dec_wire, correct_wire;
    wire [4:0] count_wire;
    wire [35:0] R_wire;
    wire [19:0] bcd_corr_wire;

    assign bin_out = R_wire[15:0];

    ctrl U_CTRL (
        .clk     (clk),
        .rst     (rst),
        .start   (start),
        .z       (z_wire),
        .done    (done),
        .shift   (shift_wire),
        .load    (load_wire),
        .dec     (dec_wire),
        .correct (correct_wire)
    );

    contador U_CONT (
        .clk   (clk),
        .rst   (rst),
        .load  (load_wire),
        .dec   (dec_wire),
        .count (count_wire)
    );

    comp_zero U_COMP (
        .count (count_wire),
        .z     (z_wire)
    );

    corrector_bin U_CORR (
        .bcd_in  (R_wire[35:16]),
        .bcd_out (bcd_corr_wire)
    );

    reg_R U_REG (
        .clk      (clk),
        .rst      (rst),
        .bcd_in   (bcd_in),
        .bcd_corr (bcd_corr_wire),
        .load     (load_wire),
        .shift    (shift_wire),
        .correct  (correct_wire),
        .R        (R_wire)
    );

endmodule