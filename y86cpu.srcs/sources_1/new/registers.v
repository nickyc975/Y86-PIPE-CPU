`include "define.v"

module registers(
    input wire clk,
    input wire rst,
    input wire [`REG_ADDR_BUS]W_dstM_i,
    input wire [`REG_ADDR_BUS]W_dstE_i,
    input wire [`DATA_BUS]W_valM_i,
    input wire [`DATA_BUS]W_valE_i,
    input wire [`REG_ADDR_BUS]D_rA_i,
    input wire [`REG_ADDR_BUS]D_rB_i,
    
    output reg [`DATA_BUS]r_valA_o,
    output reg [`DATA_BUS]r_valB_o
    );
    
    reg [`DATA_BUS]registers[0:`NREG];
    
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN && W_dstM_i < `NREG)
            begin
                registers[W_dstM_i] <= W_valM_i;
            end
        end
        
    always @(posedge clk)
        begin
            if(rst == ~`RST_EN && W_dstE_i < `NREG)
            begin
                registers[W_dstE_i] <= W_valE_i;
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || D_rA_i >= `NREG)
            begin
                r_valA_o = `DATA_WIDTH'H0;
            end
            else if(D_rA_i == W_dstM_i)
            begin
                r_valA_o = W_valM_i;
            end
            else if(D_rA_i == W_dstE_i)
            begin
                 r_valA_o = W_valE_i;
            end
            else
            begin
                r_valA_o = registers[D_rA_i];
            end
        end
        
    always @(*)
        begin
            if(rst == `RST_EN || D_rB_i >= `NREG)
            begin
                r_valB_o = `DATA_WIDTH'H0;
            end
            else if(D_rB_i == W_dstM_i)
            begin
                r_valB_o = W_valM_i;
            end
            else if(D_rB_i == W_dstE_i)
            begin
                r_valB_o = W_valE_i;
            end
            else
            begin
                r_valB_o = registers[D_rB_i];
            end
        end
endmodule
