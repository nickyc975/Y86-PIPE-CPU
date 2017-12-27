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

    initial
        begin
            F_stall_o = `FALSE;
            D_bubble_o = `FALSE;
            D_stall_o = `FALSE;
            E_bubble_o = `FALSE;
            set_cc_o = `TRUE;
            M_bubble_o = `FALSE;
            W_stall_o = `FALSE;
        end

    always @(*)
        begin
            if(m_stat_i != `SAOK || W_stat_i != `SAOK)
                begin
                    F_stall_o = `TRUE;
                    set_cc_o = `FALSE;
                    M_bubble_o = `TRUE;
                    if(W_stat_i != `SAOK)
                        begin
                            W_stall_o = `TRUE;
                        end
                end
            else if(M_icode_i == `RET)
                begin
                    F_stall_o = `TRUE;
                    D_bubble_o = `TRUE;
                    E_bubble_o = `TRUE;
                end
            else if((E_icode_i == `MRMOVQ || E_icode_i == `POPQ) &&
                    E_dstM_i != `NREG && (D_rA_i == E_dstM_i || D_rB_i == E_dstM_i))
                begin
                    F_stall_o = `TRUE;
                    D_stall_o = `TRUE;
                    E_bubble_o = `TRUE;
                end
            else if(E_icode_i == `JXX && e_Cnd_i == `FALSE)
                begin
                    D_bubble_o = `TRUE;
                    E_bubble_o = `TRUE;
                end
            else if(E_icode_i == `RET)
                begin
                    F_stall_o = `TRUE;
                    D_bubble_o = `TRUE;
                end
            else if(D_icode_i == `RET)
                begin
                    F_stall_o = `TRUE;
                end
            else
                begin
                    F_stall_o = `FALSE;
                    D_bubble_o = `FALSE;
                    D_stall_o = `FALSE;
                    E_bubble_o = `FALSE;
                    set_cc_o = `TRUE;
                    M_bubble_o = `FALSE;
                    W_stall_o = `FALSE;
                end
        end

endmodule
