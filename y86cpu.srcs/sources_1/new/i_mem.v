`include "define.v"

module i_mem(
    input wire rst,
    input wire [`ADDR_BUS] addr,
    output reg [`INST_BUS] inst,
    output reg [`STAT_BUS] stat
    );
    
    reg [`INST_BUS]mem[`MEM_SIZE:0];
    
    always @(*)
        begin
            if(rst == `RST_EN)
            begin
                inst <= `INST_WIDTH'B0;
                stat <= `AOK;
            end
            else if(addr <= `MEM_SIZE)
            begin
                inst <= mem[addr];
                stat <= `AOK;
            end
            else
            begin
                stat <= `SMEM;
            end
        end
endmodule
