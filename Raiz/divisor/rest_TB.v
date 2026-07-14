`timescale 1ns / 1ps

module rest_TB;

    reg [15:0] C_in;
    reg [15:0] R;

    wire        W_C;
    wire [15:0] C;

    rest uut (
        .C_in(C_in),
        .R(R),
        .W_C(W_C),
        .C(C)
    );

    initial begin
        C_in = 16'd20;
        R    = 16'd5;
        #20;

        C_in = 16'd5;
        R    = 16'd12;
        #20;

        C_in = 16'hFFF6; 
        R    = 16'd15;
        #20;

        C_in = 16'hFFEC;
        R    = 16'd4;
        #20;

        $finish; 
    end

    initial begin
        $dumpfile("rest_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule