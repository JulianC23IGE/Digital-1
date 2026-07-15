`timescale 1ns / 1ps

module comp_zero_tb;

    reg  [3:0] data_in;
    wire       is_zero;

    comp_zero uut (
        .data_in (data_in),
        .is_zero (is_zero)
    );

    initial begin
        $dumpfile("comp_zero_tb.vcd");
        $dumpvars(0, comp_zero_tb);

        data_in = 4'd5;
        #10;
        
        data_in = 4'd10;
        #10;
        
        data_in = 4'd0; 
        #10;
        
        data_in = 4'd1;
        #10;

        $finish;
    end

endmodule