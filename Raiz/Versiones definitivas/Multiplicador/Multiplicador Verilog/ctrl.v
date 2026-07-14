module ctrl( 
    input clk,
    input rst,
    input lsb_B,
    input start, 
    input z,
    output reg done,
    output reg shift,
    output reg reset,
    output reg add 
);

    parameter START = 3'b000;
    parameter CHECK = 3'b001;
    parameter SHIFT = 3'b010;
    parameter ADD   = 3'b011;
    parameter END   = 3'b100;
 
    reg [2:0] state;
    reg [3:0] count;

    always @(*) begin
             case(state)

                START: begin
                    done  <= 0;
                    shift <= 0;
                    reset <= 1;
                    add   <= 0;
                    count <= 0;
                end

                CHECK: begin
                    done  <= 0;
                    shift <= 0;
                    reset <= 0;
                    add   <= 0;
                    
                end   

                SHIFT: begin
                    done  <= 0;
                    shift <= 1;
                    reset <= 0;
                    add   <= 0;
                end

                ADD: begin
                    done  <= 0;
                    shift <= 0;
                    reset <= 0;
                    add   <= 1;
                end

                END: begin
                    done  <= 1; // CORREGIDO: Usar <=
                    shift <= 0; // CORREGIDO: Usar <=
                    reset <= 0; // CORREGIDO: Usar <=
                    add   <= 0; // CORREGIDO: Usar <=
                end

                default: begin
                    done  <= 0;
                    shift <= 0;
                    reset <= 0;
                    add   <= 0;
                end
            endcase
   
    end

    always @(negedge clk) begin
        if (rst) begin
        end else begin
            case(state)

                START: begin
                    count <= 0; 
                    if(start)
                        state <= CHECK; 
                    else
                        state <= START; 
                end

                CHECK: begin
                    if (z) begin
                        state <= END;  
                    end else if (lsb_B) begin
                        state <= ADD;
                    end else begin
                        state <= SHIFT;   
                    end
                end   

                SHIFT: begin
                    state <= CHECK;   
                end

                ADD: begin
                    state <= SHIFT;
                end

                END: begin
                    count <= count + 1'b1;
                    state <= START; 
                end

                default: state <= START;
            endcase
        end
    end

    `ifdef BENCH
    reg [8*40:1] state_name;
    always @(*) begin
        case(state)
            START  : state_name = "START";
            CHECK  : state_name = "CHECK";
            SHIFT  : state_name = "SHIFT";
            ADD    : state_name = "ADD";
            END    : state_name = "END";
            default: state_name = "UNKNOWN";
        endcase
    end
    `endif

endmodule
