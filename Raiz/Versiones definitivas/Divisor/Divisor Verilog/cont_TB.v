`timescale 1ns / 1ps

module cont_TB;

    reg clk;
    reg reset;
    reg dec;

    wire [4:0] A;

    cont uut( 
        .clk(clk), 
        .reset(reset), 
        .dec(dec), 
        .A(A) 
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
        @(negedge clk); // A baja a 15
        
        @(negedge clk); // A baja a 14
        @(negedge clk); // A baja a 13
        @(negedge clk); // A baja a 12
        
        dec = 0;
        @(negedge clk); // A se mantiene en 12
        @(negedge clk); // A se mantiene en 12

        dec = 1;
        @(negedge clk); // A baja a 11
        
        $finish; 
    end

    initial begin
        $dumpfile("cont_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule