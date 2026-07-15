`timescale 1ns / 1ps
`define SIMULATION

module bcd2bin_TB;


    reg         clk;
    reg         rst;
    reg         start;
    reg  [19:0] bcd_in;

    wire        done;
    wire [15:0] bin_out;

    bcd2bin uut( 
        .clk(clk), 
        .rst(rst), 
        .start(start), 
        .bcd_in(bcd_in),
        .done(done),
        .bin_out(bin_out)
    );

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial  begin  // Process for clk
        #OFFSET;
        forever
        begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end


    initial begin
        #0 rst = 1; start = 0; bcd_in = 20'h00000;
        @(posedge clk);
        rst  = 0;
        @(posedge clk);

        @(posedge clk);
        bcd_in = 20'h12345;
        start  = 1;
        @(posedge clk);
        start  = 0;
        
        @(posedge done); 
        #(PERIOD * 3);   

        @(posedge clk);
        bcd_in = 20'h00045;
        start  = 1;
        @(posedge clk);
        start  = 0;
        
        @(posedge done);
        #(PERIOD * 3);

        @(posedge clk);
        bcd_in = 20'h65535;
        start  = 1;
        @(posedge clk);
        start  = 0;
        
        @(posedge done);
        #(PERIOD * 3);
        
        $finish; 
    end

    initial begin: TEST_CASE
        $dumpfile("bcd2bin_tb.vcd");
        $dumpvars(-1, uut);
        #(15000) $finish;
    end

endmodule