`timescale 1ns / 1ps
`define SIMULATION

module comp_TB;

    reg  [15:0] B; 
    wire  z;  

    reg  clk; 

    comp uut (
        .B(B), 
        .w_Z(z)
    );

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial begin  // Process for clk
        #OFFSET;
        forever begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end


    initial begin
        #0 B = 16'd2567; // z debería ser 0
        
        @(negedge clk);
        B = 16'd0;       

        @(negedge clk);
        B = 16'd1;      

        @(negedge clk);
        B = 16'hFFFF;   

        repeat(2) begin
            @(negedge clk);
        end
    end

    initial begin: TEST_CASE
        $dumpfile("comp_TB.vcd");
        $dumpvars(-1, uut);
        #(1000) $finish;
    end

endmodule