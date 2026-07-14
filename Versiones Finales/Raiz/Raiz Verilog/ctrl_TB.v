`timescale 1ns / 1ps
`define SIMULATION

module ctrl_TB;

    reg clk;
    reg rst;
    reg start;
    reg W_I;
    reg W_RV;

    wire reset;
    wire shift_ops;
    wire load_si;
    wire load_no;
    wire dec;
    wire done;

    ctrl uut (
        .clk(clk), .rst(rst), .start(start), .W_I(W_I), .W_RV(W_RV),
        .reset(reset), .shift_ops(shift_ops), .load_si(load_si), 
        .load_no(load_no), .dec(dec), .done(done)
    );

    // Generador de reloj (Periodo = 20ns)
    parameter PERIOD = 20;
    initial begin
        clk = 1'b0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin
        rst = 1; start = 0; W_I = 0; W_RV = 0;
        #(PERIOD);
        
        rst = 0;
        @(negedge clk);

        start = 1;
        @(negedge clk);
        start = 0;
        
        W_I = 0; W_RV = 1; 
        @(negedge clk); // Pasa por CHECK_I -> CALC_V
        @(negedge clk); // CALC_V  -> BRANCH_RV (activa load_si)
        @(negedge clk); // BRANCH_RV -> DEC_I
        @(negedge clk); // DEC_I   -> CHECK_I

        W_RV = 0;
        @(negedge clk); // CHECK_I  -> CALC_V
        @(negedge clk); // CALC_V   -> BRANCH_RV (activa load_no)
        @(negedge clk); // BRANCH_RV -> DEC_I
        @(negedge clk); // DEC_I    -> CHECK_I

        // Fin de la rutina (W_I = 1)
        W_I = 1;
        @(negedge clk); 
        @(negedge clk);
        
        $finish;
    end

    initial begin
        $dumpfile("ctrl_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule