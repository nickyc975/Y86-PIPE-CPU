`include "define.v"

module write_reg(
    input wire clk,
    input wire rst,
    input wire [`STAT_BUS] m_stat,
    input wire [`ICODE_BUS] M_icode,
    input wire [`DATA_BUS] M_valE,
    input wire [`DATA_BUS] m_valM,
    input wire [`REG_ADDR_BUS] M_dstE,
    input wire [`REG_ADDR_BUS] M_dstM,
    
    output reg [`STAT_BUS] W_stat,
    output reg [`ICODE_BUS] W_icode,
    output reg [`DATA_BUS] W_valE,
    output reg [`DATA_BUS] W_valM,
    output reg [`REG_ADDR_BUS] W_dstE,
    output reg [`REG_ADDR_BUS] W_dstM
    );
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                W_stat <= `AOK;
                W_icode <= `NOP;
                W_valE <= `DATA_WIDTH'H0;
                W_valM <= `DATA_WIDTH'H0;
                W_dstE <= `NREG;
                W_dstM <= `NREG;
            end
            else
            begin
                W_stat <= m_stat;
                W_icode <= M_icode;
                W_valE <= M_valE;
                W_valM <= m_valM;
                W_dstE <= M_dstE;
                W_dstM <= M_dstM;
            end
        end
    
endmodule
