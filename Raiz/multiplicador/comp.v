module comp (int_B,z);
  input [15:0] int_B;
  output z;
  
  assign z = (int_B==0) ? 1'b1 : 1'b0;

endmodule
