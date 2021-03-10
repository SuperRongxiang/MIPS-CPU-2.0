module dispatch_unit (i_nop1_dspch,mem_wen1_dspch,float_reg_wen1_dspch,int_reg_wen1_dspch,opcode1_dspch,detail_opcode1_dspch,reg_relation1_dspch,
                    final_operand_a1_dspch,final_operand_b1_dspch,dest_reg1_dspch,pc1_dspch,i_nop2_dspch,mem_wen2_dspch,float_reg_wen2_dspch,
                    int_reg_wen2_dspch,opcode2_dspch,detail_opcode2_dspch,reg_relation2_dspch,final_operand_a2_dspch,final_operand_b2_dspch,
                    dest_reg2_dspch,pc2_dspch,

                    );
    //input decode result of inst 1    
    input i_nop1_dspch,mem_wen1_dspch,float_reg_wen1_dspch,int_reg_wen1_dspch;
    input [5:0] opcode1_dspch;
    input [2:0] detail_opcode1_dspch;
    input [3:0] reg_relation1_dspch;
    input [4:0] final_operand_a1_dspch;
    input [4:0] final_operand_b1_dspch;
    input [4:0] dest_reg1_dspch;
    input [31:0] pc1_dspch;

    //input decode result of inst 2
    input i_nop2_dspch,mem_wen2_dspch,float_reg_wen2_dspch,int_reg_wen2_dspch;
    input [5:0] opcode2_dspch;
    input [2:0] detail_opcode2_dspch;
    input [3:0] reg_relation2_dspch;
    input [4:0] final_operand_a2_dspch;
    input [4:0] final_operand_b2_dspch;
    input [4:0] dest_reg2_dspch;
    input [31:0] pc2_dspch;

    
    