`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:     Abhishek Pandya
// 
// Create Date:    15:34:53 02/07/2022 
// Design Name: 
// Module Name:    spi_mak 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// full duplex, 
// faster than UART, I2C 
// taking dtf as data transfer signal
// full duplex communication
/* 
dtf can be 2 bit signal
dtf = 2'b00 means no communication 
      2'b01 means data from slave to master
		2'b10 means data from master to slave
		2'b11 means full duplex communication		
*/

module spi_masterf( input clk, rst, miso, // flag = 0 means data from slave to master and vice versa 
input [1:0] slave, dtf, 
output reg sclk, mosi, ssb1, ssb2
    );
	 
reg [7:0] stor_reg1,stor_reg2;
reg [2:0] k,p;
always @(clk)
begin
if(rst)
begin
stor_reg1 = 8'b01110101;
//stor_reg2 = 8'b01010010;
k = 0;
p = 0;
sclk = 0;
mosi = 0;
ssb1 = 0; // ssb is active low version of ss, ss = !ssb 
ssb2 = 0;
end

else if(dtf == 2'b01 || dtf == 2'b10 || dtf == 2'b11)
begin
sclk = clk;

if(clk)
begin
if(slave == 2'b01)
begin
ssb1 = 1;
ssb2 = 0;
end
else if(slave == 2'b10)
begin
ssb2 = 1;
ssb1 = 0;
end
else
begin
ssb1 = 0;
ssb2 = 0;
end
end

if(dtf == 2'b10 & clk)
begin
mosi = stor_reg1[k];
k = k + 1;
end
else if (dtf == 2'b01 & clk) 
begin
stor_reg2[p] = miso;
p = p + 1;
end
else if (dtf == 2'b11 & clk)
begin
mosi = stor_reg1[k];
k = k + 1;
stor_reg2[p] = miso;
p = p + 1;
end
end

end

endmodule

module spi_slave1f(input sclk, mosi, ssb, 
input [1:0] dtf, // flag = 0 means data from slave to master and vice versa
output reg miso
);
reg [7:0] stor_reg1,stor_reg2;
reg [2:0] i,j;

initial 
begin
stor_reg2 = 8'b01010010;
i = 0;
j = 0;
end 

always @(posedge sclk)
begin
if(((dtf == 2'b10) || (dtf == 2'b11) )&& ssb)
begin
stor_reg1[i] = mosi;
i = i + 1;
end
if(((dtf == 2'b01) || (dtf == 2'b11) )&& ssb)
begin
miso = stor_reg2[j];
j = j + 1;
end

end
endmodule

module spi_slave2f(input sclk, mosi, ssb, 
input [1:0] dtf, // flag = 0 means data from slave to master and vice versa
output reg miso
);
reg [7:0] stor_reg1,stor_reg2;
reg [2:0] i,j;

initial 
begin
stor_reg2 = 8'b01010010;
i = 0;
j = 0;
end 

always @(posedge sclk)
begin
if(((dtf == 2'b10) || (dtf == 2'b11) )&& ssb)
begin
stor_reg1[i] = mosi;
i = i + 1;
end
if(((dtf == 2'b01) || (dtf == 2'b11) )&& ssb)
begin
miso = stor_reg2[j];
j = j + 1;
end

end
endmodule



module spi_topf (clk, rst, miso, mosi, dtf, sclk, ssb1, ssb2, slave );
input clk, rst;
inout miso, mosi;
inout sclk, ssb1, ssb2;
input [1:0] slave, dtf;
wire miso1, miso2;
assign miso = ((slave == 2'b01) ? miso1 : miso2) && ((dtf == 2'b01) || (dtf == 2'b11));
spi_masterf p1 (clk, rst, miso, slave, dtf, sclk, mosi, ssb1, ssb2 );
spi_slave1f p2 (sclk, mosi, ssb1, dtf, miso1);
spi_slave2f p3 (sclk, mosi, ssb2, dtf, miso2);

endmodule
