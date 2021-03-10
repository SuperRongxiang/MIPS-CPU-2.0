module mux4x32(data1,data2,data3,data4,sel,dataout);
	input [31:0] data1,data2,data3,data4;
	input [1:0] sel;
	output [31:0] dataout;
	
	assign dataout=(data1&{32{!sel[0]&!sel[1]}})
			|(data2&{32{sel[0]&!sel[1]}})
			|(data3&{32{!sel[0]&sel[1]}})
			|(data4&{32{sel[0]&sel[1]}});
endmodule
module mux4x5(data1,data2,data3,data4,sel,dataout);
	input [4:0] data1,data2,data3,data4;
	input [1:0] sel;
	output [4:0] dataout;
	
	assign dataout=(data1&{5{!sel[0]&!sel[1]}})
			|(data2&{5{sel[0]&!sel[1]}})
			|(data3&{5{!sel[0]&sel[1]}})
			|(data4&{5{sel[0]&sel[1]}});
endmodule
module mux2x5(data1,data2,sel,dataout);
	input [4:0] data1,data2;
	input sel;
	output [4:0] dataout;

	assign dataout=(data1&{5{!sel}})
			|(data2&{5{sel}});
endmodule
module mux2x32(data1,data2,sel,dataout);
	input [31:0] data1,data2;
	input sel;
	output [31:0] dataout;

	assign dataout=(data1&{32{!sel}})
			|(data2&{32{sel}});
endmodule
