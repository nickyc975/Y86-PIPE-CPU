`include "define.v"

module alu_args(
    input wire [`ICODE_BUS] E_icode,
    input wire [`IFUN_BUS] E_ifun,
    input wire [`DATA_BUS] E_valC,
    input wire [`DATA_BUS] E_valA,
    input wire [`DATA_BUS] E_valB,
    
    output reg [`DATA_BUS] aluA,
    output reg [`DATA_BUS] aluB,
    output reg [`IFUN_BUS] fun
    );
    
    always @(*)
        begin
            case(E_icode)
                `CXX:
                    begin
                        aluA <= E_valA;
                        aluB <= `DATA_WIDTH'H0;
                        fun <= `ADDQ;
                    end
                `IXX:
                    begin
                        aluA <= E_valB;
                        if(E_ifun == `IRMOVQ)
                        begin
                            aluB <= `DATA_WIDTH'H0;
                            fun <= `ADDQ;
                        end
                        else
                        begin
                            aluB <= E_valC;
                            fun <= E_ifun - 1;
                        end
                    end
                `OPQ:
                    begin
                        aluA <= E_valB;
                        aluB <= E_valA;
                        fun <= E_ifun;
                    end
                `RMMOVQ:
                    begin
                        aluA <= E_valA;
                        aluB <= E_valC;
                        fun <= `ADDQ;
                    end
                `MRMOVQ:
                    begin
                        aluA <= E_valB;
                        aluB <= E_valC;
                        fun <= `ADDQ;
                    end
                `JXX:
                    begin
                        aluA <= `DATA_WIDTH'H0;
                        aluB <= `DATA_WIDTH'H0;
                        fun <= `NOPQ;
                    end
                `CALL:
                    begin   
                        aluA <= E_valB;
                        aluB <= -`DATA_WIDTH'H8;
                        fun <= `ADDQ;
                    end
                `RET:
                    begin
                        aluA <= E_valB;
                        aluB <= `DATA_WIDTH'H8;
                        fun <= `ADDQ;
                    end
                `PUSHQ:
                    begin   
                        aluA <= E_valB;
                        aluB <= -`DATA_WIDTH'H8;
                        fun <= `ADDQ;
                    end
                `POPQ:
                    begin
                        aluA <= E_valB;
                        aluB <= `DATA_WIDTH'H8;
                        fun <= `ADDQ;
                    end
                default:
                    begin
                        aluA <= `DATA_WIDTH'H0;
                        aluB <= `DATA_WIDTH'H0;
                        fun <= `NOPQ;
                    end
            endcase
        end
    
endmodule