module branch_target_buffer (clk,rst_n,ud_BTB_en,pc_pre,pre_bjpc,pre_bjinst,pc_update,read_pc_hit,read_inst_hit,real_bjpc,pc1_IF2,pc2_IF2,inst1_IF2,inst2_IF2);
    input clk,rst_n,ud_BTB_en;
    input [31:0] pc_pre,pc_update,real_bjpc;
    input [31:0] pc1_IF2,pc2_IF2,inst1_IF2,inst2_IF2;
    output [31:0] pre_bjpc;
    output [31:0] pre_bjinst;
    output read_pc_hit,read_inst_hit;

    reg [31:0] pre_bjpc_reg [0:15];         //the jump target of branch insts
    reg [31:0] pre_bjinst_reg [0:15];       //the inst at branch insts
    reg [31:0] real_bjpc_store;         //store the bjpc to update

    integer i;
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for(i=0;i<15;i=i+1) begin
                pre_bjpc_reg[i]<=32'h0000_0000;
                pre_bjinst_reg[i]<=32'h0000_0000;

            end
        end
        else if (ud_BTB_en)   begin
            real_bjpc_store<=real_bjpc;
            pre_bjpc_reg[pc_update[5:2]]<=real_bjpc;
        end
    end
    

    always @ (posedge clk)  begin
        if (|real_bjpc_store)   begin
            if (pc1_IF2==real_bjpc_store)   begin
                pre_bjinst_reg[real_bjpc_store[5:2]]<=inst1_IF2;
                real_bjpc_store<=32'h0000_0000;
            end
            if (pc2_IF2==real_bjpc_store)   begin
                pre_bjinst_reg[real_bjpc_store[5:2]]<=inst2_IF2;
                real_bjpc_store<=32'h0000_0000;
            end
        end
    end

    assign pre_bjpc=pre_bjpc_reg[pc_pre[5:2]];
    assign pre_bjinst=pre_bjinst_reg[pc_pre[5:2]];
    assign read_pc_hit=|pre_bjpc;
    assign read_inst_hit=!(|(real_bjpc_store^pre_bjpc));
endmodule
