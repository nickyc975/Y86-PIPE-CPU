module y86cpu(
      input wire rst_i,
      input wire clk_i,
      input wire [79:0] inst_i,
      input wire [63:0] data_i,
      input wire i_mem_error_i,
      input wire d_mem_error_i,

      output wire write_o,
      output wire [63:0] pc_o,
      output wire [63:0] addr_o,
      output wire [63:0] data_o
      );
  
  

      wire clk;
      wire rst;
      wire [79:0] inst;
      wire [63:0] data;
      wire i_mem_error;
      wire d_mem_error;

      wire [63:0] F_predPC;

      wire [63:0] f_pc;
      
      wire [3:0]  f_icode;
      wire [3:0]  f_ifun;
      wire [3:0]  f_rA;
      wire [3:0]  f_rB;
      wire [63:0] f_valC;
      wire [63:0] f_valP;
      wire [3:0]  f_dstE;
      wire [3:0]  f_dstM;
      wire [63:0] f_predPC;
      wire [2:0]  f_stat;
      
      wire [3:0]  D_icode;
      wire [3:0]  D_ifun;
      wire [3:0]  D_rA;
      wire [3:0]  D_rB;
      wire [63:0] D_valC;
      wire [63:0] D_valP;
      wire [3:0]  D_dstE;
      wire [3:0]  D_dstM;
      wire [2:0]  D_stat;

      wire [63:0] d_valA;
      wire [63:0] d_valB;

      wire [2:0]  E_stat;
      wire [3:0]  E_icode;
      wire [3:0]  E_ifun;
      wire [63:0] E_valC;
      wire [63:0] E_valA;
      wire [63:0] E_valB;
      wire [3:0]  E_dstE;
      wire [3:0]  E_dstM;

      wire [63:0] aluA;
      wire [63:0] aluB;
      wire [3:0]  fun;

      wire [63:0] e_valE;
      wire OF;
      wire SF;
      wire ZF;

      wire e_Cnd;
      wire [3:0]  e_dstE;

      wire M_Cnd;
      wire [2:0]  M_stat;
      wire [3:0]  M_icode;
      wire [3:0]  M_dstE;
      wire [63:0] M_valA;
      wire [63:0] M_valE;
      wire [3:0]  M_dstM;

      wire [63:0] addr;
      wire write;
      
      wire [63:0] r_valA;
      wire [63:0] r_valB;
      
      wire [2:0]  W_stat;
      wire [3:0]  W_icode;
      wire [3:0]  W_dstE;
      wire [3:0]  W_dstM;
      wire [63:0] W_valE;
      wire [63:0] W_valM;

      assign clk = clk_i;
      assign rst = rst_i;
      assign inst = inst_i[79:0];
      assign data = data_i[63:0];
      assign i_mem_error = i_mem_error_i;
      assign d_mem_error = d_mem_error_i;

      assign write_o = write;
      assign addr_o[63:0] = addr;
      assign data_o[63:0] = M_valA;
      assign pc_o[63:0] = f_pc;

      fetch_reg y86_fetch_reg
      (
            .clk(clk),
            .rst(rst),
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
            .W_stat_i(W_stat),
            .m_stat_i(M_stat),
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

      write_reg y86_write_reg
      (
            .clk(clk),
            .rst(rst),
            .m_stat_i(M_stat),
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