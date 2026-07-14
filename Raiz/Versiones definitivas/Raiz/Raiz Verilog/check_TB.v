`timescale 1ns / 1ps

module check_TB;

    reg [3:0] I;
    wire      W_I;

    check uut (
        .I(I),
        .W_I(W_I)
    );

    initial begin
        I = 4'b0000;
        #20;
        
        I = 4'b0101;
        #20;
        
        I = 4'b1111;
        #20;

        $finish;
    end

    initial begin
        $dumpfile("check_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule