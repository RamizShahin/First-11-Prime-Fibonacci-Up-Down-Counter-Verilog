module tff(t, clk, enable, reset, q);	   
	
	input clk, enable, reset;
	input reg t;
	output reg q;
  
	always @(negedge clk) begin
		if (enable) begin
			if(t)
        		q = ~q;
		end
	end
	
	always @(posedge reset) begin
		q = 0;
	end
	
	initial begin
		q = 0;
	end

endmodule