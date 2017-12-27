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
    
    initial
        begin
            error = `FALSE;
            data_o = `DATA_ZERO;
        end

    always @(*)
        begin
            if(rst == `RST_EN)
            begin
                data_o = `DATA_ZERO;
                error = `FALSE;
            end
            else if(addr > `MEM_SIZE)
            begin
                error = `TRUE;
            end
            else if(write == `FALSE && addr <= `MEM_SIZE - 7)
            begin
                data_o = {mem[addr], mem[addr+1], mem[addr+2], mem[addr+3],
                          mem[addr+4], mem[addr+5], mem[addr+6], mem[addr+7]};
                error = `FALSE;
            end
            else
            begin
                error = error;
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
                    error = `FALSE;
                end
                else
                begin
                    error = `TRUE;
                end
            end
            else
            begin
                error = error;
            end
        end
endmodule
