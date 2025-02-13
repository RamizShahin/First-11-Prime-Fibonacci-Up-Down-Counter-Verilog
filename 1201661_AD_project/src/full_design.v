module project(clk, reset, updown, enable, mode, out);
	
	input clk, reset, updown, enable, mode;		//mode 0 = prime sequence
	output reg [5:0] out; 
	wire [3:0] q; 
	
	counter c(clk, reset, updown, enable, q);
	
	assign out[0] = ~mode&q[0] | ~mode&q[1] | q[2]&~q[1] | q[2]&q[0] | q[3]&~q[0] | ~q[3]&~q[1]&q[0] | ~q[2]&q[1]&~q[0];
	assign out[1] = q[3]&q[1] | ~mode&~q[1]&~q[0] | ~mode&q[1]&q[0] | ~q[2]&q[1]&q[0] | q[2]&~q[1]&~q[0] | mode&q[3]&q[0] | ~mode&~q[3]&~q[2]&~q[1];
	assign out[2] = ~mode&q[3] | q[3]&~q[0] | ~mode&~q[2]&q[1] | q[2]&~q[1]&q[0] | mode&q[2]&q[0];
	assign out[3] = ~mode&q[2]&~q[1] | ~mode&q[3]&q[0] | ~mode&q[3]&q[1] | mode&q[2]&q[1];
	assign out[4] = ~mode&q[3] | q[3]&~q[0] | ~mode&q[2]&q[1];
	assign out[5] = mode&q[3]&q[0] | mode&q[3]&q[1];
								    
endmodule


module proj_tb();
	
	reg clk, reset, updown, enable, mode;
	wire [5:0] out;
	
	project p1(clk, reset, updown, enable, mode, out);
	
	initial begin
		clk = 0;
		{mode, reset, updown, enable} = 4'b0000;
		
		repeat(16) begin
		repeat(30)
		#10ns clk = ~clk;
		{mode, reset, updown, enable} = {mode, reset, updown, enable} + 1;
		end
		
	end	
endmodule