`include "define.v"

module decode_reg(
    input wire rst,
    input wire clk,
    input wire [`ICODE_BUS] icode_i,
    input wire [`IFUN_BUS] ifun_i,
    input wire [`REG_ADDR_BUS] rA_i,
    input wire [`REG_ADDR_BUS] rB_i,
    input wire [`DATA_BUS] valC_i,
    input wire [`ADDR_BUS] valP_i,
    input wire [`REG_ADDR_BUS] dstE_i,
    input wire [`REG_ADDR_BUS] dstM_i,
    input wire [`STAT_BUS] stat_i,
    
    output reg [`ICODE_BUS] icode_o,
    output reg [`IFUN_BUS] ifun_o,
    output reg [`REG_ADDR_BUS] rA_o,
    output reg [`REG_ADDR_BUS] rB_o,
    output reg [`DATA_BUS] valC_o,
    output reg [`ADDR_BUS] valP_o,
    output reg [`REG_ADDR_BUS] dstE_o,
    output reg [`REG_ADDR_BUS] dstM_o,
    output reg [`STAT_BUS] stat_o
    );

    always @(posedge clk)
    begin
        if(rst == `RST_EN)
            begin
                icode_o <= `ICODE_WIDTH'H0;
                ifun_o <= `IFUN_WIDTH'H0;
                rA_o <= `NREG;
                rB_o <= `NREG;
                valC_o <= `DATA_WIDTH'H0;
                valP_o <= `ADDR_WIDTH'H0;
                dstE_o <= `NREG;
                dstM_o <= `NREG;
                stat_o <= `STAT_WIDTH'H0;
            end
        else
            begin
                icode_o <= icode_i;
                ifun_o <= ifun_i;
                rA_o <= rA_i;
                rB_o <= rB_i;
                valC_o <= valC_i;
                valP_o <= valP_i;
                dstE_o <= dstE_i;
                dstM_o <= dstM_i;
                stat_o <= stat_i;
            end
    end
endmodule
