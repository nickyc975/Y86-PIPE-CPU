`include "define.v"

module fetch_reg(
    input wire clk,
    input wire rst,
    input wire F_stall_i,
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
            else if(F_stall_i == 1'B0)
            begin
                F_predPC_o <= f_predPC_i;
            end
            else
            begin
                F_predPC_o <= F_predPC_o;
            end
        end
endmodule
