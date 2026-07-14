module check (
    input [4:0] A,  
    output W_A       // W_A si A == 0
);

    assign W_A = (A == 0);

endmodule