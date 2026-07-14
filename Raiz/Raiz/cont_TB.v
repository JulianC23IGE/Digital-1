`timescale 1ns / 1ps

module cont_TB;

    reg clk;
    reg reset;
    reg dec;
    wire [3:0] I;

    cont uut (
        .clk(clk),
        .reset(reset),
        .dec(dec),
        .I(I)
    );

    parameter PERIOD = 20;
    initial begin
        clk = 1'b0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin
        reset = 1; dec = 0;
        @(negedge clk);
        
        reset = 0;
        @(negedge clk);

        dec = 1;
        @(negedge clk); // I = 7
        @(negedge clk); // I = 6
        @(negedge clk); // I = 5
        
        dec = 0;
        @(negedge clk); // I mantiene su valor
        @(negedge clk);

        dec = 1;
        @(negedge clk); // I = 4

        $finish;
    end

    initial begin
        $dumpfile("cont_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule