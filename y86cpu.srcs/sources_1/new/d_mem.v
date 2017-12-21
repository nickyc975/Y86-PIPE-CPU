`include "define.v"

module d_mem(
    input wire clk,
    input wire rst,
    input wire write,
    input wire [`ADDR_BUS] addr,
    input wire [`DATA_BUS] data_i,
    output reg [`DATA_BUS] data_o,
    output reg error
    );
    
    reg [`DATA_BUS]mem[`MEM_SIZE:0];
    
    always @(*)
        begin
            if(rst == `RST_EN)
            begin
                error <= 1'B0;
                data_o <= `DATA_WIDTH'B0;
            end
            else if(addr > `MEM_SIZE)
            begin
                error <= 1'B1;
                data_o <= `DATA_WIDTH'B0;
            end
            else if(write == `TRUE)
            begin
                data_o <= data_i;
            end
            else
            begin
                data_o <= mem[addr];
            end
        end
    
    always @(posedge clk)
        begin
            if(write == `TRUE && rst == ~`RST_EN)
            begin
                if(addr <= `MEM_SIZE)
                begin
                    mem[addr] <= data_i;
                end
                else if(addr > `MEM_SIZE)
                begin
                    error <= 1'B1;
                end
            end
        end
endmodule
