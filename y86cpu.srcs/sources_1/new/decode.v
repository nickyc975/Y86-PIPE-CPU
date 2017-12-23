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
            {`CALL, `JXX}:
                begin
                    valA <= valP;
                    valB <= d_rvalB;
                end
            {`HALT, `NOP}:
                begin
                    valA <= `DATA_WIDTH'H0;
                    valB <= `DATA_WIDTH'H0;
                end
            default:
                begin
                if(d_srcA == e_dstE)
                begin
                    valA <= e_valE;
                end
                else if(d_srcA == M_dstM)
                begin
                    valA <= m_valM;
                end
                else if(d_srcA == M_dstE)
                begin
                    valA <= M_valE;
                end
                else if(d_srcA == W_dstE)
                begin
                    valA <= W_valE;
                end
                else if(d_srcA == W_dstM)
                begin
                    valA <= W_valM;
                end
                else
                begin
                    valA <= d_rvalA;
                end
                    
                if(d_srcB == e_dstE)
                begin
                    valB <= e_valE;
                end
                else if(d_srcB == M_dstM)
                begin
                    valB <= m_valM;
                end
                else if(d_srcB == M_dstE)
                begin
                    valB <= M_valE;
                end
                else if(d_srcB == W_dstE)
                begin
                    valB <= W_valE;
                end
                else if(d_srcB == W_dstM)
                begin
                    valB <= W_valM;
                end
                else
                begin
                    valB <= d_rvalB;
                end
                end
        endcase
    end 
endmodule
