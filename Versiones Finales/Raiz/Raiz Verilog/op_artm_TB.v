`timescale 1ns / 1ps

module op_artm_TB;

    reg [15:0] R;
    reg [15:0] V;

    wire        W_RV;
    wire [15:0] R_resta;

    op_artm uut (
        .R(R),
        .V(V),
        .W_RV(W_RV),
        .R_resta(R_resta)
    );

    initial begin
        R = 16'd20;
        V = 16'd5;
        #20;
        
        R = 16'd10;
        V = 16'd10;
        #20;
        
        R = 16'd4;
        V = 16'd9;
        #20;

        $finish;
    end

    initial begin
        $dumpfile("op_artm_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule