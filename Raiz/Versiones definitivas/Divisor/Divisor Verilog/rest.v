module rest(
    input  [15:0] C_in,  // Entrada del Registro C
    input  [15:0] R,     // Entrada del Divisor R

    output reg W_C,      
    output reg [15:0] C  
);

    reg [15:0] temp;

    always @(*) begin
        // Evalúa la condición ¿C < 0?
        if (C_in[15] == 1'b1) begin
            temp = C_in + R;          
        end else begin
            temp = C_in + (~R) + 16'd1; 
        end

        C   = temp;
        W_C = temp[15]; 
    end

endmodule