`timescale 1ns/1ps

module divis_TB;

    reg clk;
    reg rst;
    reg start;

    reg [15:0] V; // Antes A (Dividendo)
    reg [15:0] R; // Antes B (Divisor)

    wire [15:0] Result;
    wire done;

    divis uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .V(V),
        .R(R),
        .Result(Result),
        .done(done)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin

        // Inicialización
        rst   = 1;
        start = 0;
        V     = 0;
        R     = 0;

        #20;

        rst = 0;

        @(negedge clk);
        V = 16'd25;
        R = 16'd5;

        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);

        #20;

        $display("----------------------------------");
        $display("CASO 1");
        $display("V (Dividendo) = %d", V);
        $display("R (Divisor)   = %d", R);
        $display("Resultado     = %d", Result);
        $display("----------------------------------");

        rst = 1;
        #20;
        rst = 0;

        @(negedge clk);
        V = 16'd100;
        R = 16'd4;

        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);

        #20;

        $display("----------------------------------");
        $display("CASO 2");
        $display("V (Dividendo) = %d", V);
        $display("R (Divisor)   = %d", R);
        $display("Resultado     = %d", Result);
        $display("----------------------------------");

        rst = 1;
        #20;
        rst = 0;

        @(negedge clk);
        V = 16'd17;
        R = 16'd3;

        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);

        #20;

        $display("----------------------------------");
        $display("CASO 3");
        $display("V (Dividendo) = %d", V);
        $display("R (Divisor)   = %d", R);
        $display("Resultado     = %d", Result);
        $display("----------------------------------");


        #100;

        $finish;

    end

    initial begin
        $dumpfile("divis_TB.vcd");
        $dumpvars(0, divis_TB);
    end

endmodule