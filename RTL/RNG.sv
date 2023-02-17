module RNG (	output logic f,
					input logic enable,
					input logic reset);
				
	logic reg_val;
	logic sampling_signal;
	logic source_signal;
	
	ring_oscillator #(7) r_source(enable, source_signal);
	ring_oscillator #(69) r_sampling(enable, sampling_signal_signal);
	
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




