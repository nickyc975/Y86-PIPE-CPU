`include "define.v"

module i_mem(
    input wire [`ADDR_BUS] addr,
    output reg [`INST_BUS] inst,
    output reg error
    );
    
    reg [`BYTE0]mem[0:`MEM_SIZE];
    
    initial
        begin
            error = `FALSE;
            inst = `NONE_INST;
            $readmemh("F:/Projects/Verilog/y86cpu/insts.data", mem);
        end
    
    always @(*)
        begin
            if(addr <= `MEM_SIZE - 9)
            begin
                inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], mem[addr + 4],
                        mem[addr + 5], mem[addr + 6], mem[addr + 7], mem[addr + 8], mem[addr + 9]};
                error = `FALSE;
            end
            else if(addr <= `MEM_SIZE)
            begin
                case(addr)
                    `MEM_SIZE - 8:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], mem[addr + 4],
                                    mem[addr + 5], mem[addr + 6], mem[addr + 7], mem[addr + 8], `BYTE_ZERO};
                        end
                    `MEM_SIZE - 7:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], mem[addr + 4],
                                    mem[addr + 5], mem[addr + 6], mem[addr + 7], `BYTE_ZERO, `BYTE_ZERO};
                        end
                    `MEM_SIZE - 6:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], mem[addr + 4],
                                    mem[addr + 5], mem[addr + 6], `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                    `MEM_SIZE - 5:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], mem[addr + 4],
                                    mem[addr + 5], `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                    `MEM_SIZE - 4:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], mem[addr + 4],
                                    `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                    `MEM_SIZE - 3:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], mem[addr + 3], `BYTE_ZERO,
                                    `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                    `MEM_SIZE - 2:
                        begin
                            inst = {mem[addr], mem[addr + 1], mem[addr + 2], `BYTE_ZERO, `BYTE_ZERO,
                                    `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                    `MEM_SIZE - 1:
                        begin   
                            inst = {mem[addr], mem[addr + 1], `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO,
                                    `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                    default:
                        begin
                            inst = {mem[addr], `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO,
                                    `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO, `BYTE_ZERO};
                        end
                endcase
                error = `FALSE;
            end
            else
            begin
                error = `TRUE;
            end
        end
endmodule
