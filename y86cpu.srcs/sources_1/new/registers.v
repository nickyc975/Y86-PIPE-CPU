`include "define.v"

module registers(
    input wire clk,
    input wire rst,
    input wire [`REG_ADDR_BUS]dstW,
    input wire [`REG_ADDR_BUS]dstE,
    input wire [`DATA_BUS]valW,
    input wire [`DATA_BUS]valE,
    input wire [`REG_ADDR_BUS]srcA,
    input wire [`REG_ADDR_BUS]srcB,
    
    output reg [`DATA_BUS]valA,
    output reg [`DATA_BUS]valB
    );
    
    reg [`DATA_BUS]registers[0:`NREG];
    
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN && dstW < `NREG)
            begin
                registers[dstW] <= valW;
            end
        end
        
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN && dstE < `NREG)
            begin
                registers[dstE] <= valE;
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || srcA >= `NREG)
            begin
                valA = `DATA_WIDTH'H0;
            end
            else if(srcA == dstW)
            begin
                valA = valW;
            end
            else if(srcA == dstE)
            begin
                 valA = valE;
            end
            else
            begin
                valA = registers[srcA];
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || srcB >= `NREG)
            begin
                valB = `DATA_WIDTH'H0;
            end
            else if(srcB == dstW)
            begin
                valB = valW;
            end
            else if(srcB == dstE)
            begin
                valB = valE;
            end
            else
            begin
                valB = registers[srcB];
            end
        end
endmodule
