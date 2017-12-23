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
    
    reg [`BYTE0]mem[0:`MEM_SIZE];
    
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
            else if(write == `FALSE && addr <= `MEM_SIZE - 7)
            begin
                data_o <= {mem[addr], mem[addr+1], mem[addr+2], mem[addr+3],
                           mem[addr+4], mem[addr+5], mem[addr+6], mem[addr+7]};
                error <= 1'B0;
            end
            else
            begin
                error <= 1'B0;
            end
        end
    
    always @(posedge clk)
        begin
            if(write == `TRUE && rst == ~`RST_EN)
            begin
                if(addr <= `MEM_SIZE - 7)
                begin
                    {mem[addr], mem[addr+1], mem[addr+2], mem[addr+3],
                     mem[addr+4], mem[addr+5], mem[addr+6], mem[addr+7]} <= data_i;
                    error <= 1'B0;
                end
                else
                begin
                    error <= 1'B1;
                end
            end
        end
endmodule
