`include "define.v"

module mem(
    input wire [`DATA_BUS] M_valE_i,
    input wire [`DATA_BUS] M_valA_i,
    input wire [`ICODE_BUS] M_icode_i,
    
    output reg [`ADDR_BUS] addr,
    output reg write
    );
    
    always @(*)
        begin
            if(M_icode_i == `RMMOVQ)
                begin
                    addr = M_valE_i;
                    write = 1'B1;
                end
            else if(M_icode_i == `MRMOVQ)
                begin
                    addr = M_valE_i;
                    write = 1'B0;
                end
            else if(M_icode_i == `CALL || M_icode_i == `PUSHQ)
                begin
                    addr = M_valA_i;
                    write = 1'B1;
                end
            else if(M_icode_i == `RET || M_icode_i == `POPQ)
                begin
                    addr = M_valA_i;
                    write = 1'B0;
                end
            else
                begin
                    write = 1'B0;
                end
        end
    
endmodule
