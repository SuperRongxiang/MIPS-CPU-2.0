module ALU_reservation_station (clk,rst_n,operand_a_ROB_index,operand_b_ROB_index,imm_operand,pc,dest_ROB_index,intCDB_ROB_index,
                                intCDB_data
                                ,imm_operand_EXE,pc_EXE,operand_a_EXE,operand_b_EXE,dest_ROB_index_EXE);
    input clk,rst_n,
    input [3:0] operand_a_ROB_index,operand_b_ROB_index,dest_ROB_index;
    input [3:0] intCDB_ROB_index;
    input [31:0] intCDB_data;
    input [31:0] imm_operand,pc;

    output [31:0] imm_operand_EXE,pc_EXE;
    output [31:0] operand_a,operand_b;
    output [3:0] dest_ROB_index_EXE;
    output busy;

    reg [31:0] imm_operand_EXE,pc_EXE;
    reg [31:0] operand_a,operand_b;
    reg [3:0] dest_ROB_index_EXE;
    reg busy;

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            imm_operand_EXE<=32'h0;
            pc_EXE<=32'h0;
            operand_a<=32'h0;
            operand_b<=32'h0;
            dest_ROB_index_EXE<=32'h0;
            busy<=32'h0;
        end
        if () begin
            
        end
    end


