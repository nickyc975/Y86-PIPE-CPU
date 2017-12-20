`include "define.v"

module decode_reg(
    input wire rst,
    input wire clk,
    input wire [`ROM_ADDR_BUS] pc_i,
    input wire [`ROM_DATA_BUS] inst_i,
    output reg [`ROM_ADDR_BUS] pc_o,
    output reg [`ROM_DATA_BUS] inst_o
    );

    always @(posedge clk)
    begin
        if(rst == `RST_EN)
            begin
                pc_o <= 64'H0;
                inst_o <= 64'H0;
            end
        else
            begin
                pc_o <= pc_i;
                inst_o <= inst_i;
            end
    end
endmodule
