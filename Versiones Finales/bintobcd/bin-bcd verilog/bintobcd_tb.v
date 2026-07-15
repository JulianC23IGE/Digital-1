`timescale 1ns / 1ps

module bintobcd_tb;

    reg         clk;
    reg         rst;
    reg         start;
    reg  [15:0] bin_in;

    wire        done;
    wire [19:0] bcd_out;
    
    wire [3:0]  digit4 = bcd_out[19:16];
    wire [3:0]  digit3 = bcd_out[15:12];
    wire [3:0]  digit2 = bcd_out[11:8];
    wire [3:0]  digit1 = bcd_out[7:4];
    wire [3:0]  digit0 = bcd_out[3:0];

    bintobcd uut (
        .clk     (clk),
        .rst     (rst),
        .start   (start),
        .bin_in  (bin_in),
        .done    (done),
        .bcd_out (bcd_out)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("bintobcd_tb.vcd");
        $dumpvars(0, bintobcd_tb);

        clk    = 0;
        rst    = 1;
        start  = 0;
        bin_in = 16'd0;

        #20;
        rst = 0;
        #10;

        $display("[TB] --- Iniciando Caso 1: bin_in = 45 ---");
        bin_in = 16'd45;
        start  = 1;
        #10;
        start  = 0;

        @(posedge done);
        #1; 
        $display("[RESULTADO] Bin: %d -> BCD: %h%h%h%h%h (Esperado: 00045)", 
                  bin_in, digit4, digit3, digit2, digit1, digit0);
        #20;

        $display("[TB] --- Iniciando Caso 2: bin_in = 12345 ---");
        bin_in = 16'd12345;
        start  = 1;
        #10;
        start  = 0;

        @(posedge done);
        #1;
        $display("[RESULTADO] Bin: %d -> BCD: %h%h%h%h%h (Esperado: 12345)", 
                  bin_in, digit4, digit3, digit2, digit1, digit0);
        #20;

        $display("[TB] --- Iniciando Caso 3: bin_in = 65535 ---");
        bin_in = 16'hFFFF; // 65535 en decimal
        start  = 1;
        #10;
        start  = 0;

        @(posedge done);
        #1;
        $display("[RESULTADO] Bin: %d -> BCD: %h%h%h%h%h (Esperado: 65535)", 
                  bin_in, digit4, digit3, digit2, digit1, digit0);
        
        #40;
        $display("[TB] --- Simulación Finalizada Exitosamente ---");
        $finish;
    end

endmodule