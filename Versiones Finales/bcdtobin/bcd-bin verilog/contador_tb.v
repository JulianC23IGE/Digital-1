`timescale 1ns / 1ps
`define SIMULATION

module contador_tb;

    reg clk;
    reg rst;
    reg load;
    reg dec;

    wire [4:0] count_out;

    contador uut(
        .clk(clk),
        .rst(rst),
        .load(load),
        .dec(dec),
        .count_out(count_out)
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
        #0 rst = 1; load = 0; dec = 0;
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        load = 1;
        @(posedge clk);
        load = 0;
        @(posedge clk);
        dec = 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        dec = 0;
        #(PERIOD * 2);
        $finish;
    end

    initial begin
        $dumpfile("contador_tb.vcd");
        $dumpvars(-1, uut);
        #(2000) $finish;
    end

endmodule