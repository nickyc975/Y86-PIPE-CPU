`include "define.v"

module sopc(
    input wire clk,
    input wire rst
    );
    
    wire [`ADDR_BUS] addr_bus;
    wire [`DATA_BUS] data_i_bus;
    wire [`DATA_BUS] data_o_bus;
    wire [`INST_BUS] inst_bus;
    wire [`ADDR_BUS] pc;
    wire write;
    wire i_mem_error;
    wire d_mem_error;
    
    y86cpu cpu
    (
        .clk_i(clk),
        .rst_i(rst),
        .inst_i(inst_bus),
        .data_i(data_i_bus),
        .i_mem_error_i(i_mem_error),
        .d_mem_error_i(d_mem_error),

        .pc_o(pc),
        .write_o(write),
        .addr_o(addr_bus),
        .data_o(data_o_bus)
    );

    i_mem inst
    (
        .addr(pc),
        .inst(inst_bus),
        .error(i_mem_error)
    );
        
    d_mem data
    (
        .clk(clk),
        .rst(rst),
        .write(write),
        .addr(addr_bus),
        .data_i(data_o_bus),
        .data_o(data_i_bus),
        .error(d_mem_error)
    );
endmodule
