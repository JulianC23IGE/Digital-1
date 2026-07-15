module comp_zero (count, z);
    input [4:0] count;
    output z;
    
    assign z = (count == 0) ? 1'b1 : 1'b0;
endmodule