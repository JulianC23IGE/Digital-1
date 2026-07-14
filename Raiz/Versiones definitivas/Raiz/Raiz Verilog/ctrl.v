module ctrl (
    input clk,
    input rst,
    input start,
    input W_I,   // Indica si I == 0
    input W_RV,  // Indica si R >= V

    output reg reset,
    output reg shift_ops,
    output reg load_si,
    output reg load_no,
    output reg dec,
    output reg done
);

    parameter INIT        = 3'b000,
              CHECK_I     = 3'b001,
              CALC_V      = 3'b010,
              BRANCH_RV   = 3'b011,
              DEC_I       = 3'b100,
              DONE_STATE  = 3'b101;

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
                    if (start) state <= CHECK_I;
                    else       state <= INIT;
                end

                CHECK_I: begin
                    if (W_I) state <= DONE_STATE; // SI -> DONE
                    else     state <= CALC_V;      // No -> Continúa el algoritmo
                end

                CALC_V: begin
                    // Realiza síncronamente: R = (R << 2) + Bits de A
                    state <= BRANCH_RV;
                end

                BRANCH_RV: begin
                    // Dependiendo de R >= V, guardará un camino u otro
                    state <= DEC_I;
                end

                DEC_I: begin
                    // Decrementa I = I - 1 y regresa a evaluar
                    state <= CHECK_I;
                end

                DONE_STATE: begin
                    if (!start) state <= INIT;
                    else        state <= DONE_STATE;
                end

                default: state <= INIT;
            endcase
        end
    end

    //====================================================
    // LÓGICA COMBINACIONAL DE SALIDAS
    //====================================================
    always @(*) begin
        reset     = 0;
        shift_ops = 0;
        load_si   = 0;
        load_no   = 0;
        dec       = 0;
        done      = 0;

        case (state)
            INIT: begin
                reset = 1;
            end

            CALC_V: begin
                shift_ops = 1; // Hace el paso previo a comparar
            end

            BRANCH_RV: begin
                if (W_RV) load_si = 1; // SI: R = R - V; Q = (Q << 1) + 1
                else      load_no = 1; // NO: Q = Q << 1
            end

            DEC_I: begin
                dec = 1; // Resta una iteración al contador (I = I - 1)
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
            INIT       : state_name = "INIT";
            CHECK_I    : state_name = "CHECK_I";
            CALC_V     : state_name = "CALC_V";
            BRANCH_RV  : state_name = "BRANCH_RV";
            DEC_I      : state_name = "DEC_I";
            DONE_STATE : state_name = "DONE_STATE";
            default    : state_name = "UNKNOWN";
        endcase
    end
    `endif

endmodule