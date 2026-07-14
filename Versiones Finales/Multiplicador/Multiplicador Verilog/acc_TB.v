`timescale 1ns / 1ps
`define SIMULATION

module acc_TB;

    reg         clk;
    reg  [31:0] A;
    reg         add;
    reg         rst;

    wire [31:0] pp;

    acc uut (
        .clk(clk),
        .int_A(A),
        .add(add),
        .rst(rst),
        .PP(pp)
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
        #0;
        A   = 32'd0;
        add = 0;
        rst = 0;

        @(posedge clk);
        rst = 1;        
        A   = 32'd50;   
        add = 1;

        @(posedge clk);
        rst = 0;        
        A   = 32'd10;    
        add = 1;

        @(posedge clk);
        A   = 32'd25;    
        add = 1;

        @(posedge clk);
        A   = 32'd100;   
        add = 0;         

        @(posedge clk);
        A   = 32'd5;     
        add = 1;

        @(posedge clk);
        rst = 1;         
        repeat(2) begin
            @(posedge clk);
        end
    end

    initial begin: TEST_CASE
        $dumpfile("acc_TB.vcd");
        $dumpvars(-1, uut);
        #(1000) $finish; 
    end

endmodule