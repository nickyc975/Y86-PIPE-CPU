`include "define.v"

module fetch(
    input wire [`ADDR_BUS] f_pc_i,
    input wire [`INST_BUS] inst_i,
    input wire mem_error_i,
    
    output reg [`ICODE_BUS] f_icode_o,
    output reg [`IFUN_BUS] f_ifun_o,
    output reg [`REG_ADDR_BUS] f_rA_o,
    output reg [`REG_ADDR_BUS] f_rB_o,
    output reg [`DATA_BUS] f_valC_o,
    output reg [`ADDR_BUS] f_valP_o,
    output reg [`REG_ADDR_BUS] f_dstE_o,
    output reg [`REG_ADDR_BUS] f_dstM_o,
    output reg [`ADDR_BUS] f_predPC_o,
    output reg [`STAT_BUS] f_stat_o
    
    );
    
    always @(f_pc_i, inst_i, mem_error_i)
    begin
        f_icode_o = inst_i[`ICODE];
        f_ifun_o = inst_i[`IFUN];
        f_rA_o = `NREG;
        f_rB_o = `NREG;
        f_valC_o = `DATA_ZERO;
        f_valP_o = `DATA_ZERO;
        f_dstE_o = `NREG;
        f_dstM_o = `NREG;
        f_stat_o = `SAOK;
        f_predPC_o = `ADDR_ZERO;
        if(mem_error_i == `FALSE)
        begin
            case(f_icode_o)
                `HALT:
                    begin
                        f_stat_o = `SHLT;
                    end
                `NOP:
                    begin
                        f_stat_o = `SAOK;
                    end
                `CXX:
                    begin
                        f_rA_o = inst_i[`SRCA];
                        f_rB_o = inst_i[`SRCB];
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H2;
                        f_predPC_o = f_valP_o;
                        f_dstE_o = f_rB_o;
                        f_stat_o = `SAOK;
                    end
                `OPQ:
                    begin
                        f_rA_o = inst_i[`SRCA];
                        f_rB_o = inst_i[`SRCB];
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H2;
                        f_predPC_o = f_valP_o;
                        f_dstE_o = f_rB_o;
                        f_stat_o = `SAOK;
                    end
                `IXX:
                    begin
                        f_rA_o = inst_i[`SRCA];
                        f_rB_o = inst_i[`SRCB];
                        f_valC_o = {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                                    inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                        f_valP_o = f_pc_i + `ADDR_WIDTH'HA;
                        f_predPC_o = f_valP_o;
                        f_dstE_o = f_rB_o;
                        f_stat_o = `SAOK;
                    end
                `RMMOVQ:
                    begin
                        f_rA_o = inst_i[`SRCA];
                        f_rB_o = inst_i[`SRCB];
                        f_valC_o = {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                                    inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                        f_valP_o = f_pc_i + `ADDR_WIDTH'HA;
                        f_predPC_o = f_valP_o;
                        f_stat_o = `SAOK;
                    end
                `MRMOVQ:
                    begin
                        f_rA_o = inst_i[`SRCA];
                        f_rB_o = inst_i[`SRCB];
                        f_valC_o = {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                                    inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                        f_valP_o = f_pc_i + `ADDR_WIDTH'HA;
                        f_predPC_o = f_valP_o;
                        f_dstM_o = f_rB_o;
                        f_stat_o = `SAOK;
                    end
                `JXX:
                    begin
                        f_valC_o = {inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3], inst_i[`BYTE4],
                                    inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7], inst_i[`BYTE8]};
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H9;
                        f_predPC_o = f_valC_o;
                        f_stat_o = `SAOK;
                    end
                 `CALL:
                    begin
                        f_rA_o = `RSP;
                        f_rB_o = `RSP;
                        f_valC_o = {inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3], inst_i[`BYTE4],
                                    inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7], inst_i[`BYTE8]};
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H9;
                        f_predPC_o = f_valC_o;
                        f_dstM_o = `RSP;
                        f_stat_o = `SAOK;
                    end
                `RET:
                    begin
                        f_rA_o = `RSP;
                        f_rB_o = `RSP;
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H1;
                        f_dstE_o = `RSP;
                        f_stat_o = `SAOK;
                    end
                `PUSHQ:
                    begin
                        f_rA_o = inst_i[`SRCA];
                        f_rB_o = `RSP;
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H2;
                        f_predPC_o = f_valP_o;
                        f_dstE_o = `RSP;
                        f_stat_o = `SAOK;
                    end
                `POPQ:
                    begin
                        f_rA_o = `RSP;
                        f_rB_o = `RSP;
                        f_valP_o = f_pc_i + `ADDR_WIDTH'H2;
                        f_predPC_o = f_valP_o;
                        f_dstE_o = `RSP;
                        f_dstM_o = inst_i[`SRCA];
                        f_stat_o = `SAOK;
                    end
                default:
                    begin
                        f_stat_o = `SINS;
                    end
            endcase
        end
        else
        begin
            f_stat_o = `SADR;
        end
    end

endmodule
