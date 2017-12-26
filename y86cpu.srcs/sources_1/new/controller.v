`include "define.v"

module controller(
    input wire [`ICODE_BUS] D_icode_i,
    input wire [`REG_ADDR_BUS] D_rA_i,
    input wire [`REG_ADDR_BUS] D_rB_i,
    input wire [`ICODE_BUS] E_icode_i,
    input wire [`REG_ADDR_BUS] E_dstM_i,
    input wire e_Cnd_i,
    input wire [`ICODE_BUS] M_icode_i,
    input wire [`STAT_BUS] m_stat_i,
    input wire [`STAT_BUS] W_stat_i,

    output reg F_stall_o,
    output reg D_bubble_o,
    output reg D_stall_o,
    output reg E_bubble_o,
    output reg set_cc_o,
    output reg M_bubble_o,
    output reg W_stall_o
    );
endmodule
