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
	
//windowRegister==========================================================================================
module windowReg(pixelOut2, pixelOut1, pixelOut0, clk, windowRegOut);
		
		//declarations
		parameter PIXEL_WIDTH = 8;
		parameter KERNEL_SIZE = 3;
		
		input wire [PIXEL_WIDTH - 1 : 0] pixelOutlive, pixelOut1, pixelOut0;
		input wire clk;
		output wire [KERNEL_SIZE * KERNEL_SIZE * PIXEL_WIDTH - 1:0] windowRegOut;
		
		reg [PIXEL_WIDTH - 1:0][PIXEL_WIDTH - 1:0];
//MAC=====================================================================================================

module mac ();
	//declarations
	parameter KERNEL_SIZE = 3;
	parameter 
//FSM=====================================================================================================
