module ring_oscillator#(
                        parameter NO_STAGES=7      // No of inverter stage 

                        )(
                            input wire en,
                            output wire clk_out
                        );    
    
//    wire [NO_STAGES:0] wi;
//    assign wi[0] = en ? wi[NO_STAGES] : 0;
//    assign clk_out = en ? wi[NO_STAGES] : 0;
//    genvar i;
//    generate 
//        for(i = 0; i < NO_STAGES; i = i+1) begin : ring_chain
//            if(i==0) begin
//                not (wi[i+1], wi[0]);        
//            end
//            else if(i>= NO_STAGES) begin
//                not (wi[i+1], wi[i]);   
//            end
//            else begin 
//                not (wi[i+1], wi[i]);   
//            end
//        end
//    endgenerate  
	

	wire [NO_STAGES -1 :0] wi;
    assign wi[0] = wi[NO_STAGES - 1];
    assign clk_out = en ? wi[NO_STAGES - 1] : 0;
    genvar i;
    generate 
        for(i = 0; i < NO_STAGES - 1; i = i+1) begin : ring_chain
				not (wi[i+1], wi[i]);   
        end
    endgenerate  

	
    
endmodule     