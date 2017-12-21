`include "define.v"

module registers(
    input wire clk,
    input wire rst,
    input wire dstW_en,
    input wire dstE_en,
    input wire [`REG_ADDR_BUS]dstW,
    input wire [`REG_ADDR_BUS]dstE,
    input wire [`DATA_BUS]valW,
    input wire [`DATA_BUS]valE,
    input wire srcA_en,
    input wire srcB_en,
    input wire [`REG_ADDR_BUS]srcA,
    input wire [`REG_ADDR_BUS]srcB,
    output reg [`DATA_BUS]valA,
    output reg [`DATA_BUS]valB
    );
    
    reg [`DATA_BUS]registers[0:`NREG];
    
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN)
            begin
                if(dstW_en == `WRITE_EN && dstW < `NREG)
                begin
                    registers[dstW] <= valW;
                end
            end
        end
        
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN)
            begin
                if(dstE_en == `WRITE_EN && dstE < `NREG)
                begin
                    registers[dstE] <= valE;
                end
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || srcA >= `NREG)
            begin
                valA <= `DATA_WIDTH'H0;
            end
            else if(srcA == dstW && srcA_en == `READ_EN && dstW_en == `WRITE_EN)
            begin
                valA <= valW;
            end
            else if(srcA == dstE && srcA_en == `READ_EN && dstE_en == `WRITE_EN)
            begin
                 valA <= valE;
            end
            else if(srcA_en == `READ_EN)
            begin
                valA <= registers[srcA];
            end
            else
            begin
                valA <= `DATA_WIDTH'H0;
            end
        end
        
    always @(*)
            begin
                if(rst == `RST_EN || srcB >= `NREG)
                begin
                    valB <= `DATA_WIDTH'H0;
                end
                else if(srcB == dstW && srcB_en == `READ_EN && dstW_en == `WRITE_EN)
                begin
                    valB <= valW;
                end
                else if(srcB == dstE && srcB_en == `READ_EN && dstE_en == `WRITE_EN)
                begin
                     valB <= valE;
                end
                else if(srcB_en == `READ_EN)
                begin
                    valB <= registers[srcB];
                end
                else
                begin
                    valB <= `DATA_WIDTH'H0;
                end
            end
endmodule
