`include "define.v"

module alu(
    input wire [`DATA_BUS] aluA_i,
    input wire [`DATA_BUS] aluB_i,
    input wire [`IFUN_BUS] fun_i,
    
    output reg [`DATA_BUS] e_valE_o,
    output reg ZF_o,
    output reg SF_o,
    output reg OF_o
    );
    
    always @(*)
    begin
        case(fun_i)
            `ADDQ:
                begin
                    e_valE_o = aluA_i + aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[`DATA_WIDTH-1];
                    OF_o = (aluA_i[`DATA_WIDTH-1] == aluB_i[`DATA_WIDTH-1]) &&
                           (aluA_i[`DATA_WIDTH-1] != e_valE_o[`DATA_WIDTH-1]);
                end
            `SUBQ:
                begin
                    e_valE_o = aluA_i - aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[`DATA_WIDTH-1];
                    OF_o = (aluA_i[`DATA_WIDTH-1] != aluB_i[`DATA_WIDTH-1]) &&
                           (aluA_i[`DATA_WIDTH-1] != e_valE_o[`DATA_WIDTH-1]);
                end
            `ANDQ:
                begin
                    e_valE_o = aluA_i & aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[`DATA_WIDTH-1];
                    OF_o = `FALSE;
                end
            `XORQ:
                begin
                    e_valE_o = aluA_i ^ aluB_i;
                    ZF_o = e_valE_o == 0;
                    SF_o = e_valE_o[`DATA_WIDTH-1];
                    OF_o = `FALSE;
                end
            default:
                begin
                    e_valE_o = `DATA_ZERO;
                    ZF_o = `FALSE;
                    SF_o = `FALSE;
                    OF_o = `FALSE;
                end
        endcase
    end
    
endmodule
