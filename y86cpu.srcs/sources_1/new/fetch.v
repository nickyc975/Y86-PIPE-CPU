`include "define.v"

module fetch(
    input wire [`ADDR_BUS] f_pc,
    input wire [`INST_BUS] inst_i,
    
    output reg [`ICODE_BUS] icode,
    output reg [`IFUN_BUS] ifun,
    output reg [`REG_ADDR_BUS] rA,
    output reg [`REG_ADDR_BUS] rB,
    output reg [`DATA_BUS] valC,
    output reg [`ADDR_BUS] valP,
    output reg [`REG_ADDR_BUS] dstE,
    output reg [`REG_ADDR_BUS] dstM,
    output reg [`STAT_BUS] stat,
    output reg [`ADDR_BUS] predPC
    );
    
    always @(*)
    begin
        icode <= inst_i[`ICODE];
        ifun <= inst_i[`IFUN];
        rA <= `NREG;
        rB <= `NREG;
        valC <= `DATA_WIDTH'H0;
        valP <= `DATA_WIDTH'H0;
        dstE <= `NREG;
        dstM <= `NREG;
        predPC <= `ADDR_WIDTH'H0;
        case(icode)
            `HALT:
                begin
                    valP <= f_pc + `ADDR_WIDTH'H1;
                    predPC <= valP;
                    stat <= `SHLT;
                end
            `NOP:
                begin
                    valP <= f_pc + `ADDR_WIDTH'H1;
                    predPC <= valP;
                    stat <= `AOK;
                end
            {`CXX, `OPO}:
                begin
                    rA <= inst_i[`SRCA];
                    rB <= inst_i[`SRCB];
                    valP <= f_pc + `ADDR_WIDTH'H2;
                    predPC <= valP;
                    dstE <= rB;
                    stat <= `AOK;
                end
            `IXX:
                begin
                    rB <= inst_i[`SRCB];
                    valC <= {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                             inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                    valP <= f_pc + `ADDR_WIDTH'HA;
                    predPC <= valP;
                    dstE <= rB;
                    stat <= `AOK;
                end
            `RMMOVQ:
                begin
                    rA <= inst_i[`SRCA];
                    rB <= inst_i[`SRCB];
                    valC <= {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                             inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                    valP <= f_pc + `ADDR_WIDTH'HA;
                    predPC <= valP;
                    stat <= `AOK;
                end
            `MRMOVQ:
                begin
                    rA <= inst_i[`SRCA];
                    rB <= inst_i[`SRCB];
                    valC <= {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                             inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                    valP <= f_pc + `ADDR_WIDTH'HA;
                    predPC <= valP;
                    dstM <= rB;
                    stat <= `AOK;
                end
            `JXX:
                begin
                    valC <= {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                             inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                    valP <= f_pc + `ADDR_WIDTH'HA;
                    predPC <= valC;
                    stat <= `AOK;
                end
             `CALL:
                begin
                    rA <= `RSP;
                    rB <= `RSP;
                    valC <= {inst_i[`BYTE0], inst_i[`BYTE1], inst_i[`BYTE2], inst_i[`BYTE3],
                             inst_i[`BYTE4], inst_i[`BYTE5], inst_i[`BYTE6], inst_i[`BYTE7]};
                    valP <= f_pc + `ADDR_WIDTH'HA;
                    predPC <= valC;
                    dstM <= `RSP;       
                    stat <= `AOK;
                end
            `RET:
                begin
                    rA <= `RSP;
                    rB <= `RSP;
                    valP <= f_pc + `ADDR_WIDTH'H1;
                    dstE <= `RSP;
                    stat <= `AOK;
                end
            `PUSHQ:
                begin
                    rA <= inst_i[`SRCA];
                    rB <= `RSP;
                    valP <= f_pc + `ADDR_WIDTH'H2;
                    predPC <= valP;
                    dstE <= `RSP;
                    stat <= `AOK;
                end
            `POPQ:
                begin
                    rA <= `RSP;
                    rB <= `RSP;
                    valP <= f_pc + `ADDR_WIDTH'H2;
                    predPC <= valP;
                    dstE <= `RSP;
                    dstM <= inst_i[`SRCA];
                    stat <= `AOK;
                end
            default:
                begin
                    valP <= f_pc + `ADDR_WIDTH'H1;
                    predPC <= valP;
                    stat <= `SINS;
                end
        endcase
    end

endmodule
