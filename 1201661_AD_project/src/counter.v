module counter(clk, reset, updown, enable, q);
	
	input reg clk, reset, updown, enable;
	output reg [3:0] q;
	wire [3:0] t;
	
	assign t[0] = q[0] | q[2] | ~updown&~q[3] | q[3]&~q[1] | updown&q[1];
	assign t[1] = ~updown&q[0] | q[3]&q[1] | updown&~q[0];
	assign t[2] = ~updown&q[1]&q[0] | updown&q[2]&~q[1]&~q[0] | updown&q[3]&~q[1]&~q[0];
	assign t[3] = ~updown&q[3]&q[1] | updown&~q[2]&~q[1]&~q[0] | ~updown&q[2]&q[1]&q[0];
		
	tff g1(t[0], clk, enable, reset, q[0]);
	tff g2(t[1], clk, enable, reset, q[1]);
	tff g3(t[2], clk, enable, reset, q[2]);
	tff g4(t[3], clk, enable, reset, q[3]);
	
endmodule	