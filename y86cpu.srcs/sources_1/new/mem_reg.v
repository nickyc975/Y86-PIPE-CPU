`include "define.v"

module mem_reg(
    input wire clk,
    input wire rst,
    input wire e_Cnd_i,
    input wire M_bubble_i,
    input wire [`STAT_BUS] E_stat_i,
    input wire [`ICODE_BUS] E_icode_i,
    input wire [`DATA_BUS] e_valE_i,
    input wire [`DATA_BUS] E_valA_i,
    input wire [`REG_ADDR_BUS] e_dstE_i,
    input wire [`REG_ADDR_BUS] E_dstM_i,
    
    output reg M_Cnd_o,
    output reg [`STAT_BUS] M_stat_o,
    output reg [`ICODE_BUS] M_icode_o,
    output reg [`DATA_BUS] M_valE_o,
    output reg [`DATA_BUS] M_valA_o,
    output reg [`REG_ADDR_BUS] M_dstE_o,
    output reg [`REG_ADDR_BUS] M_dstM_o
    );

    initial
        begin
            M_Cnd_o  <= `TRUE;
            M_stat_o <= `SAOK;
            M_icode_o <= `ICODE_ZERO;
            M_valE_o <= `DATA_ZERO;
            M_valA_o <= `DATA_ZERO;
            M_dstE_o <= `NREG;
            M_dstM_o <= `NREG;
        end
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                M_Cnd_o  <= `TRUE;
                M_stat_o <= `SAOK;
                M_icode_o <= `ICODE_ZERO;
                M_valE_o <= `DATA_ZERO;
                M_valA_o <= `DATA_ZERO;
                M_dstE_o <= `NREG;
                M_dstM_o <= `NREG;
            end
            else if(M_bubble_i == `TRUE)
            begin
                M_Cnd_o  <= e_Cnd_i;
                M_stat_o <= `SAOK;
                M_icode_o <= `NOP;
                M_valE_o <= `DATA_ZERO;
                M_valA_o <= `DATA_ZERO;
                M_dstE_o <= `NREG;
                M_dstM_o <= `NREG;
            end
            else
            begin
                M_Cnd_o  <= e_Cnd_i;
                M_stat_o <= E_stat_i;
                M_icode_o <= E_icode_i;
                M_valE_o <= e_valE_i;
                M_valA_o <= E_valA_i;
                M_dstE_o <= e_dstE_i;
                M_dstM_o <= E_dstM_i;
            end
        end
endmodule
