module corrector_bin (bcd_in, bcd_out);
    input [19:0] bcd_in;
    output reg [19:0] bcd_out;

    always @(*) begin
        // Dígito 0 (Unidades BCD)
        if (bcd_in[3:0] >= 4'd8)
            bcd_out[3:0] = bcd_in[3:0] - 4'd3;
        else
            bcd_out[3:0] = bcd_in[3:0];

        // Dígito 1 (Decenas BCD)
        if (bcd_in[7:4] >= 4'd8)
            bcd_out[7:4] = bcd_in[7:4] - 4'd3;
        else
            bcd_out[7:4] = bcd_in[7:4];

        // Dígito 2 (Centenas BCD)
        if (bcd_in[11:8] >= 4'd8)
            bcd_out[11:8] = bcd_in[11:8] - 4'd3;
        else
            bcd_out[11:8] = bcd_in[11:8];

        // Dígito 3 (Millares BCD)
        if (bcd_in[15:12] >= 4'd8)
            bcd_out[15:12] = bcd_in[15:12] - 4'd3;
        else
            bcd_out[15:12] = bcd_in[15:12];

        // Dígito 4 (Decenas de millar BCD)
        if (bcd_in[19:16] >= 4'd8)
            bcd_out[19:16] = bcd_in[19:16] - 4'd3;
        else
            bcd_out[19:16] = bcd_in[19:16];
    end
endmodule