`include "define.v"

module write_reg(
    input wire clk,
    input wire rst,
    input wire W_stall_i,
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

    initial
        begin   
             W_stat_o <= `SAOK;
            W_icode_o <= `NOP;
            W_valE_o <= `DATA_ZERO;
            W_valM_o <= `DATA_ZERO;
            W_dstE_o <= `NREG;
            W_dstM_o <= `NREG;
        end
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                W_stat_o <= `SAOK;
                W_icode_o <= `NOP;
                W_valE_o <= `DATA_ZERO;
                W_valM_o <= `DATA_ZERO;
                W_dstE_o <= `NREG;
                W_dstM_o <= `NREG;
            end
            else if(W_stall_i == `TRUE)
            begin
                W_stat_o <= W_stat_o;
                W_icode_o <= W_icode_o;
                W_valE_o <= W_valE_o;
                W_valM_o <= W_valM_o;
                W_dstE_o <= W_dstE_o;
                W_dstM_o <= W_dstM_o;
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
