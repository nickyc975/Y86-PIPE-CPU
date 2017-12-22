`include "define.v"

module execute_reg(
    input wire [`ICODE_BUS] E_icode,
    input wire [`IFUN_BUS] E_ifun,
    input wire [`DATA_BUS] E_valC,
    input wire [`DATA_BUS] E_valA,
    input wire [`DATA_BUS] E_valB,
    input wire [`REG_ADDR_BUS] E_dstE,
    
    output reg e_Cnd,
    output reg [`DATA_BUS] e_valA,
    output reg [`REG_ADDR_BUS] e_dstE,
    output reg [`DATA_BUS] e_valE
    );
endmodule
