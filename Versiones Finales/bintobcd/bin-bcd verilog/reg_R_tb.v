`timescale 1ns / 1ps

module reg_R_tb;

    reg         clk;
    reg         rst;
    reg         load;
    reg         shift;
    reg  [15:0] bin_in;
    reg  [19:0] bcd_corrected; 
    wire [19:0] bcd_out;
    wire [15:0] bin_out;

    reg_R uut (
        .clk           (clk),
        .rst           (rst),
        .load          (load),
        .shift         (shift),
        .bin_in        (bin_in),
        .bcd_corrected (bcd_corrected),
        .bcd_out       (bcd_out),
        .bin_out       (bin_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("reg_R_tb.vcd");
        $dumpvars(0, reg_R_tb);

        clk   = 0;
        rst   = 1;
        load  = 0;
        shift = 0;
        bin_in = 16'h0000;
        bcd_corrected = 20'h00000;
        #15;

        rst    = 0;
        bin_in = 16'hAAAA;
        load   = 1;
        #10;
        
        load  = 0;
        shift = 1;
        
        #50; 

        shift = 0;
        bcd_corrected = 20'h00003; 
        #10;
        
        $finish;
    end

endmodule