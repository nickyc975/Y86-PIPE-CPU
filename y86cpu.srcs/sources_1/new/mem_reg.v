`include "define.v"

module mem_reg(
    input wire clk,
    input wire rst,
    input wire e_Cnd,
    input wire [`STAT_BUS] E_stat,
    input wire [`ICODE_BUS] E_icode,
    input wire [`DATA_BUS] e_valE,
    input wire [`DATA_BUS] e_valA,
    input wire [`REG_ADDR_BUS] e_dstE,
    input wire [`REG_ADDR_BUS] E_dstM,
    
    output reg M_Cnd,
    output reg [`STAT_BUS] M_stat,
    output reg [`ICODE_BUS] M_icode,
    output reg [`DATA_BUS] M_valE,
    output reg [`DATA_BUS] M_valA,
    output reg [`REG_ADDR_BUS] M_dstE,
    output reg [`REG_ADDR_BUS] M_dstM
    );
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                M_Cnd  <= 1'B0;
                M_stat <= `STAT_WIDTH'B0;
                M_icode <= `NOP;
                M_valE <= `DATA_WIDTH'H0;
                M_valA <= `DATA_WIDTH'H0;
                M_dstE <= `NREG;
                M_dstM <= `NREG;
            end
            else
            begin
                M_Cnd  <= e_Cnd;
                M_stat <= E_stat;
                M_icode <= E_icode;
                M_valE <= e_valE;
                M_valA <= e_valA;
                M_dstE <= e_dstE;
                M_dstM <= E_dstM;
            end
        end
endmodule
