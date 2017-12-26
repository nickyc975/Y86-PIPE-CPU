`include "define.v"

module fetch_reg(
    input clk,
    input rst,
    input wire [`ADDR_BUS] f_predPC_i,
    output reg [`ADDR_BUS] F_predPC_o
    );
    
    initial
    begin
        F_predPC_o <= `ADDR_WIDTH'H0;
    end
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN || f_predPC_i === 64'BX)
            begin
                F_predPC_o <= `ADDR_WIDTH'H0;
            end
            else
            begin
                F_predPC_o <= f_predPC_i;
            end
        end
endmodule
