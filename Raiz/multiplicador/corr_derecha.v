module corr_derecha (clk , int_B , shift , load , sh_B);
  input clk;
  input [15:0]int_B;
  input load;
  input shift;
  output reg [15:0]sh_B;

always @(posedge clk)
  if(load)
     sh_B = int_B ;
  else
   begin
    if(shift) sh_B = sh_B >> 1 ;
    else  sh_B = sh_B;
   end
endmodule