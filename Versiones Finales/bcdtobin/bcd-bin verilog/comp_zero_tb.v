`timescale 1ns / 1ps
`define SIMULATION

module comp_zero_tb;

    reg [4:0] count_in;
    wire z_out;

    comp_zero uut(
        .count_in(count_in),
        .z_out(z_out)
    );

    initial begin
        count_in = 5'b01010;
        #20;
        count_in = 5'b00001;
        #20;
        count_in = 5'b00000;
        #20;
        $finish;
    end

    initial begin
        $dumpfile("comp_zero_tb.vcd");
        $dumpvars(-1, uut);
    end

endmodule