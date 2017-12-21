`include "define.v"

module decode(
    input wire clk,
    input wire rst,
    input wire [`ADDR_BUS] pc_i,
    input wire [`INST_BUS] inst_i,
    output reg [`ICODE_BUS] icode,
    output reg [`IFUN_BUS] ifun,
    output reg [`DATA_BUS] valA,
    output reg [`DATA_BUS] valB,
    output reg [`DATA_BUS] valC,
    output reg [`REG_ADDR_BUS] dstE,
    output reg [`ADDR_BUS] dstM
    );
    
    always @(posedge clk)
    begin
        if(rst == `RST_EN)
        begin
            icode <= `ICODE_WIDTH'B0;
            ifun <= `IFUN_WIDTH'B0;
            valA <= `DATA_WIDTH'B0;
            valB <= `DATA_WIDTH'B0;
            valC <= `DATA_WIDTH'B0;
            dstE <= `REG_ADDR_WIDTH'H0;
            dstM <= `ADDR_WIDTH'H0;
        end
        else
        begin
            icode <= inst_i[`INST_WIDTH-1:`INST_WIDTH-4];
            ifun <= inst_i[`INST_WIDTH-5:`INST_WIDTH-8];
            case(icode)
                
            endcase
        end
    end 
endmodule
