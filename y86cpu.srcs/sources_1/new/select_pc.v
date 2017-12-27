`include "define.v"

module select_pc(
    input wire M_Cnd_i,
    input wire [`ICODE_BUS] M_icode_i,
    input wire [`ICODE_BUS] W_icode_i,
    input wire [`ADDR_BUS] M_valA_i,
    input wire [`ADDR_BUS] W_valM_i,
    input wire [`ADDR_BUS] F_predPC_i,
    
    output reg [`ADDR_BUS] f_pc_o
    );
    
    always @(*)
        begin
            if(M_icode_i == `JXX && !M_Cnd_i)
            begin
                f_pc_o = M_valA_i;
            end
            else if(W_icode_i == `RET)
            begin
                f_pc_o = W_valM_i;
            end
            else
            begin
                f_pc_o = F_predPC_i;
            end
        end
endmodule
