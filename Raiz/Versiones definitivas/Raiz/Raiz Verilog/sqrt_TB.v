`timescale 1ns/1ps

module sqrt_TB;

    reg clk;
    reg rst;
    reg start;

    reg [15:0] Radicando; 

    wire [7:0]  Raiz;
    wire done;

    //========================================================
    // INSTANCIA DEL DUT - CORREGIDA CON EL MÓDULO DE RAÍZ CUADRADA
    //========================================================

    sqrt uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .Radicando(Radicando),
        .Raiz(Raiz),
        .done(done)
    );

    //========================================================
    // GENERADOR DE CLOCK
    //========================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //========================================================
    // ESTÍMULOS
    //========================================================

    initial begin

        // Inicialización
        rst       = 1;
        start     = 0;
        Radicando = 0;

        #20;

        rst = 0;

        //====================================================
        // CASO 1: Raíz exacta
        // sqrt(144) = 12
        //====================================================

        @(negedge clk);
        Radicando = 16'd144;

        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);

        #20;

        $display("----------------------------------");
        $display("CASO 1");
        $display("Radicando (A) = %d", Radicando);
        $display("Raiz (Q)      = %d", Raiz);
        $display("----------------------------------");

        //====================================================
        // CASO 2: Raíz exacta menor
        // sqrt(25) = 5
        //====================================================

        rst = 1;
        #20;
        rst = 0;

        @(negedge clk);
        Radicando = 16'd25;

        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);

        #20;

        $display("----------------------------------");
        $display("CASO 2");
        $display("Radicando (A) = %d", Radicando);
        $display("Raiz (Q)      = %d", Raiz);
        $display("----------------------------------");

        //====================================================
        // CASO 3: Raíz inexacta (Truncada)
        // sqrt(10) = 3 (Ya que 3^2 = 9)
        //====================================================

        rst = 1;
        #20;
        rst = 0;

        @(negedge clk);
        Radicando = 16'd10;

        @(negedge clk);
        start = 1;

        @(negedge clk);
        start = 0;

        wait(done);

        #20;

        $display("----------------------------------");
        $display("CASO 3");
        $display("Radicando (A) = %d", Radicando);
        $display("Raiz (Q)      = %d", Raiz);
        $display("----------------------------------");

        //====================================================
        // FINALIZAR SIMULACIÓN
        //====================================================

        #100;

        $finish;

    end

    initial begin
        $dumpfile("sqrt_TB.vcd");
        $dumpvars(0, sqrt_TB);
    end

endmodule