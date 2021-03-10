module sixteen_way_two_level_predictor (clk,rst_n,update_en,pc_pre,pc_update,real_br_taken,pre_taken);
    input clk,rst_n,update_en;
    input [31:0] pc_pre,pc_update;
    input real_br_taken;
    output pre_taken;

    wire [15:0] sixteen_way_pre_taken;
    wire [15:0] tlpen,pc_update_decode;
    four_16_decoder wen_decoder  (.a(pc_update[5:2]),.b(pc_update_decode));
    assign tlpen={16{update_en}}&pc_update_decode;
    two_level_predictor pre_1 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[0]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[0]));
    two_level_predictor pre_2 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[1]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[1]));
    two_level_predictor pre_3 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[2]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[2]));
    two_level_predictor pre_4 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[3]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[3]));
    two_level_predictor pre_5 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[4]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[4]));
    two_level_predictor pre_6 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[5]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[5]));
    two_level_predictor pre_7 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[6]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[6]));
    two_level_predictor pre_8 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[7]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[7]));
    two_level_predictor pre_9 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[8]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[8]));
    two_level_predictor pre_10 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[9]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[9]));
    two_level_predictor pre_11 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[10]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[10]));
    two_level_predictor pre_12 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[11]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[11]));
    two_level_predictor pre_13 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[12]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[12]));
    two_level_predictor pre_14 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[13]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[13]));
    two_level_predictor pre_15 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[14]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[14]));
    two_level_predictor pre_16 (.clk(clk),.rst_n(rst_n),.update_en(tlpen[15]),.real_br_taken(real_br_taken),.pre_taken(sixteen_way_pre_taken[15]));

    assign pre_taken=sixteen_way_pre_taken[pc_pre[5:2]];

endmodule
