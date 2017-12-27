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

    always @(*)
        begin
            if(m_stat_i != `SAOK || W_stat_i != `SAOK)
                begin
                    F_stall_o = 1'B1;
                    set_cc_o = 1'B0;
                    M_bubble_o = 1'B1;
                    if(W_stat_i != `SAOK)
                        begin
                            W_stall_o = 1'B1;
                        end
                end
            else if(M_icode_i == `RET)
                begin
                    F_stall_o = 1'B1;
                    D_bubble_o = 1'B1;
                    E_bubble_o = 1'B1;
                end
            else if((E_icode_i == `MRMOVQ || E_icode_i == `POPQ) && (D_rA_i == E_dstM_i || D_rB_i == E_dstM_i))
                begin
                    F_stall_o = 1'B1;
                    D_stall_o = 1'B1;
                    E_bubble_o = 1'B1;
                end
            else if(E_icode_i == `JXX && e_Cnd_i == 1'B0)
                begin
                    D_bubble_o = 1'B1;
                    E_bubble_o = 1'B1;
                end
            else if(E_icode_i == `RET)
                begin
                    F_stall_o = 1'B1;
                    D_bubble_o = 1'B1;
                end
            else if(D_icode_i == `RET)
                begin
                    F_stall_o = 1'B1;
                end
            else
                begin
                    F_stall_o = 1'B0;
                    D_bubble_o = 1'B0;
                    D_stall_o = 1'B0;
                    E_bubble_o = 1'B0;
                    set_cc_o = 1'B1;
                    M_bubble_o = 1'B0;
                    W_stall_o = 1'B0;
                end
        end

endmodule
