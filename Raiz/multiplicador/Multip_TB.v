`timescale 1ns / 1ps
`define BENCH

module Multip_TB;

reg clk;
reg rst;
reg start;

reg [15:0] int_A;
reg [15:0] int_B;

wire [31:0] PP;
wire done;

Multip uut(
    .rst(rst),
    .clk(clk),
    .start(start),
    .int_A(int_A),
    .int_B(int_B),
    .PP(PP),
    .done(done)
);

parameter PERIOD = 20;

initial
begin
    clk = 0;

    forever #(PERIOD/2)
        clk = ~clk;
end

initial
begin

    rst = 1;
    start = 0;

    int_A = 0;
    int_B = 0;

    #40;

    rst = 0;

    int_A = 16'd7;
    int_B = 16'd5;

    #20;
    start = 1;

    #20;
    start = 0;

    wait(done == 1);

    #40;

    $display("------------------------------------");
    $display("TEST 1");
    $display("int_A        = %d", int_A);
    $display("int_B        = %d", int_B);
    $display("Resultado= %d", PP);
    $display("Esperado = %d", int_A*int_B);
    $display("------------------------------------");


    rst = 1;
    #20;
    rst = 0;

    int_A = 16'd12;
    int_B = 16'd9;

    #20;
    start = 1;

    #20;
    start = 0;

    wait(done == 1);

    #40;

    $display("------------------------------------");
    $display("TEST 2");
    $display("int_A        = %d", int_A);
    $display("Bint_        = %d", int_B);
    $display("Resultado= %d", PP);
    $display("Esperado = %d", int_A*int_B);
    $display("------------------------------------");

    //------------------------------------------------------------------
    // TEST 3
    //------------------------------------------------------------------

    rst = 1;
    #20;
    rst = 0;

    int_A = 16'd25;
    int_B = 16'd13;

    #20;
    start = 1;

    #20;
    start = 0;

    wait(done == 1);

    #40;

    $display("------------------------------------");
    $display("TEST 3");
    $display("int_A        = %d", int_A);
    $display("int_B        = %d", int_B);
    $display("Resultado= %d", PP);
    $display("Esperado = %d", int_A*int_B);
    $display("------------------------------------");

    //------------------------------------------------------------------

    #100;
    $finish;

end

initial
begin
    $dumpfile("Multip_TB.vcd");

    $dumpvars(-1, uut);
    #(100000) $finish;

end
endmodule