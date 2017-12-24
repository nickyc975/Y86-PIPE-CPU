`include "define.v"

module decode(
    input wire [`ICODE_BUS] icode,
    input wire [`ADDR_BUS] valP,
    input wire [`REG_ADDR_BUS] d_srcA,
    input wire [`REG_ADDR_BUS] d_srcB,
    input wire [`DATA_BUS] d_rvalA,
    input wire [`DATA_BUS] d_rvalB,
    input wire [`REG_ADDR_BUS] e_dstE,
    input wire [`DATA_BUS] e_valE,
    input wire [`REG_ADDR_BUS] M_dstE,
    input wire [`DATA_BUS] M_valE,
    input wire [`REG_ADDR_BUS] M_dstM,
    input wire [`DATA_BUS] m_valM,
    input wire [`REG_ADDR_BUS] W_dstE,
    input wire [`DATA_BUS] W_valE,
    input wire [`REG_ADDR_BUS] W_dstM,
    input wire [`DATA_BUS] W_valM,
    
    output reg [`DATA_BUS] valA,
    output reg [`DATA_BUS] valB
    );
    
    always @(*)
    begin
        case(icode)
            `CALL:
                begin
                    valA <= valP;
                    valB <= d_rvalB;
                end
            `JXX:
                begin
                     valA <= valP;
                     valB <= d_rvalB;
                end
            `HALT:
                begin
                    valA <= `DATA_WIDTH'H0;
                    valB <= `DATA_WIDTH'H0;
                end
            `NOP:
                begin
                    valA <= `DATA_WIDTH'H0;
                    valB <= `DATA_WIDTH'H0;
                end
            default:
                begin
                    case(d_srcA)
                        e_dstE:     valA <= e_valE;
                        M_dstM:     valA <= m_valM;
                        M_dstE:     valA <= M_valE;
                        W_dstE:     valA <= W_valE;
                        W_dstM:     valA <= W_valM;
                        default:    valA <= d_rvalA;
                    endcase
                                
                    case(d_srcB)
                        e_dstE:     valB <= e_valE;
                        M_dstM:     valB <= m_valM;
                        M_dstE:     valB <= M_valE;
                        W_dstE:     valB <= W_valE;
                        W_dstM:     valB <= W_valM;
                        default:    valB <= d_rvalB;
                    endcase
                end
        endcase
    end 
endmodule
