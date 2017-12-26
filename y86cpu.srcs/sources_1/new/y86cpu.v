`include "define.v"

module y86cpu(
      input wire rst_i,
      input wire clk_i,
      input wire [`INST_BUS] inst_i,
      input wire [`DATA_BUS] data_i,
      input wire i_mem_error_i,
      input wire d_mem_error_i,

      output wire write_o,
      output wire [`ADDR_BUS] pc_o,
      output wire [`ADDR_BUS] addr_o,
      output wire [`DATA_BUS] data_o
      );
  
  

      wire clk;
      wire rst;
      wire [`INST_BUS] inst;
      wire [`DATA_BUS] data;
      wire i_mem_error;
      wire d_mem_error;

      // controller
      wire F_stall;
      wire D_bubble;
      wire D_stall;
      wire E_bubble;
      wire set_cc;
      wire M_bubble;
      wire W_stall;

      // fetch_reg
      wire [`ADDR_BUS]      F_predPC;

      // select_pc
      wire [`ADDR_BUS]      f_pc;
      
      // fetch
      wire [`ICODE_BUS]     f_icode;
      wire [`IFUN_BUS]      f_ifun;
      wire [`REG_ADDR_BUS]  f_rA;
      wire [`REG_ADDR_BUS]  f_rB;
      wire [`DATA_BUS]      f_valC;
      wire [`ADDR_BUS]      f_valP;
      wire [`REG_ADDR_BUS]  f_dstE;
      wire [`REG_ADDR_BUS]  f_dstM;
      wire [`ADDR_BUS]      f_predPC;
      wire [`STAT_BUS]      f_stat;
      
      // decode_reg
      wire [`ICODE_BUS]     D_icode;
      wire [`IFUN_BUS]      D_ifun;
      wire [`REG_ADDR_BUS]  D_rA;
      wire [`REG_ADDR_BUS]  D_rB;
      wire [`DATA_BUS]      D_valC;
      wire [`ADDR_BUS]      D_valP;
      wire [`REG_ADDR_BUS]  D_dstE;
      wire [`REG_ADDR_BUS]  D_dstM;
      wire [`STAT_BUS]      D_stat;

      // decode
      wire [`DATA_BUS]      d_valA;
      wire [`DATA_BUS]      d_valB;

      // execute_reg
      wire [`STAT_BUS]      E_stat;
      wire [`ICODE_BUS]     E_icode;
      wire [`IFUN_BUS]      E_ifun;
      wire [`DATA_BUS]      E_valC;
      wire [`DATA_BUS]      E_valA;
      wire [`DATA_BUS]      E_valB;
      wire [`REG_ADDR_BUS]  E_dstE;
      wire [`REG_ADDR_BUS]  E_dstM;

      // alu_args
      wire [`DATA_BUS]      aluA;
      wire [`DATA_BUS]      aluB;
      wire [`IFUN_BUS]      fun;

      // alu
      wire [`DATA_BUS]      e_valE;
      wire OF;
      wire SF;
      wire ZF;

      // set_cond
      wire e_Cnd;
      wire [`REG_ADDR_BUS]  e_dstE;

      // mem_reg
      wire M_Cnd;
      wire [`STAT_BUS]      M_stat;
      wire [`ICODE_BUS]     M_icode;
      wire [`REG_ADDR_BUS]  M_dstE;
      wire [`DATA_BUS]      M_valA;
      wire [`DATA_BUS]      M_valE;
      wire [`REG_ADDR_BUS]  M_dstM;

      // mem
      wire [`ADDR_BUS]      addr;
      wire write;

      // set_m_stat
      wire [`STAT_BUS]      m_stat;
      
      // registers
      wire [`DATA_BUS]      r_valA;
      wire [`DATA_BUS]      r_valB;
      
      // write_reg
      wire [`STAT_BUS]      W_stat;
      wire [`ICODE_BUS]     W_icode;
      wire [`REG_ADDR_BUS]  W_dstE;
      wire [`REG_ADDR_BUS]  W_dstM;
      wire [`DATA_BUS]      W_valE;
      wire [`DATA_BUS]      W_valM;

      assign clk = clk_i;
      assign rst = rst_i;
      assign inst = inst_i[`INST_BUS];
      assign data = data_i[`DATA_BUS];
      assign i_mem_error = i_mem_error_i;
      assign d_mem_error = d_mem_error_i;

      assign write_o = write;
      assign addr_o[`ADDR_BUS] = addr;
      assign data_o[`DATA_BUS] = M_valA;
      assign pc_o[`ADDR_BUS] = f_pc;

      controller y86_controller
      (
            .D_icode_i(D_icode),
            .D_rA_i(D_rA),
            .D_rB_i(D_rB),
            .E_icode_i(E_icode),
            .E_dstM_i(E_dstM),
            .e_Cnd_i(e_Cnd),
            .M_icode_i(M_icode),
            .m_stat_i(m_stat),
            .W_stat_i(W_stat),

            .F_stall_o(F_stall),
            .D_bubble_o(D_bubble),
            .D_stall_o(D_stall),
            .E_bubble_o(E_bubble),
            .set_cc_o(set_cc),
            .M_bubble_o(M_bubble),
            .W_stall_o(W_stall)
      );

      fetch_reg y86_fetch_reg
      (
            .clk(clk),
            .rst(rst),
            .F_stall_i(F_stall),
            .f_predPC_i(f_predPC),

            .F_predPC_o(F_predPC)
      );

      select_pc y86_select_pc
      (
            .M_Cnd_i(M_Cnd),
            .F_predPC_i(F_predPC),
            .M_icode_i(M_icode),
            .W_icode_i(W_icode),
            .M_valA_i(M_valA),
            .W_valM_i(W_valM),

            .f_pc_o(f_pc)
      );

      fetch y86_fetch
      (
            .f_pc_i(f_pc),
            .inst_i(inst),
            .mem_error_i(i_mem_error),

            .f_icode_o(f_icode),
            .f_ifun_o(f_ifun),
            .f_rA_o(f_rA),
            .f_rB_o(f_rB),
            .f_valC_o(f_valC),
            .f_valP_o(f_valP),
            .f_dstE_o(f_dstE),
            .f_dstM_o(f_dstM),
            .f_predPC_o(f_predPC),
            .f_stat_o(f_stat)
      );

      decode_reg y86_decode_reg
      (
            .clk(clk),
            .rst(rst),
            .D_stall_i(D_stall),
            .D_bubble_i(D_bubble),
            .f_icode_i(f_icode),
            .f_ifun_i(f_ifun),
            .f_rA_i(f_rA),
            .f_rB_i(f_rB),
            .f_valC_i(f_valC),
            .f_valP_i(f_valP),
            .f_dstE_i(f_dstE),
            .f_dstM_i(f_dstM),
            .f_stat_i(f_stat),

            .D_icode_o(D_icode),
            .D_ifun_o(D_ifun),
            .D_rA_o(D_rA),
            .D_rB_o(D_rB),
            .D_valC_o(D_valC),
            .D_valP_o(D_valP),
            .D_dstE_o(D_dstE),
            .D_dstM_o(D_dstM),
            .D_stat_o(D_stat)
      );

      decode y86_decode
      (
            .D_icode_i(D_icode),
            .D_valP_i(D_valP),
            .D_srcA_i(D_rA),
            .D_srcB_i(D_rB),
            .r_valA_i(r_valA),
            .r_valB_i(r_valB),
            .e_dstE_i(e_dstE),
            .e_valE_i(e_valE),
            .M_dstE_i(M_dstE),
            .M_valE_i(M_valE),
            .M_dstM_i(M_dstM),
            .m_valM_i(data),
            .W_dstE_i(W_dstE),
            .W_valE_i(W_valE),
            .W_dstM_i(W_dstM),
            .W_valM_i(W_valM),
            
            .d_valA_o(d_valA),
            .d_valB_o(d_valB)
      );

      execute_reg y86_execute_reg
      (
            .clk(clk),
            .rst(rst),
            .E_bubble_i(E_bubble),
            .D_stat_i(D_stat),
            .D_icode_i(D_icode),
            .D_ifun_i(D_ifun),
            .D_valC_i(D_valC),
            .d_valA_i(d_valA),
            .d_valB_i(d_valB),
            .D_dstE_i(D_dstE),
            .D_dstM_i(D_dstM),
            .D_srcA_i(D_rA),
            .D_srcB_i(D_rB),

            .E_stat_o(E_stat),
            .E_icode_o(E_icode),
            .E_ifun_o(E_ifun),
            .E_valC_o(E_valC),
            .E_valA_o(E_valA),
            .E_valB_o(E_valB),
            .E_dstE_o(E_dstE),
            .E_dstM_o(E_dstM)
      );

      alu_args y86_alu_args
      (
            .E_icode_i(E_icode),
            .E_ifun_i(E_ifun),
            .E_valC_i(E_valC),
            .E_valA_i(E_valA),
            .E_valB_i(E_valB),
            
            .aluA_o(aluA),
            .aluB_o(aluB),
            .fun_o(fun)
      );

      alu y86_alu
      (
            .aluA_i(aluA),
            .aluB_i(aluB),
            .fun_i(fun),

            .e_valE_o(e_valE),
            .ZF_o(ZF),
            .SF_o(SF),
            .OF_o(OF)
      );

      set_cond y86_set_cond
      (
            .set_cc_i(set_cc),
            .E_icode_i(E_icode),
            .E_ifun_i(E_ifun),
            .E_dstE_i(E_dstE),
            .ZF_i(ZF),
            .SF_i(SF),
            .OF_i(OF),

            .e_Cnd_o(e_Cnd),
            .e_dstE_o(e_dstE)
      );

      mem_reg y86_mem_reg
      (
            .clk(clk),
            .rst(rst),
            .e_Cnd_i(e_Cnd),
            .M_bubble_i(M_bubble),
            .E_stat_i(E_stat),
            .E_icode_i(E_icode),
            .e_dstE_i(e_dstE),
            .e_valE_i(e_valE),
            .E_dstM_i(E_dstM),
            .E_valA_i(E_valA),
            
            .M_Cnd_o(M_Cnd),
            .M_stat_o(M_stat),
            .M_icode_o(M_icode),
            .M_dstE_o(M_dstE),
            .M_valE_o(M_valE),
            .M_dstM_o(M_dstM),
            .M_valA_o(M_valA)
      );

      mem y86_mem
      (
            .M_icode_i(M_icode),
            .M_valA_i(M_valA),
            .M_valE_i(M_valE),

            .addr(addr),
            .write(write)
      );

      set_m_stat y86_set_m_stat
      (
            .M_stat_i(M_stat),
            .mem_error_i(d_mem_error),

            .m_stat_o(m_stat)
      );

      write_reg y86_write_reg
      (
            .clk(clk),
            .rst(rst),
            .W_stall_i(W_stall),
            .m_stat_i(m_stat),
            .M_icode_i(M_icode),
            .M_valE_i(M_valE),
            .m_valM_i(data),
            .M_dstE_i(M_dstE),
            .M_dstM_i(M_dstM),
            
            .W_stat_o(W_stat),
            .W_icode_o(W_icode),
            .W_dstE_o(W_dstE),
            .W_valE_o(W_valE),
            .W_dstM_o(W_dstM),
            .W_valM_o(W_valM)
      );

      registers y86_registers
      (
            .clk(clk),
            .rst(rst),
            .W_dstE_i(W_dstE),
            .W_valE_i(W_valE),
            .W_dstM_i(W_dstM),
            .W_valM_i(W_valM),
            .D_rA_i(D_rA),
            .D_rB_i(D_rB),

            .r_valA_o(r_valA),
            .r_valB_o(r_valB)
      );
endmodule