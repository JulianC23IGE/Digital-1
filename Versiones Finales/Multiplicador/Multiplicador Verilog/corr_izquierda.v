module corr_izquierda (clk , int_A , shift , load , sh_A);
  input clk;
  input [15:0] int_A;
  input load;
  input shift;
  output reg [31:0] sh_A;

always @(posedge clk) begin
  if(load)
      sh_A <= {16'b0, int_A} ;
  else begin
    if(shift) 
      sh_A <= sh_A << 1 ;
    else  
      sh_A <= sh_A;
   end
end

endmodule