module sopc(
    input wire clk,
    input wire rst
    );
    
    wire [63:0]addr_bus;
    wire [63:0]data_i_bus;
    wire [63:0]data_o_bus;
    wire [79:0]inst_bus;
    wire [63:0]pc;
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
