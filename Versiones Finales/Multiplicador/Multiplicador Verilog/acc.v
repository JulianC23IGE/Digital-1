module acc (
    input clk, 
    input [31:0] int_A, 
    input add, 
    input rst, 
    output reg [31:0] PP
);
    always @(posedge clk) begin
    if (rst) 
        PP <= 32'h00000000;
    else if (add) 
        PP <= PP + int_A;
end

endmodule