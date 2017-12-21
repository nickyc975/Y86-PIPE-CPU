`include "define.v"

module decode_reg(
    input wire rst,
    input wire clk,
    input wire [`ADDR_BUS] pc_i,
    input wire [`INST_BUS] inst_i,
    output reg [`ADDR_BUS] pc_o,
    output reg [`INST_BUS] inst_o
    );

    always @(posedge clk)
    begin
        if(rst == `RST_EN)
            begin
                pc_o <= `ADDR_WIDTH'H0;
                inst_o <= `ADDR_WIDTH'H0;
            end
        else
            begin
                pc_o <= pc_i;
                inst_o <= inst_i;
            end
    end
endmodule
