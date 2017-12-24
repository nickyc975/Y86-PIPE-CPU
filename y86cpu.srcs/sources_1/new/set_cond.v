`include "define.v"

module set_cond(
    input wire clk,
    input wire rst,
    input wire [`STAT_BUS] W_stat,
    input wire [`STAT_BUS] m_stat,
    input wire [`ICODE_BUS] E_icode,
    input wire [`IFUN_BUS] E_ifun,
    input wire [`REG_ADDR_BUS] E_dstE,
    input wire ZF_i,
    input wire SF_i,
    input wire OF_i,
    
    output reg e_Cnd,
    output reg [`REG_ADDR_BUS] e_dstE
    );
    
    reg ZF, SF, OF;
    
    initial
    begin
        ZF <= 1'B0;
        SF <= 1'B0;
        OF <= 1'B0;
    end
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN)
            begin
                ZF <= 1'B0;
                SF <= 1'B0;
                OF <= 1'B0;
            end
            else if(W_stat == `AOK && m_stat == `AOK && 
                   (E_icode == `OPQ || (E_icode == `IXX && E_ifun != `IRMOVQ)))
            begin
                ZF <= ZF_i;
                SF <= SF_i;
                OF <= OF_i;
            end
        end
    
    always @(*)
    begin
        if(E_icode ==  `JXX || E_icode ==  `CXX)
            begin
                case(E_ifun)
                    `JLE:     e_Cnd <= ZF || ((!SF && OF) || SF);
                     `JL:      e_Cnd <= (!SF && OF) || SF;
                     `JE:      e_Cnd <= ZF;
                     `JNE:     e_Cnd <= !ZF;
                     `JGE:     e_Cnd <= ZF || ((SF && OF) || !SF);
                     `JG:      e_Cnd <= (SF && OF) || !SF;
                     default:  e_Cnd <= 1'B0;
                endcase
                    
                if(e_Cnd == 1'B1)
                    e_dstE <= E_dstE;
                else
                    e_dstE <= `NREG;
            end
        else
            begin
                e_dstE <= E_dstE;
            end
    end
endmodule
