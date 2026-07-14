`timescale 1ns / 1ps
`define SIMULATION

module ctrl_TB;

    reg clk;
    reg rst;
    reg start;
    reg W_C;
    reg W_A;

    wire reset;
    wire shift;
    wire dec;
    wire lsb_DV;
    wire r_A;
    wire done;

    ctrl uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .W_C(W_C),
        .W_A(W_A),
        .reset(reset),
        .shift(shift),
        .dec(dec),
        .lsb_DV(lsb_DV),
        .r_A(r_A),
        .done(done)
    );

    parameter PERIOD = 20;

    initial begin
        clk = 1'b0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin
        rst = 1; start = 0; W_C = 0; W_A = 0;
        #(PERIOD); 
        
        rst = 0;
        @(negedge clk);

        start = 1;
        @(negedge clk); 
        
        start = 0;      
        @(negedge clk); 
        
        // Simulamos un caso donde W_C es 1
        W_C = 1;        
        @(negedge clk); // Pasa a CHECK_C

        // Caso W_A = 0: Regresa a SHIFT_DV ---
        W_A = 0;
        @(negedge clk); // De CHECK_C regresa a SHIFT_DV
        @(negedge clk); // Pasa a ASSIGN_DV
        @(negedge clk); // Pasa a CHECK_C

        // Caso W_A = 1: Pasa a DONE_STATE ---
        W_A = 1;
        @(negedge clk); 
        
        @(negedge clk); 
        
        // Salimos de DONE_STATE hacia INIT
        @(negedge clk); // Regresa a INIT

        $finish; 
    end

    initial begin
        $dumpfile("ctrl_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule