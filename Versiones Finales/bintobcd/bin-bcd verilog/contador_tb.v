`timescale 1ns / 1ps

module contador_tb;

    reg        clk;
    reg        rst;
    reg        load;
    reg        en;
    wire [3:0] count;
    wire       tc; 

    contador uut (
        .clk   (clk),
        .rst   (rst),
        .load  (load),
        .en    (en),
        .count (count),
        .tc    (tc)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("contador_tb.vcd");
        $dumpvars(0, contador_tb);

        clk  = 0;
        rst  = 1;
        load = 0;
        en   = 0;
        #15;

        rst  = 0;
        load = 1;
        #10;

        load = 0;
        en   = 1;

        @(posedge tc);
        #20;

        $finish;
    end

endmodule