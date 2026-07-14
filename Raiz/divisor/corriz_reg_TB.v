`timescale 1ns / 1ps

module corriz_reg_TB;


    reg clk;
    reg reset;
    reg shift;
    reg r_A;
    reg lsb_dv;
    reg [15:0] V_in;
    reg [15:0] C_in;


    wire [15:0] C;
    wire [15:0] V;


    corriz_reg uut (
        .clk(clk),
        .reset(reset),
        .shift(shift),
        .r_A(r_A),
        .lsb_dv(lsb_dv),
        .V_in(V_in),
        .C_in(C_in),
        .C(C),
        .V(V)
    );


    parameter PERIOD = 20;


    initial begin
        clk = 1'b0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin

        reset = 1; shift = 0; r_A = 0; lsb_dv = 0;
        V_in = 16'hA5A5; 
        C_in = 16'h0000;
        @(negedge clk);
        
        reset = 0;
        @(negedge clk);

        shift = 1;
        @(negedge clk); // Desplaza 1 bit a la izquierda
        @(negedge clk); // Desplaza otro bit
        shift = 0;       // Apagamos el shift
        @(negedge clk);

        
        C_in = 16'hF0F0;
        lsb_dv = 1;
        r_A = 1;
        @(negedge clk);
        r_A = 0;
        @(negedge clk);

        C_in = 16'h1234;
        lsb_dv = 0;
        r_A = 1;
        @(negedge clk);
        r_A = 0;
        @(negedge clk);

        $finish; 
    end
    initial begin
        $dumpfile("corriz_reg_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule