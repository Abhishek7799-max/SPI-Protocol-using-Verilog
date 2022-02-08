`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:25:09 02/08/2022
// Design Name:   spi_topf
// Module Name:   E:/DA study/Practice/Practice_1/spi_tbf.v
// Project Name:  Practice_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: spi_topf
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module spi_tbf;

	// Inputs
	reg clk;
	reg rst;
	reg [1:0] dtf;
	reg [1:0] slave;

	// Bidirs
	wire miso;
	wire mosi;
	wire sclk;
	wire ssb1;
	wire ssb2;

	// Instantiate the Unit Under Test (UUT)
	spi_topf uut (
		.clk(clk), 
		.rst(rst), 
		.miso(miso), 
		.mosi(mosi), 
		.dtf(dtf), 
		.sclk(sclk), 
		.ssb1(ssb1), 
		.ssb2(ssb2), 
		.slave(slave)
	);

	
		initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		//miso = 0;
		dtf = 0;
		//flag = 0;
		slave = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst = 0;
		dtf = 2'b10;
		//miso = 0;
		//flag = 1;
		slave = 2'b01;
        #6;
		  slave = 2'b10;
		  #10;
		  dtf = 2'b11;
		  //flag = 0;
		 #14;
		 dtf = 0;
		// Add stimulus here

	end
      
		always #1 clk = !clk;
      
endmodule

