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
            case(M_icode)
                `RMMOVQ:
                    begin
                        addr <= M_valE;
                        write <= 1'B1;
                    end
                `MRMOVQ:
                    begin
                        addr <= M_valE;
                        write <= 1'B0;
                    end
                {`CALL, `PUSHQ}:
                    begin
                        addr <= M_valA;
                        write <= 1'B1;
                    end
                {`RET, `POPQ}:
                    begin
                        addr <= M_valA;
                        write <= 1'B0;
                    end
                default:
                    begin
                        write <= 1'B0;
                    end
            endcase
        end
    
endmodule
