module op_artm (
    input [15:0] R,
    input [15:0] V,
    
    output W_RV,            // R >= V?
    output [15:0] R_resta   // R - V
);

    assign W_RV = (R >= V);
    assign R_resta = R - V;

endmodule