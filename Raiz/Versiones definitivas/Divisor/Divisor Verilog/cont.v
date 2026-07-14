module cont (
    input clk,
    input reset,
    input dec,

    output reg [4:0] A 
);

    always @(negedge clk) begin
        if (reset) begin
            A <= 5'b10000; 
        end
        else if (dec && A != 0) begin
            A <= A - 1'b1;
        end
    end

endmodule