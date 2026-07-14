module cont (
    input clk,
    input reset,
    input dec,

    output reg [3:0] I
);

    always @(negedge clk) begin
        if (reset) begin
            I <= 4'b1000; // I = n/2 = 8 iteraciones para 16 bits
        end
        else if (dec && I != 0) begin
            I <= I - 1'b1; // I = I - 1
        end
    end

endmodule
