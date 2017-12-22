`include "define.v"

module execute_reg(
    input wire clk,
    input wire rst,
    input wire [`STAT_BUS] D_stat,
    input wire [`ICODE_BUS] D_icode,
    input wire [`IFUN_BUS] D_ifun,
    input wire [`DATA_BUS] D_valC,
    input wire [`DATA_BUS] d_valA,
    input wire [`DATA_BUS] d_valB,
    input wire [`REG_ADDR_BUS] d_dstE,
    input wire [`REG_ADDR_BUS] d_dstM,
    input wire [`REG_ADDR_BUS] d_srcA,
    input wire [`REG_ADDR_BUS] d_srcB,
    
    output reg [`STAT_BUS] E_stat,
    output reg [`ICODE_BUS] E_icode,
    output reg [`IFUN_BUS] E_ifun,
    output reg [`DATA_BUS] E_valC,
    output reg [`DATA_BUS] E_valA,
    output reg [`DATA_BUS] E_valB,
    output reg [`REG_ADDR_BUS] E_dstE,
    output reg [`REG_ADDR_BUS] E_dstM,
    output reg [`REG_ADDR_BUS] E_srcA,
    output reg [`REG_ADDR_BUS] E_srcB
    );
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                E_stat <= `AOK;
                E_icode <= `ICODE_WIDTH'H0;
                E_ifun <= `IFUN_WIDTH'H0;
                E_valA <= `DATA_WIDTH'H0;
                E_valB <= `DATA_WIDTH'H0;
                E_valC <= `DATA_WIDTH'H0;
                E_dstE <= `NREG;
                E_dstM <= `NREG;
                E_srcA <= `NREG;
                E_srcB <= `NREG;
            end
            else
            begin
                E_stat <= D_stat;
                E_icode <= D_icode;
                E_ifun <= D_ifun;
                E_valC <= D_valC;
                E_valA <= d_valA;
                E_valB <= d_valB;
                E_dstE <= d_dstE;
                E_dstM <= d_dstM;
                E_srcA <= d_srcA;
                E_srcB <= d_srcB;
            end
        end
    
endmodule
