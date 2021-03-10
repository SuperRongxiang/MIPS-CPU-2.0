module float_register_file(clk,rst_n,qa,qb,qc,qd,ROB_index_rda,ROB_index_rdb,ROB_index_rdc,ROB_index_rdd,reg_avail_a,reg_avail_b,reg_avail_c,reg_avail_d,rna,rnb,rnc,rnd,
                        ROB_index_wta,wna,ROB_index_wtb,wnb,dataina,datainb,wea,web,
                        wlwta,wlwtb,wlwt_wna,wlwt_wnb,wlwt_ROB_index_a,wlwt_ROB_index_b);
	input [4:0] rna,rnb,rnc,rnd,wna,wnb;	                                //read a,b,c,d;write a,b
	input [31:0] dataina,datainb;	                                        //data input a and b
	input wea,web,clk,rst_n;	                                            //write enable;clock;reset_n
    input [3:0] ROB_index_wta,ROB_index_wtb;                                //the write target's ROB index

    input wlwta,wlwtb;                                                      //will write reg (update ROB index)
    input wlwt_wna,wlwt_wnb;                                                //will write reg wna and wnb
    input [3:0] wlwt_ROB_index_a,wlwt_ROB_index_b;                          //will write reg from ROB indexes a and b

	output [31:0] qa,qb,qc,qd;	                                            //data output a;data output b
    output [3:0] ROB_index_rda,ROB_index_rdb,ROB_index_rdc,ROB_index_rdd;   //output ROB indexes
    output reg_avail_a,reg_avail_b,reg_avail_c,reg_avail_d;                 //output reg avails
	
	reg [31:0] register [1:31];	    //31*32-bit regs

    reg [3:0] ROB_indexes [1:31];   //store ROB index
    reg reg_avail [1:31];           //reg info. available or not (will be written)

	// 2 read ports
	assign qa={32{|rna}}&register[rna];
	assign qb={32{|rnb}}&register[rnb];
    assign qc={32{|rnc}}&register[rnc];
    assign qd={32{|rnd}}&register[rnd];
    //read ROB index and reg_avail
    assign ROB_index_a={4{|rna}}&ROB_indexes[rna];
    assign ROB_index_b={4{|rnb}}&ROB_indexes[rnb];
    assign ROB_index_c={4{|rnc}}&ROB_indexes[rnc];
    assign ROB_index_d={4{|rnd}}&ROB_indexes[rnd];
    assign reg_avail_a=(|rna)&reg_avail[rna];
    assign reg_avail_b=(|rnb)&reg_avail[rnb];
    assign reg_avail_c=(|rnc)&reg_avail[rnc];
    assign reg_avail_d=(|rnd)&reg_avail[rnd];

	integer i;
    //update the ROB_indexes and reg_avail
    always @ (posedge clk)  begin
        if (wlwtb&&wlwta&&(wlwt_wna==wlwt_wnb))  begin
            ROB_indexes[wlwt_wnb]<=wlwt_ROB_index_b;
            reg_avail[wlwt_wnb]<=1'b0;
        end
        else begin
            if (wlwta)  begin
                ROB_indexes[wlwt_wna]<=wlwt_ROB_index_a;
                reg_avail[wlwt_wna]<=1'b0;
            end
            if (wlwtb)  begin
                ROB_indexes[wlwt_wnb]<=wlwt_ROB_index_b;
                reg_avail[wlwt_wnb]<=1'b0;
            end
        end
    end

	//reset
	always @ (negedge rst_n)
		if(!rst_n) begin
			for(i=1;i<32;i=i+1)
				register[i]<=32'b0;
                ROB_indexes[i]<=4'h0;
                reg_avail[i]<=1'b1;
			end
    //write reg file
    always @ (posedge clk or negedge rst_n) begin
        if(rst_n&&(wna!=0)&&wea&&(ROB_index_wta==ROB_indexes[wna]))   begin
			register[wna]<=dataina;
            ROB_indexes[wna]<=4'h0;
            reg_avail[wna]<=1'b1;
        end
        if(rst_n&&(wnb!=0)&&web&&(ROB_index_wtb==ROB_indexes[wnb]))   begin
			register[wnb]<=datainb;
            ROB_indexes[wnb]<=4'h0;
            reg_avail[wnb]<=1'b1;
        end
    end

endmodule

