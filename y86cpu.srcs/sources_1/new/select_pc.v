`include "define.v"

module select_pc(
    input wire rst,
    input wire M_Cnd,
    input wire [`ICODE_BUS] M_icode,
    input wire [`ICODE_BUS] W_icode,
    input wire [`ADDR_BUS] M_valA,
    input wire [`ADDR_BUS] W_valM,
    input wire [`ADDR_BUS] F_predPC,
    output reg [`ADDR_BUS] f_pc
    );
    
    always @(*)
        begin
            if(M_icode == `JXX && M_Cnd)
            begin
                f_pc = M_valA;
            end
            else if(W_icode == `RET)
            begin
                f_pc = W_valM;
            end
            else
            begin
                f_pc = F_predPC;
            end
        end
endmodule
