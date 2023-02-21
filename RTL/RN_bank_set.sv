module RN_bank_set #(	parameter BANDWIDTH = 16,
								parameter BANDWIDTH_BIT = 4)
							(	input logic [BANDWIDTH-1 : 0] in_data,
								output logic [BANDWIDTH-1 : 0] out_data,
								input logic write,
								input logic read,
								output logic writable,
								output logic readable,
								input logic reset,
								input logic clk,
								
								output logic [1:0] full,
								output logic [1:0] empty);
		
	logic [1:0] bank_read;
	logic [1:0] bank_write;
	logic [BANDWIDTH-1 : 0] bank_out [1:0];
	logic [1:0] bank_full;
	logic [1:0] bank_empty;
	
	assign full = bank_full;
	assign empty = bank_empty;
	
	
	

	RN_bank  #(	.BANDWIDTH(BANDWIDTH), .BANDWIDTH_BIT(BANDWIDTH_BIT)) bank0
					(	.in_data(in_data),
						.out_data(bank_out[0]),
						.write(bank_write[0]),
						.read(bank_read[0]),
						.full(bank_full[0]),
						.empty(bank_empty[0]),
						.reset(reset),
						.clk(clk));

	RN_bank  #(	.BANDWIDTH(BANDWIDTH), .BANDWIDTH_BIT(BANDWIDTH_BIT)) bank1
					(	.in_data(in_data),
						.out_data(bank_out[1]),
						.write(bank_write[1]),
						.read(bank_read[1]),
						.full(bank_full[1]),
						.empty(bank_empty[1]),
						.reset(reset),
						.clk(clk));
						

//	localparam [1:0]
//		nop = 2'b00,
//		bank0 = 2'b10,
//		bank1 = 2'b11;
//		
//	reg[1:0] read_state, read_state_next, write_state, write_state_next;
//	always @(posedge clk or posedge reset) begin
//		if(reset) begin
//			writable <= 1'b0;
//			readable <= 1'b0;
//			bank_read <= 2'b00;
//			bank_write <= 2'b00;
//			out_data <= 0;
//		end else begin
//			writable <= |bank_empty;
//			readable <= |bank_full;
//			bank_read <= {read, read} & bank_full & {~bank_full[0] ,1'b1};
//			bank_write <= {write, write} & bank_empty & {~bank_empty[0] ,1'b1};
//			out_data <= bank_full[0] ? bank_out[0] :
//							bank_full[1] ? bank_out[1] : 0;
//		end
//		
//	end

	assign writable = |bank_empty;
	assign readable = |bank_full;
	assign bank_read = {read, read} & bank_full & {~bank_full[0] ,1'b1};
	assign bank_write = {write, write} & bank_empty & {~bank_empty[0] ,1'b1};
	assign out_data = (bank_full[0]| syn_bank_full[0]) ? bank_out[0] :
							(bank_full[1]| syn_bank_full[1]) ? bank_out[1] : 0;
	

	logic[1:0] syn_bank_full;
	always @(posedge clk or posedge reset) begin
		if(reset)
			syn_bank_full <= 2'b00;
		else
			syn_bank_full <= bank_full;
	end
		
		
	
						
	
					
	
					
endmodule : RN_bank_set