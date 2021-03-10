module Carry_lookahead_adder_8bit(a,b,cin,sum,cout);
	input [7:0] a,b;
	input cin;
	output [7:0] sum;
	output cout;
	wire [7:0] c,p,g;
	
	assign g=a&b;
	assign p=a^b;
	assign c[0]=g[0]|(p[0]&cin);
	assign c[1]=g[1]|(p[1]&c[0]);
	assign c[2]=g[2]|(p[2]&c[1]);
	assign c[3]=g[3]|(p[3]&c[2]);

	assign c[4]=g[4]|(p[4]&c[3]);
	assign c[5]=g[5]|(p[5]&c[4]);
	assign c[6]=g[6]|(p[6]&c[5]);
	assign c[7]=g[7]|(p[7]&c[6]);

	assign cout=c[7];
	
	assign sum[0]=a[0]^b[0]^cin;
	assign sum[7:1]=a[7:1]^b[7:1]^c[6:0];
endmodule

module adder32(a,b,r);
	input [31:0] a,b;
	output [31:0] r;
	
	wire [2:0] cmid;
	
	Carry_lookahead_adder_8bit adder1(.a(a[7:0]),.b(b[7:0]),.cin(1'b0),.sum(r[7:0]),.cout(cmid[0]));
	Carry_lookahead_adder_8bit adder2(.a(a[15:8]),.b(b[15:8]),.cin(cmid[0]),.sum(r[15:8]),.cout(cmid[1]));
	Carry_lookahead_adder_8bit adder3(.a(a[23:16]),.b(b[23:16]),.cin(cmid[1]),.sum(r[23:16]),.cout(cmid[2]));
	Carry_lookahead_adder_8bit adder4(.a(a[31:24]),.b(b[31:24]),.cin(cmid[2]),.sum(r[31:24]),.cout());
endmodule

module hadd(a,b,sum,cout);
	input a,b;
	output sum,cout;
	
	assign sum=a^b;
	assign cout=a&b;
endmodule

module fadd(a,b,cin,sum,cout);
	input a,b,cin;
	output sum,cout;
	
	assign sum=a^b^cin;
	assign cout=(a&b)|(a&cin)|(b&cin);
endmodule

module addsub32(a,b,sub,r);
	input [31:0] a,b;
	input sub;
	output [31:0] r;
	
	wire [31:0] bin;
	wire [2:0] cmid;

	assign bin=b^{32{sub}};
	
	Carry_lookahead_adder_8bit adder1(.a(a[7:0]),.b(bin[7:0]),.cin(sub),.sum(r[7:0]),.cout(cmid[0]));
	Carry_lookahead_adder_8bit adder2(.a(a[15:8]),.b(bin[15:8]),.cin(cmid[0]),.sum(r[15:8]),.cout(cmid[1]));
	Carry_lookahead_adder_8bit adder3(.a(a[23:16]),.b(bin[23:16]),.cin(cmid[1]),.sum(r[23:16]),.cout(cmid[2]));
	Carry_lookahead_adder_8bit adder4(.a(a[31:24]),.b(bin[31:24]),.cin(cmid[2]),.sum(r[31:24]),.cout());
endmodule

