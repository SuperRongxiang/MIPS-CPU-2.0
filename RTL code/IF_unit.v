module IF_unit (clk,rst_n,pre_pc,pre_taken,update_predictor_en,update_BTB_en,real_br_taken,pc_update,real_bjpc,pre_fetch_wrong,epc,inst1_IR_out,inst2_IR_out,pc1_IR_out,pc2_IR_out);
    input clk,rst_n;

    //refetch pc
    input pre_fetch_wrong;
    //interupt return
    input [31:0] epc;
    //update predictor and BTB
    input update_predictor_en,real_br_taken,update_BTB_en;
    input [31:0] pc_update,real_bjpc;   //pc_update is the pc of branch insts; real_bjpc is the corresponding jump addr of branch inst
    //send insts to decode unit
    output [31:0] inst1_IR_out,inst2_IR_out;
    //output prediction info. to commit unit
    output pre_taken;
    output [31:0] pre_pc;
    //output the corresponding pc of insts
    output [31:0] pc1_IR_out,pc2_IR_out;


    //[pipe reg 1]program counter registers before IF1//
    wire pc_reg_IF1_en=1'b1;
    wire [31:0] final_next_pc1,final_next_pc2,pc1_IF1,pc2_IF1;
    dffe32 pc1_reg_IF1 (.d(final_next_pc1),.clk(clk),.rst_n(rst_n),.en(pc_reg_IF1_en),.q(pc1_IF1));
    dffe32 pc2_reg_IF1 (.d(final_next_pc2),.clk(clk),.rst_n(rst_n),.en(pc_reg_IF1_en),.q(pc2_IF1));



    //[IF stage1] (including cache,TLB,and cache miss control)//
    wire cache_miss;
    wire [31:0] inst1,inst2; 
    inst_mem inst_cache (.pc1(pc1_IF1),.pc2(pc2_IF1),.inst1(inst1),.inst2(inst2),.cache_miss(cache_miss));
    assign pc_reg_IF1_en=~cache_miss;



    //[pipe reg 2]program counter registers and inst reg before IF2//
    wire inst_reg_IF2_en=1'b1;
    wire pc_reg_IF2_en=1'b1;
    wire cancel_reg_IF2_en=1'b1;
    wire cancel_next_two_insts;
    wire [31:0] pc1_IF2,pc2_IF2,inst1_IF2,inst2_IF2;
    dffe32 pc1_reg_IF2 (.d(pc1_IF1),.clk(clk),.rst_n(rst_n),.en(pc_reg_IF2_en),.q(pc1_IF2));
    dffe32 pc2_reg_IF2 (.d(pc2_IF1),.clk(clk),.rst_n(rst_n),.en(pc_reg_IF2_en),.q(pc2_IF2));
    dffe32 inst1_reg_IF2 (.d(inst1),.clk(clk),.rst_n(rst_n),.en(inst_reg_IF2_en),.q(inst1_IF2));
    dffe32 inst2_reg_IF2 (.d(inst2),.clk(clk),.rst_n(rst_n),.en(inst_reg_IF2_en),.q(inst2_IF2));
    dffe1 cancel_sig_reg (.clk(clk),.rst_n(rst_n),.en(cancel_reg_IF2_en),.datain(cancel_next_two_insts),.dataout(cancel_next_two_insts_IF2));



    //[IF stage2] (including predecoder,BTC,predictor,adder and so on)//
    //predecode of inst 1
    wire [5:0] op1,func1;
    wire i_j1,i_jal1,i_jr1,i_beq1,i_bne1,r_type1;
    assign op1=inst1_IF2[31:26];
    assign func1=inst1_IF2[5:0];
    and(r_type1,~op1[5],~op1[4],~op1[3],~op1[2],~op1[1],~op1[0]);
    and(i_jr1,r_type1,~func1[5],~func1[4],func1[3],~func1[2],~func1[1],~func1[0]);
    and(i_j1,~op1[5],~op1[4],~op1[3],~op1[2],op1[1],~op1[0]);
	and(i_jal1,~op1[5],~op1[4],~op1[3],~op1[2],op1[1],op1[0]);
    and(i_beq1,~op1[5],~op1[4],~op1[3],op1[2],~op1[1],~op1[0]);
	and(i_bne1,~op1[5],~op1[4],~op1[3],op1[2],~op1[1],op1[0]);
    assign i_jump_1=i_j1|i_jal1|i_jr1;
    assign i_branch_1=i_beq1|i_bne1;
    wire i_brju_1=i_jump_1|i_branch_1;
    //predecode of inst 2
    wire [5:0] op2,func2;
    wire i_j2,i_jal2,i_jr2,i_beq2,i_bne2,r_type2;
    assign op2=inst2_IF2[31:26];
    assign func2=inst2_IF2[5:0];
    and(r_type2,~op2[5],~op2[4],~op2[3],~op2[2],~op2[1],~op2[0]);
    and(i_jr2,r_type2,~func2[5],~func2[4],func2[3],~func2[2],~func2[1],~func2[0]);
    and(i_j2,~op2[5],~op2[4],~op2[3],~op2[2],op2[1],~op2[0]);
	and(i_jal2,~op2[5],~op2[4],~op2[3],~op2[2],op2[1],op2[0]);
    and(i_beq2,~op2[5],~op2[4],~op2[3],op2[2],~op2[1],~op2[0]);
	and(i_bne2,~op2[5],~op2[4],~op2[3],op2[2],~op2[1],op2[0]);
    assign i_jump_2=i_j2|i_jal2|i_jr2;
    assign i_branch_2=i_beq2|i_bne2;
    wire i_brju_2=i_jump_2|i_branch_2;
    //predictor and BTB
    wire pre_taken;
    wire [31:0] pc_pre; //branch inst's pc
    mux2x32 sel_brju_inst (.data1(pc1_IF2),.data2(pc2_IF2),.sel(i_brju_2),.dataout(pc_pre));
    sixteen_way_two_level_predictor main_predictor (.clk(clk),.rst_n(rst_n),.update_en(update_predictor_en),.pc_pre(pc_pre),.pc_update(pc_update),
                                                    .real_br_taken(real_br_taken),.pre_taken(pre_taken));
    wire sel_pc_pre=i_brju_2;
    wire read_pc_hit,read_inst_hit;
    wire [31:0] pre_bjpc,pre_bjinst;
    branch_target_buffer BTB (.clk(clk),.rst_n(rst_n),.ud_BTB_en(update_BTB_en),.pc_pre(pc_pre),.pre_bjpc(pre_bjpc),.pre_bjinst(pre_bjinst),
                            .pc_update(pc_update),.read_pc_hit(read_pc_hit),.read_inst_hit(read_inst_hit),.real_bjpc(real_bjpc),
                            .pc1_IF2(pc1_IF2),.pc2_IF2(pc2_IF2),.inst1_IF2(inst1_IF2),.inst2_IF2(inst2_IF2));
    //calculate next two insts' pc and sel
    wire EXC_BASE=32'h0000_0008;
    wire inst1_bjpc_hit_and_jump=i_brju_1&pre_taken&read_pc_hit;
    wire inst2_bjpc_hit_and_jump=i_brju_2&pre_taken&read_pc_hit;
    wire sel_plus_4_in_l1_selsig=inst1_bjpc_hit_and_jump|inst2_bjpc_hit_and_jump;
    assign cancel_next_two_insts=sel_plus_4_in_l1_selsig;
    wire [31:0] plus_4,plus_8;
    wire [31:0] plus_4_in_l1,plus_4_in_l2,plus_8_in;
    wire [31:0] pre_next_pc1,pre_next_pc2;
    mux2x32 sel_plus_4_in_l1    (.data1(pc2_IF2),.data2(pre_bjpc),.sel(sel_plus_4_in_l1_selsig),.dataout(plus_4_in_l1));   //predict pcs
    mux4x32 sel_plus_4_in_l2    (.data1(plus_4_in_l1),.data2(real_bjpc),.data3(epc),.data4(EXC_BASE),.sel(sel_final_pcs),.dataout(plus_4_in_l2));
    mux2x32 sel_plus_8_in   (.data1(pc2_IF2),.data2(pre_bjpc),.sel(inst1_bjpc_hit_and_jump),.dataout(plus_8_in));
    adder32 PC2_IF2_plus_4  (.a(plus_4_in_l2),.b(32'h0000_0004),.r(plus_4));
    adder32 PC2_IF2_plus_8  (.a(plus_8_in),.b(32'h0000_0008),.r(plus_8));
    mux2x32 sel_next_pc1    (.data1(plus_4),.data2(pre_bjpc),.sel(inst2_bjpc_hit_and_jump),.dataout(pre_next_pc1));
    mux2x32 sel_next_pc2    (.data1(plus_8),.data2(plus_4),.sel(inst2_bjpc_hit_and_jump),.dataout(pre_next_pc2));
    //sel final next pc1 and pc2
    wire sel_final_next_pc2_selsig=|sel_final_pcs;
    mux4x32 sel_final_next_pc1  (.data1(pre_next_pc1),.data2(real_bjpc),.data3(epc),.data4(EXC_BASE),.sel(sel_final_pcs),.dataout(final_next_pc1));
    mux2x32 sel_final_next_pc2  (.data1(pre_next_pc2),.data2(plus_4),.sel(sel_final_next_pc2_selsig),.dataout(final_next_pc2));
    //sel insts sent to decode unit
    wire [31:0] inst1_IR,inst2_IR_l1,inst2_IR_l2;
    assign inst1_IR={32{~cancel_next_two_insts_IF2}}&inst1_IF2;
    //mux2x32 sel_inst1_IR (.data1(inst1_IF2),.data2(32'h0000_0000),.sel(cancel_next_two_insts_IF2),.dataout(inst1_IR));
    wire sel_inst2_IR_selsig={inst1_bjpc_hit_and_jump,read_inst_hit};
    mux2x32 sel_inst2_IR_l1 (.data1(inst2_IF2),.data2(inst2_IF2),.data3(32'h0000_0000),.data4(pre_bjinst),.sel(sel_inst2_IR_selsig),.dataout(inst2_IR_l1));
    mux2x32 sel_inst2_IR_l2 (.data1(inst2_IR_l1),.data2(32'h0000_0000),.sel(cancel_next_two_insts_IF2),.dataout(inst2_IR_l2));



    //[pipe reg 3] IR regs
    wire IR_reg_en=1'b1;
    wire [31:0] pc1_IR_out,pc2_IR_out,inst1_IR_out,inst2_IR_out;
    dffe32 pc1_reg_IR (.d(pc1_IF2),.clk(clk),.rst_n(rst_n),.en(pc_reg_IF2_en),.q(pc1_IR_out));
    dffe32 pc2_reg_IR (.d(pc2_IF2),.clk(clk),.rst_n(rst_n),.en(pc_reg_IF2_en),.q(pc2_IR_out));
    dffe32 inst1_reg_IR (.d(inst1_IR),.clk(clk),.rst_n(rst_n),.en(IR_reg_en),.q(inst1_IR_out));
    dffe32 inst2_reg_IR (.d(inst2_IR_l2),.clk(clk),.rst_n(rst_n),.en(IR_reg_en),.q(inst2_IR_out));
endmodule