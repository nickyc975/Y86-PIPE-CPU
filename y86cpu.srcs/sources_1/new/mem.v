`include "define.v"

module mem(
    input wire [`DATA_BUS] M_valE,
    input wire [`DATA_BUS] M_valA,
    input wire [`ICODE_BUS] M_icode,
    
    output reg [`ADDR_BUS] addr,
    output reg write
    );
    
    always @(*)
        begin
            if(M_icode == `RMMOVQ)
                begin
                    addr <= M_valE;
                    write <= 1'B1;
                end
            else if(M_icode == `MRMOVQ)
                begin
                    addr <= M_valE;
                    write <= 1'B0;
                end
            else if(M_icode == `CALL || M_icode == `PUSHQ)
                begin
                    addr <= M_valA;
                    write <= 1'B1;
                end
            else if(M_icode == `RET || M_icode == `POPQ)
                begin
                    addr <= M_valA;
                    write <= 1'B0;
                end
            else
                begin
                    write <= 1'B0;
                end
        end
    
endmodule
