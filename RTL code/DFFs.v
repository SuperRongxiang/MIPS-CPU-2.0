module dff1 (clk,rst_n,datain,dataout);
	input clk,datain,rst_n;
	output dataout;
	
	reg dataout;
	
	always @(posedge clk)
		if (!rst_n)	dataout<=1'b0;
		else	dataout<=datain;
endmodule
module dff2 (clk,rst_n,datain,dataout);
	input clk,rst_n;
	input [1:0] datain;
	output [1:0] dataout;
	
	reg [1:0] dataout;
	
	always @(posedge clk)
		if (!rst_n)	dataout<=2'b0;
		else	dataout<=datain;
endmodule
module dff4 (clk,rst_n,datain,dataout);
	input clk,rst_n;
	input [3:0] datain;
	output [3:0] dataout;
	
	reg [3:0] dataout;
	
	always @(posedge clk)
		if (!rst_n)	dataout<=4'b0;
		else	dataout<=datain;
endmodule
module dff5 (clk,rst_n,datain,dataout);
	input clk,rst_n;
	input [4:0] datain;
	output [4:0] dataout;
	
	reg [4:0] dataout;
	
	always @(posedge clk)
		if (!rst_n)	dataout<=5'b0;
		else	dataout<=datain;
endmodule
module dff32 (d,clk,rst_n,q);
	input clk,rst_n;
	input [31:0] d;
	output q;
	reg [31:0] q;
	
	always@(negedge rst_n or posedge clk)
		if (!rst_n) q<=32'h0000_0000;
		else q<=d;
endmodule
module dffe1 (clk,rst_n,en,datain,dataout);
	input clk,datain,rst_n,en;
	output dataout;
	
	reg dataout;
	
	always @(posedge clk)
		if (!rst_n)	dataout<=1'b0;
		else if (en)	dataout<=datain;
endmodule
module dffe32 (d,clk,rst_n,en,q);
	input clk,rst_n,en;
	input [31:0] d;
	output q;
	reg [31:0] q;
	
	always@(negedge rst_n or posedge clk)
		if (!rst_n) q<=32'h0000_0000;
		else if (en) q<=d;
endmodule

