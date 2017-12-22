`include "define.v"

module i_mem(
    input wire rst,
    input wire [`ADDR_BUS] addr,
    output reg [`INST_BUS] inst,
    output reg [`STAT_BUS] stat
    );
    
    reg [`BYTE0]mem[`MEM_SIZE:0];
    
    always @(*)
        begin
            if(rst == `RST_EN)
            begin
                inst <= `INST_WIDTH'B0;
                stat <= `AOK;
            end
            else if(addr <= `MEM_SIZE - 3)
            begin
                inst <= {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3]};
                stat <= `AOK;
            end
            else if(addr <= `MEM_SIZE)
            begin
                case(addr)
                    `MEM_SIZE - 2:
                        begin
                            inst <= {mem[addr], mem[addr + 1], mem[addr + 2], `BYTE_SIZE'H0};
                        end
                    `MEM_SIZE - 1:
                        begin   
                            inst <= {mem[addr], mem[addr + 1], `BYTE_SIZE'H0, `BYTE_SIZE'H0};
                        end
                    default:
                        begin
                            inst <= {mem[addr], `BYTE_SIZE'H0, `BYTE_SIZE'H0, `BYTE_SIZE'H0};
                        end
                endcase
                stat <= `AOK;
            end
            else
            begin
                stat <= `SMEM;
            end
        end
endmodule
