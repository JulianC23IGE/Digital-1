module contador (clk, rst, load, dec, count);
    input clk;
    input rst;
    input load;
    input dec;
    output reg [4:0] count;

    always @(posedge clk) begin
        if (rst)
            count <= 5'd0;
        else if (load)
            count <= 5'd16; // 16 desplazamientos para 16 bits de salida
        else if (dec)
            count <= count - 1'b1;
    end
endmodule