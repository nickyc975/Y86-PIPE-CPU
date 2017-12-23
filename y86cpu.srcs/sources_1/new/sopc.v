module sopc(
    input wire clk,
    input wire rst
    );
    
    wire [63:0]addr_bus;
    wire [63:0]data_bus;
    wire [63:0]data_o_bus;
    wire [79:0]inst_bus;
    wire [63:0]pc;
    wire rw;
    
    y86cpu cpu(
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .rw(rw),
        .addr(addr_bus),
        .data_i(data_bus),
        .data_o(data_o_bus),
        .inst(inst_bus));
        
        d_mem data(
            .clk(clk),
            .rst(rst),
            .write(rw),
            .addr(addr_bus),
            .data_i(data_o_bus),
            .data_o(data_bus));
        
        i_mem inst(
            .addr(pc),
            .inst(inst_bus));
endmodule
