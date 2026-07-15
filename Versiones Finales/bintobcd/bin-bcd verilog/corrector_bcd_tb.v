`timescale 1ns / 1ps

module corrector_bcd_tb;

    reg  [3:0] bcd_in;
    wire [3:0] bcd_out;

    corrector_bcd uut (
        .bcd_in  (bcd_in),
        .bcd_out (bcd_out)
    );

    integer i;

    initial begin
        $dumpfile("corrector_bcd_tb.vcd");
        $dumpvars(0, corrector_bcd_tb);


        for (i = 0; i < 10; i = i + 1) begin
            bcd_in = i;
            #10;
            if (bcd_in > 4 && bcd_out != bcd_in + 3)
                $display("ERROR en %d", bcd_in);
            else if (bcd_in <= 4 && bcd_out != bcd_in)
                $display("ERROR en %d", bcd_in);
        end

        $finish;
    end

endmodule