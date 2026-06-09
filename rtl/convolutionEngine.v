//convTop=================================================================================================

module convTop ();
	
	//Parameters
	
	
//Line buffer=============================================================================================
module lineBuffer (pixelIn, clk, pixelOut);

	//declarations 
	parameter IMAGE_SIZE = 5;
	parameter PIXEL_WIDTH = 8;
	input wire [PIXEL_WIDTH - 1:0] pixelIn;
	input wire clk;
	output wire [PIXEL_WIDTH - 1:0] pixelOut;

	
	reg [PIXEL_WIDTH - 1:0] shiftReg [0:IMAGE_SIZE - 1];
	integer i;
	
	//shift reg 
	
	always @(posedge clk)
		begin
			shiftReg[0] <= pixelIn;
			for (i = 1; i < IMAGE_SIZE; i = i+ 1)
				shiftReg[i] <= shiftReg[i - 1];
		end
	
	assign pixelOut = shiftReg[IMAGE_SIZE - 1];	
	
//MAC=====================================================================================================
//windowRegister==========================================================================================
//FSM=====================================================================================================
