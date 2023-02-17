module RNG (	output logic f,
					input logic enable,
					input logic reset,
					
					output logic source_signal_out,
					output logic sampling_signal_out,
					
					input logic PLL_reset,
					output logic signal_tap_clk,
					output logic clk_5M,
					input logic clk_50M);
					
					
	IPPLL3_0002 clk_1000M (
		.refclk   (clk_50M),   //  refclk.clk
		.rst      (~PLL_reset),      //   reset.reset
		.outclk_0 (signal_tap_clk), // outclk0.clk
		.outclk_1 (clk_5M), //outclk1.clk
		.locked   (1'b0)    //  locked.export
	);				
					
	assign source_signal_out = source_signal;
	assign sampling_signal_out = sampling_signal;
				
				
	logic reg_val;
	logic sampling_signal;
	logic source_signal;
	
	
	
	
	ring_oscillator #(7) r_source(enable, source_signal);
	ring_oscillator #(69) r_sampling(enable, sampling_signal);
	
	always @ (posedge sampling_signal or posedge reset) begin
		if(reset) begin
			reg_val <= 1'b0;
		end
		else begin
			reg_val <= source_signal;
		end
	end
	
	assign f = reg_val;



endmodule : RNG




