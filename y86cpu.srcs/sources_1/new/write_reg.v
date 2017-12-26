`include "define.v"

module write_reg(
    input wire clk,
    input wire rst,
    input wire [`STAT_BUS] m_stat_i,
    input wire [`ICODE_BUS] M_icode_i,
    input wire [`DATA_BUS] M_valE_i,
    input wire [`DATA_BUS] m_valM_i,
    input wire [`REG_ADDR_BUS] M_dstE_i,
    input wire [`REG_ADDR_BUS] M_dstM_i,
    
    output reg [`STAT_BUS] W_stat_o,
    output reg [`ICODE_BUS] W_icode_o,
    output reg [`DATA_BUS] W_valE_o,
    output reg [`DATA_BUS] W_valM_o,
    output reg [`REG_ADDR_BUS] W_dstE_o,
    output reg [`REG_ADDR_BUS] W_dstM_o
    );
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                W_stat_o <= `SAOK;
                W_icode_o <= `NOP;
                W_valE_o <= `DATA_WIDTH'H0;
                W_valM_o <= `DATA_WIDTH'H0;
                W_dstE_o <= `NREG;
                W_dstM_o <= `NREG;
            end
            else
            begin
                W_stat_o <= m_stat_i;
                W_icode_o <= M_icode_i;
                W_valE_o <= M_valE_i;
                W_valM_o <= m_valM_i;
                W_dstE_o <= M_dstE_i;
                W_dstM_o <= M_dstM_i;
            end
        end
    
endmodule
