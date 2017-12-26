`include "define.v"

module alu_args(
    input wire [`ICODE_BUS] E_icode_i,
    input wire [`IFUN_BUS] E_ifun_i,
    input wire [`DATA_BUS] E_valC_i,
    input wire [`DATA_BUS] E_valA_i,
    input wire [`DATA_BUS] E_valB_i,
    
    output reg [`DATA_BUS] aluA_o,
    output reg [`DATA_BUS] aluB_o,
    output reg [`IFUN_BUS] fun_o
    );
    
    always @(*)
        begin
            case(E_icode_i)
                `CXX:
                    begin
                        aluA_o = E_valA_i;
                        aluB_o = `DATA_WIDTH'H0;
                        fun_o = `ADDQ;
                    end
                `IXX:
                    begin
                        aluB_o = E_valC_i;
                        if(E_ifun_i == `IRMOVQ)
                        begin
                            aluA_o = `DATA_WIDTH'H0;
                            fun_o = `ADDQ;
                        end
                        else
                        begin
                            aluA_o = E_valB_i;
                            fun_o = E_ifun_i - 1;
                        end
                    end
                `OPQ:
                    begin
                        aluA_o = E_valB_i;
                        aluB_o = E_valA_i;
                        fun_o = E_ifun_i;
                    end
                `RMMOVQ:
                    begin
                        aluA_o = E_valB_i;
                        aluB_o = E_valC_i;
                        fun_o = `ADDQ;
                    end
                `MRMOVQ:
                    begin
                        aluA_o = E_valA_i;
                        aluB_o = E_valC_i;
                        fun_o = `ADDQ;
                    end
                `JXX:
                    begin
                        aluA_o = `DATA_WIDTH'H0;
                        aluB_o = `DATA_WIDTH'H0;
                        fun_o = `NOPQ;
                    end
                `CALL:
                    begin   
                        aluA_o = E_valB_i;
                        aluB_o = -`DATA_WIDTH'H8;
                        fun_o = `ADDQ;
                    end
                `RET:
                    begin
                        aluA_o = E_valB_i;
                        aluB_o = `DATA_WIDTH'H8;
                        fun_o = `ADDQ;
                    end
                `PUSHQ:
                    begin   
                        aluA_o = E_valB_i;
                        aluB_o = -`DATA_WIDTH'H8;
                        fun_o = `ADDQ;
                    end
                `POPQ:
                    begin
                        aluA_o = E_valB_i;
                        aluB_o = `DATA_WIDTH'H8;
                        fun_o = `ADDQ;
                    end
                default:
                    begin
                        aluA_o = `DATA_WIDTH'H0;
                        aluB_o = `DATA_WIDTH'H0;
                        fun_o = `NOPQ;
                    end
            endcase
        end
    
endmodule