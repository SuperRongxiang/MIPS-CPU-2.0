module issue_queue (clk,rst_n,issue_en,read_en,i_nop1_out,mem_wen1,float_reg_wen1,int_reg_wen1,opcode1,detail_opcode1,reg_relation1,
                    final_operand_a1,final_operand_b1,dest_reg1,pc1_ID2,i_nop2_out,mem_wen2,float_reg_wen2,int_reg_wen2,opcode2,
                    detail_opcode2,reg_relation2,final_operand_a2,final_operand_b2,dest_reg2,pc2_ID2,
                    i_nop1_dspch,mem_wen1_dspch,float_reg_wen1_dspch,int_reg_wen1_dspch,opcode1_dspch,detail_opcode1_dspch,reg_relation1_dspch,
                    final_operand_a1_dspch,final_operand_b1_dspch,dest_reg1_dspch,pc1_dspch,i_nop2_dspch,mem_wen2_dspch,float_reg_wen2_dspch,
                    int_reg_wen2_dspch,opcode2_dspch,detail_opcode2_dspch,reg_relation2_dspch,final_operand_a2_dspch,final_operand_b2_dspch,
                    dest_reg2_dspch,pc2_dspch);
    parameter queue_depth=16;
    parameter ptr_width=4;
    
    input clk,rst_n;

    //input decode result of inst 1
    input i_nop1_out,mem_wen1,float_reg_wen1,int_reg_wen1;
    input [5:0] opcode1;
    input [2:0] detail_opcode1;
    input [3:0] reg_relation1;
    input [4:0] final_operand_a1;
    input [4:0] final_operand_b1;
    input [4:0] dest_reg1;
    input [31:0] pc1_ID2;

    //input decode result of inst 2
    input i_nop2_out,mem_wen2,float_reg_wen2,int_reg_wen2;
    input [5:0] opcode2;
    input [2:0] detail_opcode2;
    input [3:0] reg_relation2;
    input [4:0] final_operand_a2;
    input [4:0] final_operand_b2;
    input [4:0] dest_reg2;
    input [31:0] pc2_ID2;

    //FIFO enable from dispatch unit and decode unit
    input read_en,issue_en;

    //output decode result of inst 1
    output i_nop1_dspch,mem_wen1_dspch,float_reg_wen1_dspch,int_reg_wen1_dspch;
    output [5:0] opcode1_dspch;
    output [2:0] detail_opcode1_dspch;
    output [3:0] reg_relation1_dspch;
    output [4:0] final_operand_a1_dspch;
    output [4:0] final_operand_b1_dspch;
    output [4:0] dest_reg1_dspch;
    output [31:0] pc1_dspch;

    //output decode result of inst 2
    output i_nop2_dspch,mem_wen2_dspch,float_reg_wen2_dspch,int_reg_wen2_dspch;
    output [5:0] opcode2_dspch;
    output [2:0] detail_opcode2_dspch;
    output [3:0] reg_relation2_dspch;
    output [4:0] final_operand_a2_dspch;
    output [4:0] final_operand_b2_dspch;
    output [4:0] dest_reg2_dspch;
    output [31:0] pc2_dspch;

    reg i_nop [queue_depth-1:0];
    reg mem_wen [queue_depth-1:0];
    reg float_reg_wen [queue_depth-1:0];
    reg int_reg_wen [queue_depth-1:0];
    reg [3:0] reg_relation [queue_depth-1:0];
    reg [5:0] opcode [queue_depth-1:0];
    reg [2:0] detail_opcode [queue_depth-1:0];
    reg [4:0] final_operand_a [queue_depth-1:0];
    reg [31:0] final_operand_b [queue_depth-1:0];
    reg [4:0] dest_reg [queue_depth-1:0];
    reg [31:0] pc [queue_depth-1:0];

    reg [ptr_width-1:0] write_ptr,read_ptr;
    reg [ptr_width:0] ptr_gap;

    wire queue_full=(ptr_gap==queue_depth);
    wire queue_empty=(ptr_gap==0);

    integer i;
    always @ (posedge clk or negedge rst_n)    begin
        if (!rst_n) begin
            write_ptr<=4'b0000;
            read_ptr<=4'b0000;
            ptr_gap<=5'b0;
            for (i=0;i<queue_depth;i=i+1) begin
                    i_nop[i]<=1'b0;
                    reg_relation[i]<=1'b0;
                    mem_wen[i]<=1'b0;
                    float_reg_wen[i]<=1'b0;
                    int_reg_wen[i]<=1'b0;
                    opcode[i]<=6'h00;
                    detail_opcode[i]<=3'h0;
                    final_operand_a[i]<=5'h00;
                    final_operand_b[i]<=32'h0;
                    dest_reg[i]<=5'h00;
                    pc[i]<=32'h0;
            end
        end
        else if (issue_en&&read_en&&!queue_full&&!queue_empty)   begin
                    //write insts1 info.
                    i_nop[write_ptr]<=i_nop1_out;
                    reg_relation[write_ptr]<=reg_relation1;
                    mem_wen[write_ptr]<=mem_wen1;
                    float_reg_wen[write_ptr]<=float_reg_wen1;
                    int_reg_wen[write_ptr]<=int_reg_wen1;
                    opcode[write_ptr]<=opcode1;
                    detail_opcode[write_ptr]<=detail_opcode1;
                    final_operand_a[write_ptr]<=final_operand_a1;
                    final_operand_b[write_ptr]<=final_operand_b1;
                    dest_reg[write_ptr]<=dest_reg1;
                    pc[write_ptr]<=pc1_ID2;
                    //write inst2 info.
                    i_nop[write_ptr+1]<=i_nop2_out;
                    reg_relation[write_ptr+1]<=reg_relation2;
                    mem_wen[write_ptr+1]<=mem_wen2;
                    float_reg_wen[write_ptr+1]<=float_reg_wen2;
                    int_reg_wen[write_ptr+1]<=int_reg_wen2;
                    opcode[write_ptr+1]<=opcode2;
                    detail_opcode[write_ptr+1]<=detail_opcode2;
                    final_operand_a[write_ptr+1]<=final_operand_a2;
                    final_operand_b[write_ptr+1]<=final_operand_b2;
                    dest_reg[write_ptr+1]<=dest_reg2;
                    pc[write_ptr+1]<=pc2_ID2;
                    //update ptr
                    write_ptr<=write_ptr+4'h2;
                    read_ptr<=read_ptr+4'h2;
        end
        else if (issue_en&&read_en&&queue_empty)  begin
                    //write insts1 info.
                    i_nop[write_ptr]<=i_nop1_out;
                    reg_relation[write_ptr]<=reg_relation1;
                    mem_wen[write_ptr]<=mem_wen1;
                    float_reg_wen[write_ptr]<=float_reg_wen1;
                    int_reg_wen[write_ptr]<=int_reg_wen1;
                    opcode[write_ptr]<=opcode1;
                    detail_opcode[write_ptr]<=detail_opcode1;
                    final_operand_a[write_ptr]<=final_operand_a1;
                    final_operand_b[write_ptr]<=final_operand_b1;
                    dest_reg[write_ptr]<=dest_reg1;
                    pc[write_ptr]<=pc1_ID2;
                    //write inst2 info.
                    i_nop[write_ptr+1]<=i_nop2_out;
                    reg_relation[write_ptr+1]<=reg_relation2;
                    mem_wen[write_ptr+1]<=mem_wen2;
                    float_reg_wen[write_ptr+1]<=float_reg_wen2;
                    int_reg_wen[write_ptr+1]<=int_reg_wen2;
                    opcode[write_ptr+1]<=opcode2;
                    detail_opcode[write_ptr+1]<=detail_opcode2;
                    final_operand_a[write_ptr+1]<=final_operand_a2;
                    final_operand_b[write_ptr+1]<=final_operand_b2;
                    dest_reg[write_ptr+1]<=dest_reg2;
                    pc[write_ptr+1]<=pc2_ID2;
                    //update ptr
                    write_ptr<=write_ptr+4'h2;
                    ptr_gap<=ptr_gap+5'h02;
        end
        else if (issue_en&&read_en&&queue_full)  begin
                    //update ptr
                    read_ptr<=read_ptr+4'h2;
                    ptr_gap<=ptr_gap-5'h02;
        end
        else if (!issue_en&&read_en&&!queue_empty)  begin
                    //update ptr
                    read_ptr<=read_ptr+4'h2;
                    ptr_gap<=ptr_gap-5'h02;
        end
        else if (issue_en&&!read_en&&!queue_full)  begin
                    //write insts1 info.
                    i_nop[write_ptr]<=i_nop1_out;
                    reg_relation[write_ptr]<=reg_relation1;
                    mem_wen[write_ptr]<=mem_wen1;
                    float_reg_wen[write_ptr]<=float_reg_wen1;
                    int_reg_wen[write_ptr]<=int_reg_wen1;
                    opcode[write_ptr]<=opcode1;
                    detail_opcode[write_ptr]<=detail_opcode1;
                    final_operand_a[write_ptr]<=final_operand_a1;
                    final_operand_b[write_ptr]<=final_operand_b1;
                    dest_reg[write_ptr]<=dest_reg1;
                    pc[write_ptr]<=pc1_ID2;
                    //write inst2 info.
                    i_nop[write_ptr+1]<=i_nop2_out;
                    reg_relation[write_ptr+1]<=reg_relation2;
                    mem_wen[write_ptr+1]<=mem_wen2;
                    float_reg_wen[write_ptr+1]<=float_reg_wen2;
                    int_reg_wen[write_ptr+1]<=int_reg_wen2;
                    opcode[write_ptr+1]<=opcode2;
                    detail_opcode[write_ptr+1]<=detail_opcode2;
                    final_operand_a[write_ptr+1]<=final_operand_a2;
                    final_operand_b[write_ptr+1]<=final_operand_b2;
                    dest_reg[write_ptr+1]<=dest_reg2;
                    pc[write_ptr+1]<=pc2_ID2;
                    //update ptr
                    write_ptr<=write_ptr+4'h2;
                    ptr_gap<=ptr_gap+5'h02;
        end
    end

    //queue output of inst 1
    assign reg_relation1_dspch=read_en?reg_relation[read_ptr]:1'bz;
    assign mem_wen1_dspch=read_en?mem_wen[read_ptr]:1'bz;
    assign float_reg_wen1_dspch=read_en?float_reg_wen[read_ptr]:1'bz;
    assign int_reg_wen1_dspch=read_en?int_reg_wen[read_ptr]:1'bz;
    assign opcode1_dspch=read_en?opcode[read_ptr]:6'hzz;
    assign detail_opcode1_dspch=read_en?detail_opcode[read_ptr]:3'hz;
    assign final_operand_a1_dspch=read_en?final_operand_a[read_ptr]:5'bz;
    assign final_operand_b1_dspch=read_en?final_operand_b[read_ptr]:32'bz;
    assign dest_reg1_dspch=read_en?dest_reg[read_ptr]:5'bz;
    assign pc1_dspch=read_en?pc[read_ptr]:32'bz;
    //queue output of inst1
    assign reg_relation2_dspch=read_en?reg_relation[read_ptr+1]:1'bz;
    assign mem_wen2_dspch=read_en?mem_wen[read_ptr+1]:1'bz;
    assign float_reg_wen2_dspch=read_en?float_reg_wen[read_ptr+1]:1'bz;
    assign int_reg_wen2_dspch=read_en?int_reg_wen[read_ptr+1]:1'bz;
    assign opcode2_dspch=read_en?opcode[read_ptr+1]:6'hzz;
    assign detail_opcode2_dspch=read_en?detail_opcode[read_ptr+1]:3'hz;
    assign final_operand_a2_dspch=read_en?final_operand_a[read_ptr+1]:5'bz;
    assign final_operand_b2_dspch=read_en?final_operand_b[read_ptr+1]:32'bz;
    assign dest_reg2_dspch=read_en?dest_reg[read_ptr+1]:5'bz;
    assign pc2_dspch=read_en?pc[read_ptr+1]:32'bz;
endmodule

