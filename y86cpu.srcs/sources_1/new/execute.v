`include "define.v"

module execute(
    input wire [`STAT_BUS] W_stat,
    input wire [`STAT_BUS] m_stat,
    input wire [`ICODE_BUS] E_icode,
    input wire [`IFUN_BUS] E_ifun,
    input wire [`DATA_BUS] E_valC,
    input wire [`DATA_BUS] E_valA,
    input wire [`DATA_BUS] E_valB,
    input wire [`REG_ADDR_BUS] E_dstE,
    
    output reg e_Cnd,
    output reg [`DATA_BUS] e_valE,
    output reg [`DATA_BUS] e_valA,
    output reg [`REG_ADDR_BUS] e_dstE
    );
    
    reg [`DATA_BUS] aluA;
    reg [`DATA_BUS] aluB;
    always @(*)
        begin
            case(E_icode)
                `CXX:
                    begin
                        aluA <= E_valA;
                        aluB <= `DATA_WIDTH'H0;
                    end
                {`IXX, `OPQ}:
                    begin
                        aluA <= E_valA;
                        aluB <= E_valB;
                    end
                `RMMOVQ:
                    begin
                        aluA <= E_valA;
                        aluB <= E_valC;
                    end
                `MRMOVQ:
                    begin
                        aluA <= E_valB;
                        aluB <= E_valC;
                    end
                `JXX:
                    begin
                        aluA <= `DATA_WIDTH'H0;
                        aluB <= `DATA_WIDTH'H0;
                    end
                {`CALL, `PUSHQ}:
                    begin   
                        aluA <= E_valB;
                        aluB <= -`DATA_WIDTH'H8;
                    end
                {`RET, `POPQ}:
                    begin
                        aluA <= E_valB;
                        aluB <= `DATA_WIDTH'H8;
                    end
                default:
                    begin
                        aluA <= `DATA_WIDTH'H0;
                        aluB <= `DATA_WIDTH'H0;
                    end
            endcase
        end
    
endmodule
