`include "define.v"

module i_mem(
    input wire rst,
    input wire [`ADDR_BUS] addr,
    output reg [`INST_BUS] inst,
    output reg error
    );
    
    reg [`INST_BUS]mem[`MEM_SIZE:0];
    
    always @(*)
        begin
            if(rst == `RST_EN)
            begin
                inst <= `INST_WIDTH'B0;
                error = 1'B0;
            end
            else if(addr <= `MEM_SIZE)
            begin
                inst <= mem[addr];
                error = 1'B0;
            end
            else
            begin
                error = 1'B1;
            end
        end
endmodule
