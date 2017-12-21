`include "define.v"

module fetch(
    input wire clk,
    input wire rst,
    output reg mem_en,
    output reg [`ADDR_BUS] pc
    );

    always @(posedge clk)
    begin
        if(rst == `RST_EN)
            begin
                mem_en <= ~`CHIP_EN;
            end
        else
            begin
                mem_en <= `CHIP_EN;
            end
    end

    always @(posedge clk)
    begin
        if(mem_en == ~`CHIP_EN)
            begin
                pc <= `ADDR_WIDTH'H0;
            end
        else
            begin
                pc <= pc + `ADDR_WIDTH'HA;
            end
    end

endmodule
