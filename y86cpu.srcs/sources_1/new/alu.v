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
                    e_valE = aluA + aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE[`DATA_WIDTH-1];
                    OF <= (aluA[`DATA_WIDTH-1] == aluB[`DATA_WIDTH-1]) &&
                          (aluA[`DATA_WIDTH-1] != e_valE[`DATA_WIDTH-1]);
                end
            `SUBQ:
                begin
                    e_valE = aluA - aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE[`DATA_WIDTH-1];
                    OF <= (aluA[`DATA_WIDTH-1] != aluB[`DATA_WIDTH-1]) &&
                          (aluA[`DATA_WIDTH-1] != e_valE[`DATA_WIDTH-1]);
                end
            `ANDQ:
                begin
                    e_valE = aluA & aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE[`DATA_WIDTH-1];
                    OF <= 1'B0;
                end
            `XORQ:
                begin
                    e_valE = aluA ^ aluB;
                    ZF <= e_valE == 0;
                    SF <= e_valE[`DATA_WIDTH-1];
                    OF <= 1'B0;
                end
            default:
                begin
                    e_valE <= `DATA_WIDTH'H0;
                    ZF <= 1'H0;
                    SF <= 1'H0;
                    OF <= 1'H0;
                end
        endcase
    end
    
endmodule
