`include "define.v"

module fetch_reg(
    input clk,
    input rst,
    input wire [`ADDR_BUS] predPC_i,
    output reg [`ADDR_BUS] predPC_o
    );
    
    initial
    begin
        predPC_o <= `ADDR_WIDTH'H0;
    end
    
    always @(posedge clk)
        begin
            if(rst == `RST_EN || predPC_i === 64'BX)
            begin
                predPC_o <= `ADDR_WIDTH'H0;
            end
            else
            begin
                predPC_o <= predPC_i;
            end
        end
endmodule
