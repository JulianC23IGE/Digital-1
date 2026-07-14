`timescale 1ns / 1ps

module raiz_reg_TB;

    reg clk;
    reg reset;
    reg shift_ops;
    reg load_si;
    reg load_no;
    reg [15:0] A_in;
    reg [15:0] R_next_si;
    reg [15:0] R_next_no;

    wire [15:0] A;
    wire [15:0] R;
    wire [7:0]  Q;
    wire [15:0] V;


    raiz_reg uut (
        .clk(clk), .reset(reset), .shift_ops(shift_ops), 
        .load_si(load_si), .load_no(load_no), .A_in(A_in), 
        .R_next_si(R_next_si), .R_next_no(R_next_no),
        .A(A), .R(R), .Q(Q), .V(V)
    );

    parameter PERIOD = 20;
    initial begin
        clk = 1'b0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin
        reset = 1; shift_ops = 0; load_si = 0; load_no = 0;
        A_in = 16'b1100110011001100;
        R_next_si = 16'hAAAA;
        R_next_no = 16'h5555;
        @(negedge clk);
        

        reset = 0;
        @(negedge clk);

        shift_ops = 1;
        @(negedge clk);
        shift_ops = 0;
        @(negedge clk);

        load_si = 1;
        @(negedge clk);
        load_si = 0;
        @(negedge clk);

        load_no = 1;
        @(negedge clk);
        load_no = 0;
        @(negedge clk);

        $finish;
    end

    initial begin
        $dumpfile("raiz_reg_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule