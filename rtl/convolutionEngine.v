//convTop=================================================================================================

module convTop ();
	
	//Parameters
	
endmodule	
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

endmodule
	
//windowRegister==========================================================================================
module windowReg(pixelOutLive, pixelOut1, pixelOut0, clk, windowOut);
		
		//declarations
		parameter PIXEL_WIDTH = 8;
		parameter KERNEL_SIZE = 3;
		
		input wire [PIXEL_WIDTH - 1:0] pixelOutLive, pixelOut1, pixelOut0;
		input wire clk;
		output wire [KERNEL_SIZE * KERNEL_SIZE * PIXEL_WIDTH - 1:0] windowOut;
		
		reg [PIXEL_WIDTH - 1:0] window [0:KERNEL_SIZE - 1][0:KERNEL_SIZE - 1];
		integer i;
		integer j;
		
		always @(posedge clk)
			begin
				window[0][0] <= pixelOut0;
				window[1][0] <= pixelOut1;
				window[2][0] <= pixelOutLive;
					for (i = 1; i < KERNEL_SIZE; i = i + 1)
						begin
							for (j = 0; j < KERNEL_SIZE; j  = j + 1)
								begin
									window[j][i] <= window[j][i - 1];
								end 
						end
			end 
			
			assign windowOut = {window[2][2], window[2][1], window[2][0], 
									  window[1][2], window[1][1], window[1][0], 
									  window[0][2], window[0][1], window[0][0]};		
									  
endmodule
//MAC=====================================================================================================

module mac (windowOut, macOut);
	
	//declarations
	parameter KERNEL_SIZE = 3;
	parameter PIXEL_WIDTH = 8;
	parameter WEIGHT_WIDTH = 8;
	parameter MAC_WIDTH = PIXEL_WIDTH + WEIGHT_WIDTH + $clog2(KERNEL_SIZE * KERNEL_SIZE);

	
	input wire[KERNEL_SIZE * KERNEL_SIZE * PIXEL_WIDTH - 1:0] windowOut;
	output wire [MAC_WIDTH - 1:0] macOut;
	reg [PIXEL_WIDTH - 1:0] kernel[0:KERNEL_SIZE * KERNEL_SIZE - 1];
	
	initial
		begin
			kernel[0] = 1;
			kernel[1] = 1;
			kernel[2] = 1;
			kernel[3] = 1;
			kernel[4] = 1;
			kernel[5] = 1;
			kernel[6] = 1;
			kernel[7] = 1;
			kernel[8] = 1;
		end
	
	integer i;
	reg [MAC_WIDTH - 1:0] sum;
	always @(*)
		begin
		sum = 0;
			for (i = 0; i < KERNEL_SIZE * KERNEL_SIZE; i = i + 1)
				sum = sum + windowOut[i*PIXEL_WIDTH +: PIXEL_WIDTH] * kernel[i];
		end
		
	assign macOut = sum;
	
endmodule	
//FSM=====================================================================================================

module validity (clk, valid);

	parameter IMAGE_SIZE = 5;
	parameter COUNT_SIZE = $clog2(IMAGE_SIZE * IMAGE_SIZE);
	parameter COL_SIZE = $clog2(IMAGE_SIZE);
	
	input wire clk;
	output wire valid;
	reg [COUNT_SIZE - 1:0] counter;
	wire [COL_SIZE - 1:0] column;
	wire [COL_SIZE -1:0] row;
	
	initial
		begin
			counter = 0;
		end
	
	always @(posedge clk)
		begin
			counter <= counter + 1;
		end 
		
	
		
	

	
	
	
		
	