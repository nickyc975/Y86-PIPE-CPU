`include "define.v"

module decode_reg(
    input wire rst,
    input wire clk,
    input wire D_stall_i,
    input wire D_bubble_i,
    input wire [`ICODE_BUS] f_icode_i,
    input wire [`IFUN_BUS] f_ifun_i,
    input wire [`REG_ADDR_BUS] f_rA_i,
    input wire [`REG_ADDR_BUS] f_rB_i,
    input wire [`DATA_BUS] f_valC_i,
    input wire [`ADDR_BUS] f_valP_i,
    input wire [`REG_ADDR_BUS] f_dstE_i,
    input wire [`REG_ADDR_BUS] f_dstM_i,
    input wire [`STAT_BUS] f_stat_i,
    
    output reg [`ICODE_BUS] D_icode_o,
    output reg [`IFUN_BUS] D_ifun_o,
    output reg [`REG_ADDR_BUS] D_rA_o,
    output reg [`REG_ADDR_BUS] D_rB_o,
    output reg [`DATA_BUS] D_valC_o,
    output reg [`ADDR_BUS] D_valP_o,
    output reg [`REG_ADDR_BUS] D_dstE_o,
    output reg [`REG_ADDR_BUS] D_dstM_o,
    output reg [`STAT_BUS] D_stat_o
    );

    always @(posedge clk)
    begin
        if(rst == `RST_EN)
            begin
                D_icode_o <= `ICODE_WIDTH'H0;
                D_ifun_o <= `IFUN_WIDTH'H0;
                D_rA_o <= `NREG;
                D_rB_o <= `NREG;
                D_valC_o <= `DATA_WIDTH'H0;
                D_valP_o <= `ADDR_WIDTH'H0;
                D_dstE_o <= `NREG;
                D_dstM_o <= `NREG;
                D_stat_o <= `STAT_WIDTH'H0;
            end
        else if(D_stall_i == 1'B1)
            begin
                D_icode_o <= D_icode_o;
                D_ifun_o <= D_ifun_o;
                D_rA_o <= D_rA_o;
                D_rB_o <= D_rB_o;
                D_valC_o <= D_valC_o;
                D_valP_o <= D_valP_o;
                D_dstE_o <= D_dstE_o;
                D_dstM_o <= D_dstM_o;
                D_stat_o <= D_stat_o;
            end
        else if(D_bubble_i == 1'B1)
            begin
                D_icode_o <= `NOP;
                D_ifun_o <= `IFUN_WIDTH'H0;
                D_rA_o <= `NREG;
                D_rB_o <= `NREG;
                D_valC_o <= `DATA_WIDTH'H0;
                D_valP_o <= `ADDR_WIDTH'H0;
                D_dstE_o <= `NREG;
                D_dstM_o <= `NREG;
                D_stat_o <= `SAOK;
            end
        else
            begin
                D_icode_o <= f_icode_i;
                D_ifun_o <= f_ifun_i;
                D_rA_o <= f_rA_i;
                D_rB_o <= f_rB_i;
                D_valC_o <= f_valC_i;
                D_valP_o <= f_valP_i;
                D_dstE_o <= f_dstE_i;
                D_dstM_o <= f_dstM_i;
                D_stat_o <= f_stat_i;
            end
    end
endmodule
