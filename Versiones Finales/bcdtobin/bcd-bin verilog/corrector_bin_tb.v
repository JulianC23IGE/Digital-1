`timescale 1ns / 1ps
`define SIMULATION

module corrector_bin_tb;

    reg  [19:0] bcd_in;
    wire [19:0] bcd_out;

    corrector_bin uut(
        .bcd_in(bcd_in),
        .bcd_out(bcd_out)
    );

    initial begin
        bcd_in = 20'h01234;
        #20;
        bcd_in = 20'h00009;
        #20;
        bcd_in = 20'h89080;
        #20;
        $finish;
    end

    initial begin
        $dumpfile("corrector_bin_tb.vcd");
        $dumpvars(-1, uut);
    end

endmodule