module ctrl (
    input clk,
    input rst,
    input start,
    input W_C,   
    input W_A,   

    output reg reset,
    output reg shift,
    output reg dec,
    output reg lsb_DV,
    output reg r_A,
    output reg done
);

    parameter INIT       = 3'b000,
              SHIFT_DV   = 3'b001,
              ASSIGN_DV  = 3'b010,
              CHECK_C    = 3'b011,
              DONE_STATE = 3'b100;

    reg [2:0] state;

    //====================================================
    // FSM SECUENCIAL
    //====================================================
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= INIT;
        end
        else begin
            case (state)
                INIT: begin
                    if (start)
                        state <= SHIFT_DV;
                    else
                        state <= INIT;
                end

                SHIFT_DV: begin
                    state <= ASSIGN_DV;
                end

                ASSIGN_DV: begin
                    state <= CHECK_C;
                end

                CHECK_C: begin
                    if (W_A) 
                        state <= DONE_STATE;
                    else
                        state <= SHIFT_DV;
                end

                DONE_STATE: begin
                    if (!start)
                        state <= INIT;
                    else
                        state <= DONE_STATE;
                end

                default: state <= INIT;
            endcase
        end
    end

    always @(*) begin
        reset  = 0;
        shift  = 0;
        dec    = 0;
        lsb_DV = 0;
        r_A    = 0;
        done   = 0;

        case (state)
            INIT: begin
                reset = 1;
            end

            SHIFT_DV: begin
                shift = 1;
            end

            ASSIGN_DV: begin
                r_A    = 1;
                dec    = 1;
                lsb_DV = ~W_C;
            end

            DONE_STATE: begin
                done = 1;
            end
        endcase
    end

    `ifdef BENCH
    reg [8*40:1] state_name;
    always @(*) begin
        case(state)
            INIT        : state_name = "INIT";
            SHIFT_DV    : state_name = "SHIFT_DV";
            ASSIGN_DV   : state_name = "ASSIGN_DV";
            CHECK_C     : state_name = "CHECK_C";
            DONE_STATE  : state_name = "DONE_STATE";
            default     : state_name = "UNKNOWN";
        endcase
    end
    `endif

endmodule