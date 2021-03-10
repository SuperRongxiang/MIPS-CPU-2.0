module ID_unit  (clk,rst_n,inst1_IR,inst2_IR,pc1_IR,pc2_IR,i_nop1_out,mem_wen1,float_reg_wen1,int_reg_wen1,opcode1,detail_opcode1,
                reg_relation1,final_operand_a1,final_operand_b1,dest_reg1,pc1_ID2,i_nop2_out,mem_wen2,float_reg_wen2,int_reg_wen2,opcode2
                ,detail_opcode2,reg_relation2,final_operand_a2,final_operand_b2,dest_reg2,pc2_ID2);
    input clk,rst_n;
    input inst1_IR,inst2_IR;
    input [31:0] pc1_IR,pc2_IR;

    //output decode result of inst 1
    output i_nop1_out,mem_wen1,float_reg_wen1,int_reg_wen1;
    output [5:0] opcode1;
    output [2:0] detail_opcode1;
    output [3:0] reg_relation1;
    output [4:0] final_operand_a1;
    output [4:0] final_operand_b1;
    output [4:0] dest_reg1;
    output [31:0] pc1_ID2;

    //output decode result of inst 2
    output i_nop2_out,mem_wen2,float_reg_wen2,int_reg_wen2;
    output [5:0] opcode2;
    output [2:0] detail_opcode2;
    output [3:0] reg_relation2;
    output [4:0] final_operand_a2;
    output [4:0] final_operand_b2;
    output [4:0] dest_reg2;
    output [31:0] pc2_ID2;


    //[decode stage 1] predecode
    wire    i_add1,i_sub1,i_and1,i_or1,i_xor1,i_sll1,i_srl1,i_sra1,i_jr1,i_addi1,i_andi1,i_ori1,i_xori1,i_lw1,i_sw1,i_beq1,i_bne1,i_lui1,
            i_j1,i_jal1,i_lwc11,i_swc11,i_fadd1,i_fsub1,i_fmul1,i_fdiv1,i_fsqrt1,i_mfc01,i_mtc01,i_eret1,i_syscall1,unimplemented_inst1
            ,i_nop1;
    wire [4:0]  rs1,rt1,rd1,fs1,ft1,fd1;
    wire [15:0] imm1,address1;
    wire [4:0] sa1;
    inst_predecoder predecoder1 (.inst(inst1_IR),.i_add(i_add1),.i_sub(i_sub1),.i_and(i_and1),.i_or(i_or1),.i_xor(i_xor1),.i_sll(i_sll1),
                                .i_srl(i_srl1),.i_sra(i_sra1),.i_jr(i_jr1),.i_addi(i_addi1),.i_andi(i_andi1),.i_ori(i_ori1),.i_xori(i_xori1),
                                .i_lw(i_lw1),.i_sw(i_sw1),.i_beq(i_beq1),.i_bne(i_bne1),.i_lui(i_lui1),.i_j(i_j1),.i_jal(i_jal1),.i_lwc1(i_lwc11),
                                .i_swc1(i_swc11),.i_fadd(i_fadd1),.i_fsub(i_fsub1),.i_fmul(i_fmul1),.i_fdiv(i_fdiv1),.i_fsqrt(i_fsqrt1),.i_mfc0(i_mfc01),
                                .i_mtc0(i_mtc01),.i_eret(i_eret1),.i_syscall(i_syscall1),
                                .unimplemented_inst(unimplemented_inst1),.i_nop(i_nop1),.rs(rs1),.rt(rt1),.rd(rd1),.fs(fs1),.ft(ft1),.fd(fd1),.imm(imm1),.address(address1),
                                .sa(sa1));
    wire    i_add2,i_sub2,i_and2,i_or2,i_xor2,i_sll2,i_srl2,i_sra2,i_jr2,i_addi2,i_andi2,i_ori2,i_xori2,i_lw2,i_sw2,i_beq2,i_bne2,i_lui2,
            i_j2,i_jal2,i_lwc12,i_swc12,i_fadd2,i_fsub2,i_fmul2,i_fdiv2,i_fsqrt2,i_mfc02,i_mtc02,i_eret2,i_syscall2,unimplemented_inst2
            ,i_nop2;
    wire [4:0]  rs2,rt2,rd2,fs2,ft2,fd2;
    wire [15:0] imm2,address2;
    wire [4:0] sa2;
    inst_predecoder predecoder2 (.inst(inst2_IR),.i_add(i_add2),.i_sub(i_sub2),.i_and(i_and2),.i_or(i_or2),.i_xor(i_xor2),.i_sll(i_sll2),
                                .i_srl(i_srl2),.i_sra(i_sra2),.i_jr(i_jr2),.i_addi(i_addi2),.i_andi(i_andi2),.i_ori(i_ori2),.i_xori(i_xori2),
                                .i_lw(i_lw2),.i_sw(i_sw2),.i_beq(i_beq2),.i_bne(i_bne2),.i_lui(i_lui2),.i_j(i_j2),.i_jal(i_jal2),.i_lwc1(i_lwc12),
                                .i_swc1(i_swc12),.i_fadd(i_fadd2),.i_fsub(i_fsub2),.i_fmul(i_fmul2),.i_fdiv(i_fdiv2),.i_fsqrt(i_fsqrt2),.i_mfc0(i_mfc02),
                                .i_mtc0(i_mtc02),.i_eret(i_eret2),.i_syscall(i_syscall2),.unimplemented_inst(unimplemented_inst2),.i_nop(i_nop2),.rs(rs2),
                                .rt(rt2),.rd(rd2),.fs(fs2),.ft(ft2),.fd(fd2),.imm(imm2),.address(address2),.sa(sa2));



    //[pipe reg 1] transfer predecode results
    wire pipe_reg_1_en=1'b1;
    reg i_add1_ID2,i_sub1_ID2,i_and1_ID2,i_or1_ID2,i_xor1_ID2,i_sll1_ID2,i_srl1_ID2,i_sra1_ID2,i_jr1_ID2;
    reg i_addi1_ID2,i_andi1_ID2,i_ori1_ID2,i_xori1_ID2,i_lw1_ID2,i_sw1_ID2,i_beq1_ID2,i_bne1_ID2,i_lui1_ID2,i_j1_ID2,i_jal1_ID2;
    reg i_lwc11_ID2,i_swc11_ID2,i_fadd1_ID2,i_fsub1_ID2,i_fmul1_ID2,i_fdiv1_ID2,i_fsqrt1_ID2;
    reg i_mfc01_ID2,i_mtc01_ID2,i_eret1_ID2,i_syscall1_ID2,unimplemented_inst1_ID2,i_nop1_ID2;
    reg [4:0]  rs1_ID2,rt1_ID2,rd1_ID2,fs1_ID2,ft1_ID2,fd1_ID2;
    reg [15:0] imm1_ID2,address1_ID2;
    reg [4:0] sa1_ID2;
    reg [31:0] pc1_ID2;
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            i_add1_ID2<=1'b0;    i_sub1_ID2<=1'b0;    i_and1_ID2<=1'b0;    i_or1_ID2<=1'b0;     i_xor1_ID2<=1'b0;    i_sll1_ID2<=1'b0;    
            i_srl1_ID2<=1'b0;    i_sra1_ID2<=1'b0;    i_jr1_ID2<=1'b0;    
            i_addi1_ID2<=1'b0;   i_andi1_ID2<=1'b0;   i_ori1_ID2<=1'b0;    i_xori1_ID2<=1'b0;   i_lw1_ID2<=1'b0;     i_sw1_ID2<=1'b0;    
            i_beq1_ID2<=1'b0;    i_bne1_ID2<=1'b0;    i_lui1_ID2<=1'b0;    i_j1_ID2<=1'b0;      i_jal1_ID2<=1'b0;    
            i_lwc11_ID2<=1'b0;   i_swc11_ID2<=1'b0;   i_fadd1_ID2<=1'b0;   i_fsub1_ID2<=1'b0;   i_fmul1_ID2<=1'b0;   i_fdiv1_ID2<=1'b0;    
            i_fsqrt1_ID2<=1'b0;
            i_mfc01_ID2<=1'b0;  i_mtc01_ID2<=1'b0;      i_eret1_ID2<=1'b0;  i_syscall1_ID2<=1'b0;   unimplemented_inst1_ID2<=1'b0;  i_nop1_ID2<=1'b0;
            rs1_ID2<=5'b0;      rt1_ID2<=5'b0;      rd1_ID2<=5'b0;      fs1_ID2<=5'b0;      ft1_ID2<=5'b0;      fd1_ID2<=5'b0;
            imm1_ID2<=16'b0;    address1_ID2<=16'b0;
            sa1_ID2<=5'b0;
            pc1_ID2<=32'h0;
        end
        else if (pipe_reg_1_en) begin
            i_add1_ID2<=i_add1;   i_sub1_ID2<=i_sub1;   i_and1_ID2<=i_and1;   i_or1_ID2<=i_or1;     i_xor1_ID2<=i_xor1;   i_sll1_ID2<=i_sll1;    
            i_srl1_ID2<=i_srl1;   i_sra1_ID2<=i_sra1;   i_jr1_ID2<=i_jr1;    
            i_addi1_ID2<=i_addi1; i_andi1_ID2<=i_andi1; i_ori1_ID2<=i_ori1;   i_xori1_ID2<=i_xori1; i_lw1_ID2<=i_lw1;     i_sw1_ID2<=i_sw1;    
            i_beq1_ID2<=i_beq1;   i_bne1_ID2<=i_bne1;   i_lui1_ID2<=i_lui1;   i_j1_ID2<=i_j1;       i_jal1_ID2<=i_jal1;    
            i_lwc11_ID2<=i_lwc11; i_swc11_ID2<=i_swc11; i_fadd1_ID2<=i_fadd1; i_fsub1_ID2<=i_fsub1; i_fmul1_ID2<=i_fmul1; i_fdiv1_ID2<=i_fdiv1;    
            i_fsqrt1_ID2<=i_fsqrt1;
            i_mfc01_ID2<=i_mfc01;    i_mtc01_ID2<=i_mtc01;    i_eret1_ID2<=i_eret1;    i_syscall1_ID2<=i_syscall1; unimplemented_inst1_ID2<=unimplemented_inst1;   i_nop1_ID2<=i_nop1;
            rs1_ID2<=rs1;      rt1_ID2<=rt1;      rd1_ID2<=rd1;      fs1_ID2<=fs1;      ft1_ID2<=ft1;      fd1_ID2<=fd1;
            imm1_ID2<=imm1;    address1_ID2<=address1;
            sa1_ID2<=sa1;
            pc1_ID2<=pc1_IR;
        end
    end

    reg i_add2_ID2,i_sub2_ID2,i_and2_ID2,i_or2_ID2,i_xor2_ID2,i_sll2_ID2,i_srl2_ID2,i_sra2_ID2,i_jr2_ID2;
    reg i_addi2_ID2,i_andi2_ID2,i_ori2_ID2,i_xori2_ID2,i_lw2_ID2,i_sw2_ID2,i_beq2_ID2,i_bne2_ID2,i_lui2_ID2,i_j2_ID2,i_jal2_ID2;
    reg i_lwc12_ID2,i_swc12_ID2,i_fadd2_ID2,i_fsub2_ID2,i_fmul2_ID2,i_fdiv2_ID2,i_fsqrt2_ID2;
    reg i_mfc02_ID2,i_mtc02_ID2,i_eret2_ID2,i_syscall2_ID2,unimplemented_inst2_ID2,i_nop2_ID2;
    reg [4:0]  rs2_ID2,rt2_ID2,rd2_ID2,fs2_ID2,ft2_ID2,fd2_ID2;
    reg [15:0] imm2_ID2,address2_ID2;
    reg [4:0] sa2_ID2;
    reg [31:0] pc2_ID2;
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            i_add2_ID2<=1'b0;    i_sub2_ID2<=1'b0;    i_and2_ID2<=1'b0;    i_or2_ID2<=1'b0;     i_xor2_ID2<=1'b0;    i_sll2_ID2<=1'b0;    
            i_srl2_ID2<=1'b0;    i_sra2_ID2<=1'b0;    i_jr2_ID2<=1'b0;    
            i_addi2_ID2<=1'b0;   i_andi2_ID2<=1'b0;   i_ori2_ID2<=1'b0;    i_xori2_ID2<=1'b0;   i_lw2_ID2<=1'b0;     i_sw2_ID2<=1'b0;    
            i_beq2_ID2<=1'b0;    i_bne2_ID2<=1'b0;    i_lui2_ID2<=1'b0;    i_j2_ID2<=1'b0;      i_jal2_ID2<=1'b0;    
            i_lwc12_ID2<=1'b0;   i_swc12_ID2<=1'b0;   i_fadd2_ID2<=1'b0;   i_fsub2_ID2<=1'b0;   i_fmul2_ID2<=1'b0;   i_fdiv2_ID2<=1'b0;    
            i_fsqrt2_ID2<=1'b0;
            i_mfc02_ID2<=1'b0;  i_mtc02_ID2<=1'b0;      i_eret2_ID2<=1'b0;  i_syscall2_ID2<=1'b0;   unimplemented_inst2_ID2<=1'b0;  i_nop2_ID2<=1'b0;
            rs2_ID2<=5'b0;      rt2_ID2<=5'b0;      rd2_ID2<=5'b0;      fs2_ID2<=5'b0;      ft2_ID2<=5'b0;      fd2_ID2<=5'b0;
            imm2_ID2<=16'b0;    address2_ID2<=16'b0;
            sa2_ID2<=5'b0;
            pc2_ID2<=32'h0;   
        end
        else if (pipe_reg_1_en) begin
            i_add2_ID2<=i_add2;   i_sub2_ID2<=i_sub2;   i_and2_ID2<=i_and2;   i_or2_ID2<=i_or2;     i_xor2_ID2<=i_xor2;   i_sll2_ID2<=i_sll2;    
            i_srl2_ID2<=i_srl2;   i_sra2_ID2<=i_sra2;   i_jr2_ID2<=i_jr2;    
            i_addi2_ID2<=i_addi2; i_andi2_ID2<=i_andi2; i_ori2_ID2<=i_ori2;   i_xori2_ID2<=i_xori2; i_lw2_ID2<=i_lw2;     i_sw2_ID2<=i_sw2;    
            i_beq2_ID2<=i_beq2;   i_bne2_ID2<=i_bne2;   i_lui2_ID2<=i_lui2;   i_j2_ID2<=i_j2;       i_jal2_ID2<=i_jal2;    
            i_lwc12_ID2<=i_lwc12; i_swc12_ID2<=i_swc12; i_fadd2_ID2<=i_fadd2; i_fsub2_ID2<=i_fsub2; i_fmul2_ID2<=i_fmul2; i_fdiv2_ID2<=i_fdiv2;    
            i_fsqrt2_ID2<=i_fsqrt2;
            i_mfc02_ID2<=i_mfc02;    i_mtc02_ID2<=i_mtc02;    i_eret2_ID2<=i_eret2;    i_syscall2_ID2<=i_syscall2; unimplemented_inst2_ID2<=unimplemented_inst2;   i_nop2_ID2<=i_nop2;
            rs2_ID2<=rs2;      rt2_ID2<=rt2;      rd2_ID2<=rd2;      fs2_ID2<=fs2;      ft2_ID2<=ft2;      fd2_ID2<=fd2;
            imm2_ID2<=imm2;    address2_ID2<=address2;
            sa2_ID2<=sa2;
            pc2_ID2<=pc2_IR;
        end
    end



    //[ID stage2] formation of control signals
    //----------------INST1----------------//
    //imm extention, branch offset and jpc
    wire sign_ext1=i_addi1_ID2|i_lw1_ID2|i_sw1_ID2|i_beq1_ID2|i_bne1_ID2|i_lwc11_ID2|i_swc11_ID2;
    wire [31:0] ext_imm_sa1;
    wire [31:0] ext_imm1={{16{imm1_ID2[15]&sign_ext1}},imm1_ID2};   //ext_imm of imm insts
    wire [31:0] ext_sa1={27'b0,sa1_ID2};                    //ext_sa of sll, srl, sra
    wire [31:0] offset1={ext_imm1[29:0],2'b00};   //branch offset of i_beq and i_bne
    wire [31:0] pc41;
    adder32 j_inst_pc41 (.a(pc1_ID2),.b(32'h0000_0004),.r(pc41));
    wire [31:0] jpc1={pc41[31:28],address1_ID2,2'b00}; //jump target addr of i_j and i_jal
    //jal and jr 
    //formation of alu control signal
    wire [3:0] aluc1;
    assign aluc1[3]=i_sra1_ID2;
	assign aluc1[2]=i_sub1_ID2|i_or1_ID2|i_srl1_ID2|i_sra1_ID2|i_ori1_ID2|i_lui1_ID2;
	assign aluc1[1]=i_xor1_ID2|i_sll1_ID2|i_srl1_ID2|i_sra1_ID2|i_xori1_ID2|i_beq1_ID2|i_bne1_ID2|i_lui1_ID2;
	assign aluc1[0]=i_and1_ID2|i_or1_ID2|i_sll1_ID2|i_srl1_ID2|i_sra1_ID2|i_andi1_ID2|i_ori1_ID2;
    //select the operand of integer_insts
    wire imm_insts1=i_andi1_ID2|i_ori1_ID2|i_addi1_ID2|i_xori1_ID2|i_lui1_ID2;
    wire shift_insts1=i_sll1_ID2|i_srl1_ID2|i_sra1_ID2;
    wire [1:0] sel_imm_operand1_sig1={{i_lw1_ID2|i_sw1_ID2|i_beq1_ID2|i_bne1_ID2|i_lwc11_ID2|i_swc11_ID2|i_j1_ID2|i_jal1_ID2},{shift_insts1|i_j1_ID2|i_jal1_ID2}};
    wire [4:0] integer_insts_operand_a1=rs1_ID2;
    wire [5:0] integer_insts_operand_b1=rt1_ID2;
    wire [31:0] imm_operand1;
    mux4x532 sel_integer_insts_operand_b1 (.data1(ext_imm1),.data2(ext_sa1),.data3(offset1),.data4(jpc1),.sel(sel_imm_operand1_sig1),.dataout(imm_operand1));
    //select the operand of single float_insts
    wire [4:0] sfloat_insts_operand_a1=fs1_ID2;
    wire [5:0] sfloat_insts_operand_b1=ft1_ID2;
    //select the final operand
    wire [4:0] final_operand_a1;
    wire [4:0] final_operand_b1;
    wire float_insts1=i_fadd1_ID2|i_fsub1_ID2|i_fmul1_ID2|i_fdiv1_ID2|i_fsqrt1_ID2;       //float operations
    mux2x5 sel_final_operand_a1 (.data1(integer_insts_operand_a1),.data2(sfloat_insts_operand_a1),.sel(float_insts1),.dataout(final_operand_a1));
    mux2x5 sel_final_operand_b1 (.data1(integer_insts_operand_b1),.data2(sfloat_insts_operand_b1),.sel(float_insts1),.dataout(final_operand_b1));
    //select the destination register
    wire sel_rt_sig1=i_addi1_ID2|i_andi1_ID2|i_ori1_ID2|i_xori1_ID2|i_lw1_ID2|i_lui1_ID2|i_mfc01_ID2|i_lwc11_ID2;
    wire sel_fd_sig1=float_insts1;
    wire [1:0] sel_dest_reg_sig1={sel_fd_sig1|i_jal1_ID2,sel_rt_sig1|i_jal1_ID2};
    wire [4:0] jal_target1=5'b11111;
    mux4x5 sel_rd1 (.data1(rd1_ID2),.data2(rt1_ID2),.data3(fd1_ID2),.data4(jal_target1),.sel(sel_dest_reg_sig1),.dataout(dest_reg1));
    //formation of opcode (one hot encode)
    wire [5:0] opcode1;                                                                                  //indicate insts' type
    assign opcode1[0]=i_sra1_ID2|i_sub1_ID2|i_or1_ID2|i_srl1_ID2|i_ori1_ID2|i_lui1_ID2|i_xor1_ID2|i_sll1_ID2|i_xori1_ID2|i_beq1_ID2|i_bne1_ID2|i_and1_ID2|i_andi1_ID2;    //normal integer insts  (don't need details)
    assign opcode1[1]=float_insts1;                                                                       //normal single float insts
    assign opcode1[2]=i_lw1_ID2|i_sw1_ID2|i_lwc11_ID2|i_swc11_ID2;                                                           //load adn store insts
    assign opcode1[3]=i_mfc01_ID2|i_mtc01_ID2|i_eret1_ID2|i_syscall1_ID2;                                                    //intr insts
    assign opcode1[4]=unimplemented_inst1_ID2;                                                                //unimplemented_insts
    assign opcode1[5]=i_beq1_ID2|i_bne1_ID2|i_j1_ID2|i_jal1_ID2|i_jr1_ID2;                                                        //branch and jump insts
    wire [2:0] detail_opcode1;                                                                           //detail op code 
    assign detail_opcode1[0]=i_fsub1_ID2|i_sw1_ID2|i_mtc01_ID2|i_bne1_ID2|i_fdiv1_ID2|i_swc11_ID2|i_syscall1_ID2|i_jal1_ID2;
    assign detail_opcode1[1]=i_fmul1_ID2|i_lwc11_ID2|i_eret1_ID2|i_j1_ID2|i_fdiv1_ID2|i_swc11_ID2|i_syscall1_ID2|i_jal1_ID2;
    assign detail_opcode1[2]=i_fsqrt1_ID2|i_jr1_ID2;
    wire [3:0] reg_relation1;                                                                            //inst's reg operations
    assign reg_relation1[0]=i_add1_ID2|i_sub1_ID2|i_and1_ID2|i_or1_ID2|i_xor1_ID2|i_jr1_ID2|i_addi1_ID2|i_andi1_ID2|i_ori1_ID2|
                            i_xori1_ID2|i_lw1_ID2|i_sw1_ID2|i_beq1_ID2|i_bne1_ID2|i_lwc11_ID2|i_swc11_ID2|float_insts1;    
                                                                                                        //insts using rs or fs as source
    assign reg_relation1[1]=i_add1_ID2|i_sub1_ID2|i_and1_ID2|i_or1_ID2|i_xor1_ID2|i_sll1_ID2|i_srl1_ID2|i_sra1_ID2|i_sw1_ID2|
                            i_beq1_ID2|i_bne1_ID2|i_mtc01_ID2|float_insts1;                             //insts using rt or ft as source
    assign reg_relation1[2]=shift_insts1|imm_insts1|i_bne1_ID2|i_beq1_ID2;                              //insts using imm operand as source   
    assign reg_relation1[3]=~opcode1[5]&~i_sw1_ID2&~i_swc11_ID2;                                       //insts having dest reg
    //mem and reg write enable
    wire int_reg_wen1=i_add1_ID2|i_sub1_ID2|i_and1_ID2|i_or1_ID2|i_xor1_ID2|i_sll1_ID2|i_srl1_ID2|i_sra1_ID2|i_addi1_ID2|i_andi1_ID2|i_ori1_ID2|i_xori1_ID2|i_lw1_ID2|i_lui1_ID2|i_jal1_ID2|i_mfc01_ID2;
    wire float_reg_wen1=float_insts1|i_lwc11_ID2;
    wire mem_wen1=i_sw1_ID2|i_swc11_ID2;
    //issue queue write enable
    wire i_nop1_out=i_nop1_ID2;

    //----------------INST2----------------//
    //imm extention, branch offset and jpc
    wire sign_ext2=i_addi2_ID2|i_lw2_ID2|i_sw2_ID2|i_beq2_ID2|i_bne2_ID2|i_lwc12_ID2|i_swc12_ID2;
    wire [31:0] ext_imm2={{16{imm2_ID2[15]&sign_ext2}},imm2_ID2};   //ext_imm of imm insts
    wire [31:0] ext_sa2={27'b0,sa2_ID2};                    //ext_sa of sll, srl, sra
    wire [31:0] offset2={ext_imm2[29:0],2'b00};   //branch offset of i_beq and i_bne
    wire [31:0] pc42;
    adder32 j_inst_pc42 (.a(pc2_ID2),.b(32'h0000_0004),.r(pc42));
    wire [31:0] jpc2={pc42[31:28],address2_ID2,2'b00}; //jump target addr of i_j and i_jal
    //jal and jr 
    //formation of alu control signal
    wire [3:0] aluc2;
    assign aluc2[3]=i_sra2_ID2;
	assign aluc2[2]=i_sub2_ID2|i_or2_ID2|i_srl2_ID2|i_sra2_ID2|i_ori2_ID2|i_lui2_ID2;
	assign aluc2[1]=i_xor2_ID2|i_sll2_ID2|i_srl2_ID2|i_sra2_ID2|i_xori2_ID2|i_beq2_ID2|i_bne2_ID2|i_lui2_ID2;
	assign aluc2[0]=i_and2_ID2|i_or2_ID2|i_sll2_ID2|i_srl2_ID2|i_sra2_ID2|i_andi2_ID2|i_ori2_ID2;
    //select the operand of integer_insts
    wire imm_insts2=i_andi2_ID2|i_ori2_ID2|i_addi2_ID2|i_xori2_ID2|i_lui2_ID2;
    wire shift_insts2=i_sll2_ID2|i_srl2_ID2|i_sra2_ID2;
    wire [4:0] integer_insts_operand_a2=rs2_ID2;
    wire [4:0] integer_insts_operand_b2=rt2_ID2;
    wire [1:0] sel_imm_operand={{i_lw2_ID2|i_sw2_ID2|i_beq2_ID2|i_bne2_ID2|i_lwc12_ID2|i_swc12_ID2|i_j2_ID2|i_jal2_ID2},{shift_insts2|i_j2_ID2|i_jal2_ID2}};
    wire [31:0] imm_operand2;
    mux4x5 sel_integer_insts_imm2 (.data1(ext_imm2),.data2(ext_sa2),.data3(offset2),.data4(jpc2),.sel(sel_imm_operand),.dataout(imm_operand2));
    //select the operand of single float_insts
    wire [4:0] sfloat_insts_operand_a2=fs2_ID2;
    wire [4:0] sfloat_insts_operand_b2=ft2_ID2;
    //select the final operand
    wire [4:0] final_operand_a2;
    wire [4:0] final_operand_b2;
    wire float_insts2=i_fadd2_ID2|i_fsub2_ID2|i_fmul2_ID2|i_fdiv2_ID2|i_fsqrt2_ID2;       //float operations
    mux2x5 sel_final_operand_a2 (.data1(integer_insts_operand_a2),.data2(sfloat_insts_operand_a2),.sel(float_insts2),.dataout(final_operand_a2));
    mux2x5 sel_final_operand_b2 (.data1(integer_insts_operand_b2),.data2(sfloat_insts_operand_b2),.sel(float_insts2),.dataout(final_operand_b2));
    //select the destination register
    wire sel_rt_sig2=i_addi2_ID2|i_andi2_ID2|i_ori2_ID2|i_xori2_ID2|i_lw2_ID2|i_lui2_ID2|i_mfc02_ID2|i_lwc12_ID2;
    wire sel_fd_sig2=float_insts2;  
    wire [1:0] sel_dest_reg_sig2={sel_fd_sig2|i_jal2_ID2,sel_rt_sig2|i_jal2_ID2};
    wire [4:0] jal_target2=5'b11111;
    mux4x5 sel_rd2 (.data1(rd2_ID2),.data2(rt2_ID2),.data3(fd2_ID2),.data4(jal_target2),.sel(sel_dest_reg_sig2),.dataout(dest_reg2));
    //formation of opcode (one hot encode)
    wire [5:0] opcode2;                                                                                  //indicate insts' type
    assign opcode2[0]=i_sra2_ID2|i_sub2_ID2|i_or2_ID2|i_srl2_ID2|i_ori2_ID2|i_lui2_ID2|i_xor2_ID2|i_sll2_ID2|i_xori2_ID2|i_beq2_ID2|i_bne2_ID2|i_and2_ID2|i_andi2_ID2;    //normal integer insts  (don't need details)
    assign opcode2[1]=float_insts2;                                                                      //normal single float insts
    assign opcode2[2]=i_lw2_ID2|i_sw2_ID2|i_lwc12_ID2|i_swc12_ID2;                                       //load adn store insts
    assign opcode2[3]=i_mfc02_ID2|i_mtc02_ID2|i_eret2_ID2|i_syscall2_ID2;                                //intr insts
    assign opcode2[4]=unimplemented_inst2_ID2;                                                           //unimplemented_insts
    assign opcode2[5]=i_beq2_ID2|i_bne2_ID2|i_j2_ID2|i_jal2_ID2|i_jr2_ID2;                               //branch and jump insts
    wire [2:0] detail_opcode2;                                                                           //detail op code 
    assign detail_opcode2[0]=i_fsub2_ID2|i_sw2_ID2|i_mtc02_ID2|i_bne2_ID2|i_fdiv2_ID2|i_swc12_ID2|i_syscall2_ID2|i_jal2_ID2;
    assign detail_opcode2[1]=i_fmul2_ID2|i_lwc12_ID2|i_eret2_ID2|i_j2_ID2|i_fdiv2_ID2|i_swc12_ID2|i_syscall2_ID2|i_jal2_ID2;
    assign detail_opcode2[2]=i_fsqrt2_ID2|i_jr2_ID2;
    wire [3:0] reg_relation2;                                                                            //inst's reg operations
    assign reg_relation2[0]=i_add2_ID2|i_sub2_ID2|i_and2_ID2|i_or2_ID2|i_xor2_ID2|i_jr2_ID2|i_addi2_ID2|i_andi2_ID2|i_ori2_ID2|
                            i_xori2_ID2|i_lw2_ID2|i_sw2_ID2|i_beq2_ID2|i_bne2_ID2|i_lwc12_ID2|i_swc12_ID2|float_insts2;    
                                                                                                        //insts using rs or fs as source
    assign reg_relation2[1]=i_add2_ID2|i_sub2_ID2|i_and2_ID2|i_or2_ID2|i_xor2_ID2|i_sll2_ID2|i_srl2_ID2|i_sra2_ID2|i_sw2_ID2|
                            i_beq2_ID2|i_bne2_ID2|i_mtc02_ID2|float_insts2;                             //insts using rt or ft as source
    assign reg_relation1[2]=shift_insts2|imm_insts2|i_bne1_ID2|i_beq1_ID2;                              //insts using imm operand as source   
    assign reg_relation2[3]=~opcode2[5]&~i_sw2_ID2&~i_swc12_ID2;                                       //insts having dest reg
    //mem and reg write enable
    wire int_reg_wen2=i_add2_ID2|i_sub2_ID2|i_and2_ID2|i_or2_ID2|i_xor2_ID2|i_sll2_ID2|i_srl2_ID2|i_sra2_ID2|i_addi2_ID2|i_andi2_ID2|i_ori2_ID2|i_xori2_ID2|i_lw2_ID2|i_lui2_ID2|i_jal2_ID2|i_mfc02_ID2;
    wire float_reg_wen2=float_insts2|i_lwc12_ID2;
    wire mem_wen2=i_sw2_ID2|i_swc12_ID2;
    //issue queue write enable
    wire i_nop2_out=i_nop2_ID2;
endmodule


