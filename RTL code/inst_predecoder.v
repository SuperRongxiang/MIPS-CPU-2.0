module inst_predecoder  (inst,i_add,i_sub,i_and,i_or,i_xor,i_sll,i_srl,i_sra,i_jr,i_addi,i_andi,i_ori,i_xori,i_lw,i_sw,i_beq,i_bne,i_lui,
                        i_j,i_jal,i_lwc1,i_swc1,i_fadd,i_fsub,i_fmul,i_fdiv,i_fsqrt,i_mfc0,i_mtc0,i_eret,i_syscall,unimplemented_inst,i_nop,
                        rs,rt,rd,fs,ft,fd,imm,address,sa);
    input [31:0] inst;
    output i_add,i_sub,i_and,i_or,i_xor,i_sll,i_srl,i_sra,i_jr;
    output i_addi,i_andi,i_ori,i_xori,i_lw,i_sw,i_beq,i_bne,i_lui,i_j,i_jal;
    output i_lwc1,i_swc1,i_fadd,i_fsub,i_fmul,i_fdiv,i_fsqrt;
    output i_mfc0,i_mtc0,i_eret,i_syscall,unimplemented_inst;
	output i_nop;
    output [4:0] rs,rt,rd,fs,ft,fd;
    output [15:0] imm;
    output [15:0] address;
    output [4:0] sa;

    //instruction decode
	wire [5:0] op,func,op1;
	wire [4:0] fs,ft,fd;
	wire [4:0] rs,rt,rd,sa;
	wire [15:0] imm;
	wire [25:0] address;
	
	assign op=inst[31:26];
    assign op1=inst[25:21];
	assign rs=inst[25:21];
	assign rt=inst[20:16];
	assign rd=inst[15:11];
	assign sa=inst[10:6];
	assign func=inst[5:0];
	assign imm=inst[15:0];
	assign address=inst[25:0];
	assign fs=inst[15:11];
	assign ft=inst[20:16];
	assign fd=inst[10:6];

    //decision of inst
    wire rtype,i_add,i_sub,i_and,i_or,i_xor,i_sll,i_srl,i_sra,i_jr;
	wire i_addi,i_andi,i_ori,i_xori,i_lw,i_sw,i_beq,i_bne,i_lui,i_j,i_jal;
    wire f_type,i_lwc1,i_swc1,i_fadd,i_fsub,i_fmul,i_fdiv,i_fsqrt;          //float instructions
	and(r_type,~op[5],~op[4],~op[3],~op[2],~op[1],~op[0]);
	and(i_add,r_type,func[5],~func[4],~func[3],~func[2],~func[1],~func[0]);
	and(i_sub,r_type,func[5],~func[4],~func[3],~func[2],func[1],~func[0]);
	and(i_and,r_type,func[5],~func[4],~func[3],func[2],~func[1],~func[0]);
	and(i_or,r_type,func[5],~func[4],~func[3],func[2],~func[1],func[0]);
	and(i_xor,r_type,func[5],~func[4],~func[3],func[2],func[1],~func[0]);
	and(i_sll,r_type,~func[5],~func[4],~func[3],~func[2],~func[1],~func[0]);
	and(i_srl,r_type,~func[5],~func[4],~func[3],~func[2],func[1],~func[0]);
	and(i_sra,r_type,~func[5],~func[4],~func[3],~func[2],func[1],func[0]);
	and(i_jr,r_type,~func[5],~func[4],func[3],~func[2],~func[1],~func[0]);
	and(i_addi,~op[5],~op[4],op[3],~op[2],~op[1],~op[0]);
	and(i_andi,~op[5],~op[4],op[3],op[2],~op[1],~op[0]);
	and(i_ori,~op[5],~op[4],op[3],op[2],~op[1],op[0]);
	and(i_xori,~op[5],~op[4],op[3],op[2],op[1],~op[0]);
	and(i_lw,op[5],~op[4],~op[3],~op[2],op[1],op[0]);	
	and(i_sw,op[5],~op[4],op[3],~op[2],op[1],op[0]);
	and(i_beq,~op[5],~op[4],~op[3],op[2],~op[1],~op[0]);
	and(i_bne,~op[5],~op[4],~op[3],op[2],~op[1],op[0]);
	and(i_lui,~op[5],~op[4],op[3],op[2],op[1],op[0]);
	and(i_j,~op[5],~op[4],~op[3],~op[2],op[1],~op[0]);
	and(i_jal,~op[5],~op[4],~op[3],~op[2],op[1],op[0]);
    and(f_type,~op[5],op[4],~op[3],~op[2],~op[1],op[0]);
    and(i_lwc1,op[5],op[4],~op[3],~op[2],~op[1],op[0]);
    and(i_swc1,op[5],op[4],op[3],~op[2],~op[1],op[0]);
    and(i_fadd,f_type,~func[5],~func[4],~func[3],~func[2],~func[1],~func[0]);
    and(i_fsub,f_type,~func[5],~func[4],~func[3],~func[2],~func[1],func[0]);
    and(i_fmul,f_type,~func[5],~func[4],~func[3],~func[2],func[1],~func[0]);
    and(i_fdiv,f_type,~func[5],~func[4],~func[3],~func[2],func[1],func[0]);
    and(i_fsqrt,f_type,~func[5],~func[4],~func[3],func[2],~func[1],~func[0]);


    //decode of intr instructions
	wire c0_type=~op[5]&op[4]&~op[3]&~op[2]&~op[1]&~op[0];
	wire i_mfc0=c0_type&~op1[4]&~op1[3]&~op1[2]&~op1[1]&~op1[0];
	wire i_mtc0=c0_type&~op1[4]&~op1[3]&op1[2]&~op1[1]&~op1[0];
	wire i_eret=c0_type&op1[4]&~op1[3]&~op1[2]&~op1[1]&~op1[0]&~func[5]&func[4]&func[3]&~func[2]&~func[1]&~func[0];
	wire i_syscall=r_type&~func[5]&~func[4]&func[3]&func[2]&~func[1]&~func[0];	//system call
	wire unimplemented_inst=~(i_mfc0|i_mtc0|i_eret|i_syscall|i_add|i_sub|i_and|i_or|i_xor|i_sll|i_srl|i_sra|i_jr|i_addi|i_andi|i_ori|i_xori|
	i_lw|i_sw|i_beq|i_bne|i_lui|i_j|i_jal);

	//decode of i_nop inst
	wire i_nop=~|inst;
endmodule
