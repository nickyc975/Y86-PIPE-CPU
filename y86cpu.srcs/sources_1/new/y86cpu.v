`timescale 1 ps / 1 ps

module y86cpu
   (addr,
    clk,
    data_i,
    data_o,
    inst,
    pc,
    rst,
    rw);
  output [63:0]addr;
  input clk;
  input [63:0]data_i;
  output [63:0]data_o;
  input [79:0]inst;
  output [63:0]pc;
  input rst;
  output rw;

  wire alu_0_OF;
  wire alu_0_SF;
  wire alu_0_ZF;
  wire [63:0]alu_0_e_valE;
  wire [63:0]alu_args_0_aluA;
  wire [63:0]alu_args_0_aluB;
  wire [3:0]alu_args_0_fun;
  wire clk_1;
  wire [63:0]d_mem_0_data_o;
  wire [63:0]decode_0_valA;
  wire [63:0]decode_0_valB;
  wire [3:0]decode_reg_0_dstE_o;
  wire [3:0]decode_reg_0_dstM_o;
  wire [3:0]decode_reg_0_icode_o;
  wire [3:0]decode_reg_0_ifun_o;
  wire [3:0]decode_reg_0_rA_o;
  wire [3:0]decode_reg_0_rB_o;
  wire [2:0]decode_reg_0_stat_o;
  wire [63:0]decode_reg_0_valC_o;
  wire [63:0]decode_reg_0_valP_o;
  wire [3:0]execute_reg_0_E_dstE;
  wire [3:0]execute_reg_0_E_dstM;
  wire [3:0]execute_reg_0_E_icode;
  wire [3:0]execute_reg_0_E_ifun;
  wire [2:0]execute_reg_0_E_stat;
  wire [63:0]execute_reg_0_E_valA;
  wire [63:0]execute_reg_0_E_valB;
  wire [63:0]execute_reg_0_E_valC;
  wire [3:0]fetch_0_dstE;
  wire [3:0]fetch_0_dstM;
  wire [3:0]fetch_0_icode;
  wire [3:0]fetch_0_ifun;
  wire [63:0]fetch_0_predPC;
  wire [3:0]fetch_0_rA;
  wire [3:0]fetch_0_rB;
  wire [2:0]fetch_0_stat;
  wire [63:0]fetch_0_valC;
  wire [63:0]fetch_0_valP;
  wire [63:0]fetch_reg_0_predPC_o;
  wire [79:0]inst_1;
  wire [63:0]mem_0_addr;
  wire mem_0_write;
  wire mem_reg_0_M_Cnd;
  wire [3:0]mem_reg_0_M_dstE;
  wire [3:0]mem_reg_0_M_dstM;
  wire [3:0]mem_reg_0_M_icode;
  wire [2:0]mem_reg_0_M_stat;
  wire [63:0]mem_reg_0_M_valA;
  wire [63:0]mem_reg_0_M_valE;
  wire [63:0]registers_0_valA;
  wire [63:0]registers_0_valB;
  wire rst_1;
  wire [63:0]select_pc_0_f_pc;
  wire set_cond_0_e_Cnd;
  wire [3:0]set_cond_0_e_dstE;
  wire [3:0]write_reg_0_W_dstE;
  wire [3:0]write_reg_0_W_dstM;
  wire [3:0]write_reg_0_W_icode;
  wire [2:0]write_reg_0_W_stat;
  wire [63:0]write_reg_0_W_valE;
  wire [63:0]write_reg_0_W_valM;

  assign addr[63:0] = mem_0_addr;
  assign clk_1 = clk;
  assign d_mem_0_data_o = data_i[63:0];
  assign data_o[63:0] = mem_reg_0_M_valA;
  assign inst_1 = inst[79:0];
  assign pc[63:0] = select_pc_0_f_pc;
  assign rst_1 = rst;
  assign rw = mem_0_write;

  alu alu_0
       (.OF(alu_0_OF),
        .SF(alu_0_SF),
        .ZF(alu_0_ZF),
        .aluA(alu_args_0_aluA),
        .aluB(alu_args_0_aluB),
        .e_valE(alu_0_e_valE),
        .fun(alu_args_0_fun));

  alu_args alu_args_0
       (.E_icode(execute_reg_0_E_icode),
        .E_ifun(execute_reg_0_E_ifun),
        .E_valA(execute_reg_0_E_valA),
        .E_valB(execute_reg_0_E_valB),
        .E_valC(execute_reg_0_E_valC),
        .aluA(alu_args_0_aluA),
        .aluB(alu_args_0_aluB),
        .fun(alu_args_0_fun));

  decode decode_0
       (.M_dstE(mem_reg_0_M_dstE),
        .M_dstM(mem_reg_0_M_dstM),
        .M_valE(mem_reg_0_M_valE),
        .W_dstE(write_reg_0_W_dstE),
        .W_dstM(write_reg_0_W_dstM),
        .W_valE(write_reg_0_W_valE),
        .W_valM(write_reg_0_W_valM),
        .d_rvalA(registers_0_valA),
        .d_rvalB(registers_0_valB),
        .d_srcA(decode_reg_0_rA_o),
        .d_srcB(decode_reg_0_rB_o),
        .e_dstE(set_cond_0_e_dstE),
        .e_valE(alu_0_e_valE),
        .icode(decode_reg_0_icode_o),
        .m_valM(d_mem_0_data_o),
        .valA(decode_0_valA),
        .valB(decode_0_valB),
        .valP(decode_reg_0_valP_o));

  decode_reg decode_reg_0
       (.clk(clk_1),
        .dstE_i(fetch_0_dstE),
        .dstE_o(decode_reg_0_dstE_o),
        .dstM_i(fetch_0_dstM),
        .dstM_o(decode_reg_0_dstM_o),
        .icode_i(fetch_0_icode),
        .icode_o(decode_reg_0_icode_o),
        .ifun_i(fetch_0_ifun),
        .ifun_o(decode_reg_0_ifun_o),
        .rA_i(fetch_0_rA),
        .rA_o(decode_reg_0_rA_o),
        .rB_i(fetch_0_rB),
        .rB_o(decode_reg_0_rB_o),
        .rst(rst_1),
        .stat_i(fetch_0_stat),
        .stat_o(decode_reg_0_stat_o),
        .valC_i(fetch_0_valC),
        .valC_o(decode_reg_0_valC_o),
        .valP_i(fetch_0_valP),
        .valP_o(decode_reg_0_valP_o));

  execute_reg execute_reg_0
       (.D_icode(decode_reg_0_icode_o),
        .D_ifun(decode_reg_0_ifun_o),
        .D_stat(decode_reg_0_stat_o),
        .D_valC(decode_reg_0_valC_o),
        .E_dstE(execute_reg_0_E_dstE),
        .E_dstM(execute_reg_0_E_dstM),
        .E_icode(execute_reg_0_E_icode),
        .E_ifun(execute_reg_0_E_ifun),
        .E_stat(execute_reg_0_E_stat),
        .E_valA(execute_reg_0_E_valA),
        .E_valB(execute_reg_0_E_valB),
        .E_valC(execute_reg_0_E_valC),
        .clk(clk_1),
        .d_dstE(decode_reg_0_dstE_o),
        .d_dstM(decode_reg_0_dstM_o),
        .d_srcA(decode_reg_0_rA_o),
        .d_srcB(decode_reg_0_rB_o),
        .d_valA(decode_0_valA),
        .d_valB(decode_0_valB),
        .rst(rst_1));

  fetch fetch_0
       (.dstE(fetch_0_dstE),
        .dstM(fetch_0_dstM),
        .f_pc(select_pc_0_f_pc),
        .icode(fetch_0_icode),
        .ifun(fetch_0_ifun),
        .inst_i(inst_1),
        .predPC(fetch_0_predPC),
        .rA(fetch_0_rA),
        .rB(fetch_0_rB),
        .stat(fetch_0_stat),
        .valC(fetch_0_valC),
        .valP(fetch_0_valP));

  fetch_reg fetch_reg_0
       (.clk(clk_1),
        .predPC_i(fetch_0_predPC),
        .predPC_o(fetch_reg_0_predPC_o),
        .rst(rst_1));

  mem mem_0
       (.M_icode(mem_reg_0_M_icode),
        .M_valA(mem_reg_0_M_valA),
        .M_valE(mem_reg_0_M_valE),
        .addr(mem_0_addr),
        .write(mem_0_write));

  mem_reg mem_reg_0
       (.E_dstM(execute_reg_0_E_dstM),
        .E_icode(execute_reg_0_E_icode),
        .E_stat(execute_reg_0_E_stat),
        .M_Cnd(mem_reg_0_M_Cnd),
        .M_dstE(mem_reg_0_M_dstE),
        .M_dstM(mem_reg_0_M_dstM),
        .M_icode(mem_reg_0_M_icode),
        .M_stat(mem_reg_0_M_stat),
        .M_valA(mem_reg_0_M_valA),
        .M_valE(mem_reg_0_M_valE),
        .clk(clk_1),
        .e_Cnd(set_cond_0_e_Cnd),
        .e_dstE(set_cond_0_e_dstE),
        .e_valA(execute_reg_0_E_valA),
        .e_valE(alu_0_e_valE),
        .rst(rst_1));

  registers registers_0
       (.clk(clk_1),
        .dstE(write_reg_0_W_dstE),
        .dstW(write_reg_0_W_dstM),
        .rst(rst_1),
        .srcA(decode_reg_0_rA_o),
        .srcB(decode_reg_0_rB_o),
        .valA(registers_0_valA),
        .valB(registers_0_valB),
        .valE(write_reg_0_W_valE),
        .valW(write_reg_0_W_valM));

  select_pc select_pc_0
       (.F_predPC(fetch_reg_0_predPC_o),
        .M_Cnd(mem_reg_0_M_Cnd),
        .M_icode(mem_reg_0_M_icode),
        .M_valA(mem_reg_0_M_valA),
        .W_icode(write_reg_0_W_icode),
        .W_valM(write_reg_0_W_valM),
        .f_pc(select_pc_0_f_pc),
        .rst(rst_1));

  set_cond set_cond_0
       (.E_icode(execute_reg_0_E_icode),
        .E_ifun(execute_reg_0_E_ifun),
        .E_dstE(execute_reg_0_E_dstE),
        .OF_i(alu_0_OF),
        .SF_i(alu_0_SF),
        .W_stat(write_reg_0_W_stat),
        .ZF_i(alu_0_ZF),
        .clk(clk_1),
        .e_Cnd(set_cond_0_e_Cnd),
        .e_dstE(set_cond_0_e_dstE),
        .m_stat(mem_reg_0_M_stat),
        .rst(rst_1));
        
  write_reg write_reg_0
       (.M_dstE(mem_reg_0_M_dstE),
        .M_dstM(mem_reg_0_M_dstM),
        .M_icode(mem_reg_0_M_icode),
        .M_valE(mem_reg_0_M_valE),
        .W_dstE(write_reg_0_W_dstE),
        .W_dstM(write_reg_0_W_dstM),
        .W_icode(write_reg_0_W_icode),
        .W_stat(write_reg_0_W_stat),
        .W_valE(write_reg_0_W_valE),
        .W_valM(write_reg_0_W_valM),
        .clk(clk_1),
        .m_stat(mem_reg_0_M_stat),
        .m_valM(d_mem_0_data_o),
        .rst(rst_1));
endmodule