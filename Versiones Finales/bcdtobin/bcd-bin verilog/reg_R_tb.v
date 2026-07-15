`timescale 1ns / 1ps
`define SIMULATION

module reg_R_tb;

    reg clk;
    reg rst;
    reg load;
    reg shift;
    reg correct;
    reg [19:0] bcd_in;
    reg [19:0] bcd_corr;

    wire [35:0] R_out;

    reg_R uut(
        .clk(clk),
        .rst(rst),
        .load(load),
        .shift(shift),
        .correct(correct),
        .bcd_in(bcd_in),
        .bcd_corr(bcd_corr),
        .R_out(R_out)
    );

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial begin
        #OFFSET;
        forever begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end

    initial begin
        #0 rst = 1; load = 0; shift = 0; correct = 0; bcd_in = 0; bcd_corr = 0;
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        bcd_in = 20'h12345;
        load = 1;
        @(posedge clk);
        load = 0;
        @(posedge clk);
        bcd_corr = 20'h55555;
        correct = 1;
        @(posedge clk);
        correct = 0;
        @(posedge clk);
        shift = 1;
        @(posedge clk);
        @(posedge clk);
        shift = 0;
        #(PERIOD * 2);
        $finish;
    end

    initial begin
        $dumpfile("reg_R_tb.vcd");
        $dumpvars(-1, uut);
        #(3000) $finish;
    end

endmodule