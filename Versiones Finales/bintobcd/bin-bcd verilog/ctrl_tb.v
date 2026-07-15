`timescale 1ns / 1ps

module ctrl_tb;

    reg  clk;
    reg  rst;
    reg  start;
    reg  count_done;

    wire load;
    wire shift;
    wire en_count;
    wire load_count;
    wire done;

    ctrl uut (
        .clk        (clk),
        .rst        (rst),
        .start      (start),
        .count_done (count_done),
        .load       (load),
        .shift      (shift),
        .en_count   (en_count),
        .load_count (load_count),
        .done       (done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("ctrl_tb.vcd");
        $dumpvars(0, ctrl_tb);

        clk        = 0;
        rst        = 1;
        start      = 0;
        count_done = 0;

        #15;
        rst = 0;

        #10;
        start = 1;
        #10;
        start = 0;


        #50;
        

        count_done = 1;
        #10;
        count_done = 0;


        @(posedge done);
        #20;

        $finish;
    end

endmodule