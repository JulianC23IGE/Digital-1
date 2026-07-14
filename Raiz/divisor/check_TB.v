`timescale 1ns / 1ps

module check_TB;


    reg [4:0] A;    
    wire      W_A;

    check uut( .A(A), .W_A(W_A) );

    initial begin
        A = 5'd0;    
        #20;         
        
        A = 5'd15;   
        #20;         
        
        A = 5'd31;   
        #20;         
        
      
        A = 5'd0;    
        #20;         

        $finish; 
    end

    initial begin
        $dumpfile("check_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule