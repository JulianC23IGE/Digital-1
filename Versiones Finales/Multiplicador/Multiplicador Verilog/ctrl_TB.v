`timescale 1ns / 1ps
`define SIMULATION

module ctrl_TB;
    reg clk;
    reg rst;
    reg lsb_B;
    reg start;
    reg z;
    wire done;
    wire shift;
    wire reset;
    wire add;

    ctrl uut (
        .clk(clk),
        .rst(rst),
        .lsb_B(lsb_B),
        .start(start),
        .z(z),
        .done(done),
        .shift(shift),
        .reset(reset),
        .add(add)
    );

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;

    initial begin 
        #OFFSET;
        forever begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end

    initial begin

        #0;
        rst   = 0;
        lsb_B = 0;
        start = 0;
        z     = 0;

        @(posedge clk);
        rst = 1;        
        
        @(posedge clk);
        rst = 0;        
        
        @(posedge clk);
        start = 1; // Le damos play
        
        @(posedge clk);
        start = 0; 
        lsb_B = 0; 

        @(posedge clk);
 
        @(posedge clk);


        @(posedge clk);

        
        @(posedge clk);

        @(posedge clk);
        z = 1;     

        @(posedge clk);
        // Pasa a END
        
        @(posedge clk);
        z = 0;    
        

        repeat(3) begin
            @(posedge clk);
        end
    end

    initial begin: TEST_CASE
        $dumpfile("ctrl_TB.vcd");
        $dumpvars(-1, uut);
        #(1000) $finish; 
    end

endmodule