`include "define.v"

module set_m_stat(
    input wire [`STAT_BUS] M_stat_i,
    input wire mem_error_i,

    output reg [`STAT_BUS] m_stat_o
    );
    
    always @(*)
        begin
          if(mem_error_i == 1'B0)
            begin
                m_stat_o = M_stat_i;
            end
         else
            begin
                m_stat_o = `SADR;
            end
        end

endmodule
