`include "define.v"

module set_cond(
    input wire set_cc_i,
    input wire [`ICODE_BUS] E_icode_i,
    input wire [`IFUN_BUS] E_ifun_i,
    input wire [`REG_ADDR_BUS] E_dstE_i,
    input wire ZF_i,
    input wire SF_i,
    input wire OF_i,
    
    output reg e_Cnd_o,
    output reg [`REG_ADDR_BUS] e_dstE_o
    );
    
    reg ZF, SF, OF;
    
    initial
    begin
        ZF = 1'B0;
        SF = 1'B0;
        OF = 1'B0;
    end
    
    always @(*)
    begin
        if(set_cc_i == 1'B1 && (E_icode_i == `OPQ || (E_icode_i == `IXX && E_ifun_i != `IRMOVQ)))
            begin
                ZF = ZF_i;
                SF = SF_i;
                OF = OF_i;
            end
        else
            begin
                ZF = ZF;
                SF = SF;
                OF = OF;
            end
        if(E_icode_i == `JXX || E_icode_i == `CXX)
            begin
                case(E_ifun_i)
                    `JLE:      e_Cnd_o = ZF || (!SF && OF) || SF;
                     `JL:      e_Cnd_o = (!SF && OF) || SF;
                     `JE:      e_Cnd_o = ZF;
                    `JNE:      e_Cnd_o = !ZF;
                    `JGE:      e_Cnd_o = ZF || (SF && OF) || !SF;
                     `JG:      e_Cnd_o = (SF && OF) || !SF;
                     default:  e_Cnd_o = 1'B1;
                endcase
                    
                if(e_Cnd_o == 1'B1)
                    e_dstE_o = E_dstE_i;
                else
                    e_dstE_o = `NREG;
            end
        else
            begin
                e_dstE_o = E_dstE_i;
            end
    end
endmodule
