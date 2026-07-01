`timescale 1ns/1ps


module convTop_tb();

	//parameters
	parameter DELAY = 5;
	parameter PIXEL_WIDTH = 8;
	parameter KERNEL_SIZE = 3;
	parameter WEIGHT_WIDTH = 8;
	parameter MAC_WIDTH = PIXEL_WIDTH + WEIGHT_WIDTH + $clog2(KERNEL_SIZE * KERNEL_SIZE);
	
	//signal declarations
	logic [PIXEL_WIDTH - 1:0] pixelIn;
	logic pixel_valid;
	logic rst_n;
	logic signed [MAC_WIDTH - 1:0] macOut;
	logic valid;

	//storage arrays 
	//DUT instantiation
	convTop DUT (.clk(clk), .rst_n(rst_n), .pixelIn(pixelIn),.macOut(macOut), .pixel_valid(pixel_valid),
	.valid(valid));
	
	//Activity region
	//Clock generator
	logic clk = 1'b0;
	always #DELAY clk = ~clk;
	
	//stimulus sequence 
	initial
		begin
			pixelIn <= 0;
			pixel_valid <= 0;
			rst_n <= 0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			rst_n <= 1;
		end 
	//capture + scoreboard 
	//termination and summary 
endmodule
	
	
	