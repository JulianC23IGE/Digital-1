module raiz_reg (
    input clk,
    input reset,
    input shift_ops,
    input load_si,
    input load_no,

    input [15:0] A_in,
    input [15:0] R_next_si,
    input [15:0] R_next_no,

    output reg [15:0] A,
    output reg [15:0] R,
    output reg [7:0]  Q,
    output [15:0] V
);

    // V = (Q << 2) + 1 combinacional
    assign V = { {6{1'b0}}, Q, 2'b00 } + 16'd1;

    always @(negedge clk) begin
        if (reset) begin
            A <= A_in; // A = n (Radicando)
            R <= 16'd0; // R = 0
            Q <= 8'd0;  // Q = 0
        end
        else if (shift_ops) begin
            // Hace el paso: R = (R << 2) + Bits de A y desplaza A hacia la izquierda 2 bits
            R <= { R[13:0], A[15:14] };
            A <= { A[13:0], 2'b00 };
        end
        else if (load_si) begin
            // Bloque SI: R = R - V y Q = (Q << 1) + 1
            R <= R_next_si;
            Q <= { Q[6:0], 1'b1 };
        end
        else if (load_no) begin
            // Bloque NO: Q = Q << 1 (
            Q <= { Q[6:0], 1'b0 };
        end
    end

endmodule