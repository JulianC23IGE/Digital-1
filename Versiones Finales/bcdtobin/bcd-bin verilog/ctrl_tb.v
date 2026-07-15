`timescale 1ns / 1ps
`define SIMULATION

module ctrl_tb;

    reg clk;
    reg rst;
    reg start;
    reg z;

    wire done;
    wire shift;
    wire load;
    wire dec;
    wire correct;

    ctrl uut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .z(z),
        .done(done),
        .shift(shift),
        .load(load),
        .dec(dec),
        .correct(correct)
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
        #0 rst = 1; start = 0; z = 0;
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        #(PERIOD * 4);
        @(posedge clk);
        z = 1;
        @(posedge done);
        #(PERIOD * 2);
        $finish;
    end

    initial begin
        $dumpfile("ctrl_tb.vcd");
        $dumpvars(-1, uut);
        #(5000) $finish;
    end

endmodule