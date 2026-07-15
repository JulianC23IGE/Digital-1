module ctrl( 
    input clk,
    input rst,
    input start, 
    input z,
    output reg done,
    output reg shift,
    output reg load,
    output reg dec,
    output reg correct
);

    parameter START   = 3'b000;
    parameter LOAD    = 3'b001;
    parameter SHIFT   = 3'b010;
    parameter CHECK   = 3'b011;
    parameter CORRECT = 3'b100;
    parameter END     = 3'b101;
 
    reg [2:0] state;

    // Lógica de salidas (Combinacional)
    always @(*) begin
        case(state)
            START: begin
                done    <= 0;
                shift   <= 0;
                load    <= 0;
                dec     <= 0;
                correct <= 0;
            end
            LOAD: begin
                done    <= 0;
                shift   <= 0;
                load    <= 1;
                dec     <= 0;
                correct <= 0;
            end   
            SHIFT: begin
                done    <= 0;
                shift   <= 1;
                load    <= 0;
                dec     <= 1;
                correct <= 0;
            end
            CHECK: begin
                done    <= 0;
                shift   <= 0;
                load    <= 0;
                dec     <= 0;
                correct <= 0;
            end
            CORRECT: begin
                done    <= 0;
                shift   <= 0;
                load    <= 0;
                dec     <= 0;
                correct <= 1;
            end
            END: begin
                done    <= 1;
                shift   <= 0;
                load    <= 0;
                dec     <= 0;
                correct <= 0;
            end
            default: begin
                done    <= 0;
                shift   <= 0;
                load    <= 0;
                dec     <= 0;
                correct <= 0;
            end
        endcase
    end

    // Lógica de siguiente estado (Secuencial en flanco de bajada)
    always @(negedge clk) begin
        if (rst) begin
            state <= START;
        end else begin
            case(state)
                START: begin
                    if(start)
                        state <= LOAD; 
                    else
                        state <= START; 
                end
                LOAD: begin
                    state <= SHIFT;
                end   
                SHIFT: begin
                    state <= CHECK;   
                end
                CHECK: begin
                    if (z)
                        state <= END;  
                    else 
                        state <= CORRECT;
                end
                CORRECT: begin
                    state <= SHIFT;
                end
                END: begin
                    if(start)
                        state <= END;
                    else
                        state <= START; 
                end
                default: state <= START;
            endcase
        end
    end
endmodule