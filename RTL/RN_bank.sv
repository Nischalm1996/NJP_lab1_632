module RN_bank #(	parameter SIZE = 64,
						parameter SIZE_BIT = 6,
						parameter BANDWIDTH = 16,
						parameter BANDWIDTH_BIT = 4)
					(	input logic [BANDWIDTH-1 : 0] in_data,
						output logic [BANDWIDTH-1 : 0] out_data,
						input logic write,
						input logic read,
						output logic full,
						output logic empty,
						input logic reset,
						input logic clk);
						
						
	parameter BLOCK_NUM =  SIZE >> BANDWIDTH_BIT;
	parameter BLOCK_NUM_BIT = SIZE_BIT - BANDWIDTH_BIT;
	wire [BANDWIDTH - 1:0] z = {BANDWIDTH {1'bz}};
	
	
	integer i;
	reg [BANDWIDTH - 1: 0] mem [0: BLOCK_NUM - 1];
	reg [BLOCK_NUM_BIT - 1: 0] waddr;
	reg [BLOCK_NUM_BIT - 1: 0] raddr;
	reg [BANDWIDTH-1 : 0] read_buf;
	
	
	always @ (posedge reset or posedge clk) begin
		if(reset) begin
			waddr <= 0;
			full <= 1'b0;
			for (i = 0; i < BLOCK_NUM; i = i + 1) begin
				mem[i] <= 0;
			end
		end
		else if (&raddr & read) begin
			full <= 1'b0;
		end
		else if(~full & write) begin
			mem[waddr] <= in_data;
			waddr <= waddr + 1;
			full <= &waddr;	
		end
	end
	
	
	
	
	always @ (posedge reset or posedge clk) begin
		if(reset) begin
			empty <= 1'b1;
			read_buf <= 0;
		end
		else if (&waddr & write) begin
			empty <= 1'b0;
		end
		else if(~empty & read) begin
			read_buf <= mem[raddr];
			raddr <= raddr + 1;
			empty <= &raddr;
		end
	end



					
	assign out_data = read_buf;					
						
endmodule : RN_bank