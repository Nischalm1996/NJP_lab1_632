module RNG_0(output logic f, output logic LED,
				input logic CLOCK_50, input logic reset, 
				input logic reset_sample_clk,
				output logic sample_clk,
				output logic clock_5M,
				output logic wo_0,
				output logic wo_1,
				output logic wo_2);
	wire w0, w1, w2;
	assign w1 = ~w0;
	assign w2 = ~w1;
	assign w0 = ~w2;
	
	assign wo_0 = w0;
	assign wo_1 = w1;
	assign wo_2 = w2;
	
	assign LED = reset;
	
	logic reg1, reg2;
	assign f = reg2;
	always @ (posedge clock_5M) begin
		if(reset_sample_clk) begin
			reg1 <= 1'b0;
			reg2 <= 1'b0;
		end
		else begin
			reg1 <= w0;
			reg2 <= reg1;
		
		end
	end
	
	
	wire locked;
	assign locked = 1'b0;
	IPPLL3_0002 ippll_inst (
		.refclk   (CLOCK_50),   //  refclk.clk
		.rst      (reset_sample_clk),      //   reset.reset
		.outclk_0 (sample_clk), // outclk0.clk
		.outclk_1 (clock_5M),
		.locked   (locked)    //  locked.export
	);

	
endmodule : RNG_0