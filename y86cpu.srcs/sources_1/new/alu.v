`include "define.v"

module alu(
    input wire [`DATA_BUS] aluA,
    input wire [`DATA_BUS] aluB,
    input wire [`IFUN_BUS] fun,
    
    output reg [`DATA_BUS] e_valE,
    output reg ZF,
    output reg SF,
    output reg OF
    );
    
    always @(*)
    begin
        case(fun)
            `ADDQ:
                begin
                    e_valE <= aluA + aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE < 0;
                    OF <= (aluA > 0 && aluB > 0 && e_valE <= 0)
                          || (aluA < 0 && aluB < 0 && e_valE >= 0);
                end
            `SUBQ:
                begin
                    e_valE <= aluA - aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE < 0;
                    OF <= (aluA >= 0 && aluB < 0 && e_valE <= 0)
                          || (aluA < 0 && aluB > 0 && e_valE >= 0);
                end
            `ANDQ:
                begin
                    e_valE <= aluA & aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE < 0;
                    OF <= 1'B0;
                end
            `XORQ:
                begin
                    e_valE <= aluA ^ aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE < 0;
                    OF <= 1'B0;
                end
            default:
                begin
                end
        endcase
    end
    
endmodule
