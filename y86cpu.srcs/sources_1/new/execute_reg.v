`include "define.v"

module execute_reg(
    input wire clk,
    input wire rst,
    input wire E_bubble_i,
    input wire [`STAT_BUS] D_stat_i,
    input wire [`ICODE_BUS] D_icode_i,
    input wire [`IFUN_BUS] D_ifun_i,
    input wire [`DATA_BUS] D_valC_i,
    input wire [`DATA_BUS] d_valA_i,
    input wire [`DATA_BUS] d_valB_i,
    input wire [`REG_ADDR_BUS] D_dstE_i,
    input wire [`REG_ADDR_BUS] D_dstM_i,
    input wire [`REG_ADDR_BUS] D_srcA_i,
    input wire [`REG_ADDR_BUS] D_srcB_i,
    
    output reg [`STAT_BUS] E_stat_o,
    output reg [`ICODE_BUS] E_icode_o,
    output reg [`IFUN_BUS] E_ifun_o,
    output reg [`DATA_BUS] E_valC_o,
    output reg [`DATA_BUS] E_valA_o,
    output reg [`DATA_BUS] E_valB_o,
    output reg [`REG_ADDR_BUS] E_dstE_o,
    output reg [`REG_ADDR_BUS] E_dstM_o
    );
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                E_stat_o <= `SAOK;
                E_icode_o <= `ICODE_WIDTH'H0;
                E_ifun_o <= `IFUN_WIDTH'H0;
                E_valA_o <= `DATA_WIDTH'H0;
                E_valB_o <= `DATA_WIDTH'H0;
                E_valC_o <= `DATA_WIDTH'H0;
                E_dstE_o <= `NREG;
                E_dstM_o <= `NREG;
            end
            else if(E_bubble_i == 1'B1)
            begin
                E_stat_o <= `SAOK;
                E_icode_o <= `NOP;
                E_ifun_o <= `IFUN_WIDTH'H0;
                E_valA_o <= `DATA_WIDTH'H0;
                E_valB_o <= `DATA_WIDTH'H0;
                E_valC_o <= `DATA_WIDTH'H0;
                E_dstE_o <= `NREG;
                E_dstM_o <= `NREG;
            end
            else
            begin
                E_stat_o <= D_stat_i;
                E_icode_o <= D_icode_i;
                E_ifun_o <= D_ifun_i;
                E_valC_o <= D_valC_i;
                E_valA_o <= d_valA_i;
                E_valB_o <= d_valB_i;
                E_dstE_o <= D_dstE_i;
                E_dstM_o <= D_dstM_i;
            end
        end
    
endmodule
