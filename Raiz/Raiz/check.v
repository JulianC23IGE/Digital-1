module check (
    input [3:0] I,
    output wire W_I
);

    assign W_I = (I == 4'b0000);

endmodule