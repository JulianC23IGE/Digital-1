module Multip (clk , rst , start , int_A , int_B , PP , done);
  
  input rst;
  input clk;
  input start;
  input [15:0] int_A;
  input [15:0] int_B;
  output [31:0] PP;
  output done;

  wire w_SHIFT;
  wire w_RESET;
  wire w_ADD;
  wire w_Z;
  
  wire [31:0] w_A;
  wire [15:0] w_B;

 corr_derecha corr_derecha0 (
        .clk(clk), 
        .int_B(int_B), 
        .shift(w_SHIFT), 
        .load(w_RESET), 
        .sh_B(w_B)
    );
    
    corr_izquierda corr_izquierda0 (
        .clk(clk), 
        .int_A(int_A), 
        .shift(w_SHIFT), 
        .load(w_RESET), 
        .sh_A(w_A)
    );
    
    comp comp0 (
        .int_B(w_B), 
        .z(w_Z)
    );
    
    acc acc0 (
        .clk(clk), 
        .int_A(w_A), 
        .PP(PP), 
        .rst(w_RESET), // Asegúrate de que use w_RESET minúscula
        .add(w_ADD)
    );
    
    ctrl ctrl0 (
        clk,
        rst,
        w_B[0],
        start,
        w_Z,
        done,
        w_SHIFT,
        w_RESET,
        w_ADD
    );
  
endmodule