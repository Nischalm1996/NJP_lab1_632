module RN_buffer #(	parameter SIZE = 16,
							parameter SIZE_BIT = 4)
						(	input logic in_bit,
							input logic enable,
							input logic reset,
							input logic clk,
							output logic [SIZE - 1 : 0] out_data,
							output logic readable);
							
		logic [SIZE_BIT-1: 0] counter;
		
		
		logic [SIZE - 1 : 0] buffer;
		logic full;
		logic half;
		always @ (posedge enable or posedge reset) begin
			if(reset ) begin
				buffer <= 0;
				counter <= 0;
				full <= 1'b0;
				half <= 1'b0;
			end
			else begin
				if((~counter[SIZE_BIT-1]) & (&counter[SIZE_BIT-2 : 0])) begin
					half <= 1'b1;
				end
				else if (~(|counter)) begin
					half <= 1'b0;
				end
				buffer <= {buffer[SIZE-2:0], in_bit};
				counter <= counter + 1'b1;
				full <= &counter;
			end
		end
		
		
		logic [1:0] change;
		always @ (posedge reset or posedge clk) begin
			if(reset) begin
				change <= 2'b00;
			end
			else if (readable) begin
				change <= 2'b00;
			end
			else if (change == 2'b00 & !half) begin
				change <= 2'b01;
			end
			else if(change == 2'b01 & half) begin
				change <= 2'b11;
			end
			else
				change <= change;
		
		end
		
		
		always @ (posedge reset or posedge clk) begin
			if(reset) begin
				out_data <= 0;
				readable <= 1'b0;
			end
			else if (readable) begin
				readable <= 1'b0;
			end
			else if (full & (&change)) begin
				out_data <= buffer;
				readable <= 1'b1;
			end
		end
		
		
		
							
	
endmodule : RN_buffer