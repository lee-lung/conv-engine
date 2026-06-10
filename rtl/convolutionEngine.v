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
		
		input wire [PIXEL_WIDTH - 1:0] pixelOutlive, pixelOut1, pixelOut0;
		input wire clk;
		output wire [KERNEL_SIZE * KERNEL_SIZE * PIXEL_WIDTH - 1:0] windowRegOut;
		
		reg [PIXEL_WIDTH - 1:0] window [0:KERNEL_SIZE - 1][0:KERNEL_SIZE - 1];
		
		always @(posedge clk)
			begin
				integer i;
					for (i = 0; i < KERNEL_SIZE; i = i + 1)
						for (j = 0; j < KERNEL_SIZE; j  = j + 1)
			end 
					

			
		
		always @(posedge clk)
			for (i = 0; i < KERNEL_SIZE; i = i+ 1)
				
		
//MAC=====================================================================================================

module mac ();
	//declarations
	parameter KERNEL_SIZE = 3;
	parameter 
//FSM=====================================================================================================
