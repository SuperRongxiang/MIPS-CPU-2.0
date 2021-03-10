module inst_cache(pc1,pc2,inst1,inst2,cache_miss);
	input [31:0] pc1,pc2;
	input [31:0] inst1,inst2;
	output cache_miss;
	wire [31:0] rom [0:255];

	assign rom[8'h00]=32'h00000820;	
	assign rom[8'h01]=32'hC4200000;
	assign rom[8'h02]=32'hC4210050;
	assign rom[8'h03]=32'hc4220054;
	assign rom[8'h04]=32'hC4230058;
	assign rom[8'h05]=32'hC424005C;
	assign rom[8'h06]=32'h46002100;
	assign rom[8'h07]=32'h460418c1;
    assign rom[8'h08]=32'h46022082;
    assign rom[8'h09]=32'h46040842;
    assign rom[8'h0A]=32'hE4210070;
    assign rom[8'h0B]=32'hE4220074;
	assign rom[8'h0C]=32'hE4230078;
	assign rom[8'h0D]=32'hE424007C;
	assign rom[8'h0E]=32'h20020004;
	assign rom[8'h0F]=32'hC4230000;
	assign rom[8'h10]=32'hC4210050;
	assign rom[8'h11]=32'h46030840;
	assign rom[8'h12]=32'h46030841;
	assign rom[8'h13]=32'hE4210030;
	assign rom[8'h14]=32'hC4050004;
	assign rom[8'h15]=32'hC4060008;
	assign rom[8'h16]=32'hC408000C;
	assign rom[8'h17]=32'h460629C3;
    assign rom[8'h18]=32'h46004244;
    assign rom[8'h19]=32'h46004A84;
	assign rom[8'h1A]=32'h2042FFFF;
	assign rom[8'h1B]=32'h1440FFF3;
	assign rom[8'h1C]=32'h20210004;
	assign rom[8'h1D]=32'h3C010000;
	assign rom[8'h1E]=32'h34240050;	
	assign rom[8'h1F]=32'h0c000038;
	assign rom[8'h20]=32'h20050004;
	assign rom[8'h21]=32'hac820000;
	assign rom[8'h22]=32'h8c890000;
	assign rom[8'h23]=32'h01244022;
	assign rom[8'h24]=32'h20050003;
	assign rom[8'h25]=32'h20a5ffff;
	assign rom[8'h26]=32'h34a8ffff;
	assign rom[8'h27]=32'h39085555;
	assign rom[8'h28]=32'h2009ffff;
	assign rom[8'h29]=32'h312affff;
	assign rom[8'h2A]=32'h01493025;
	assign rom[8'h2B]=32'h01494026;
	assign rom[8'h2C]=32'h01463824;
	assign rom[8'h2D]=32'h10a00003;
	assign rom[8'h2E]=32'h00000000;
	assign rom[8'h2F]=32'h08000025;
	assign rom[8'h30]=32'h00000000;
    assign rom[8'h31]=32'h2005ffff;
    assign rom[8'h32]=32'h000543C0;
    assign rom[8'h33]=32'h00084400;
    assign rom[8'h34]=32'h00084403;
    assign rom[8'h35]=32'h000843c2;
    assign rom[8'h36]=32'h08000036;
    assign rom[8'h37]=32'h00000000;
    assign rom[8'h38]=32'h00004020;
    assign rom[8'h39]=32'h8c890000;
    assign rom[8'h3A]=32'h01094020;
    assign rom[8'h3B]=32'h20a5ffff;
    assign rom[8'h3C]=32'h14a0fffc;
    assign rom[8'h3D]=32'h20840004;
    assign rom[8'h3E]=32'h03e00008;
    assign rom[8'h3F]=32'h00081000;
	assign inst1=rom[pc1[9:2]];
    assign inst2=rom[pc2[9:2]];
    assign cache_miss=1'b1;
endmodule

	
	


