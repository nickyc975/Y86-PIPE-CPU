`include "define.v"

module fetch(
    input wire clk,
    input wire rst,
    output reg en,
    output reg [`ROM_ADDR_BUS] pc
    );

    always @(posedge clk)
    begin
        if(rst == `RST_EN)
            begin
                en <= ~`CHIP_EN;
            end
        else
            begin
                en <= `CHIP_EN;
            end
    end

    always @(posedge clk)
    begin
        if(en == ~`CHIP_EN)
            begin
                pc <= 64'H0;
            end
        else
            begin
                pc <= pc + 64'HA;
            end
    end

endmodule
