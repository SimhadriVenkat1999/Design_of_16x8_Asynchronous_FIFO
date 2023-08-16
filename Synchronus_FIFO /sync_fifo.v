//----------------------- 16x8 synchronus FIFO-----------------------//
`timescale 1ns/1ps
module sync_fifo(clk,rst,data_in,wr_en,rd_en,data_out,fifo_full,fifo_empty,fifo_counter);

parameter addr_width = 4;  	//width of address bits
parameter addr_loc = 1<<addr_width; //16	//no of address locations
parameter mem_width = 8; 		//size of each location

input clk,rst,wr_en,rd_en;
input [mem_width-1:0]data_in ; //7:0,  8bits

output reg [mem_width-1:0]data_out ; //7:0 ,8bits
output reg fifo_empty,fifo_full;
output reg [addr_width:0] fifo_counter; //4:0 , 5bits

reg [addr_width-1:0] rd_pt, wr_pt; //3:0 , 4bits
reg [mem_width-1:0] fifo_block [addr_loc-1:0];  


//========================fifo empty,full============================//
always@(fifo_counter)
begin
fifo_empty = (fifo_counter == 0);
fifo_full = (fifo_counter == addr_loc);
end

//======================== data write into FIFO block =============//
always@(posedge clk)
begin
if(wr_en && !fifo_full)
fifo_block[wr_pt] <= data_in;
end

//========================== data read from FIFO block ============//
always@(posedge clk)
begin
if(rd_en && !fifo_empty)
 data_out = fifo_block[rd_pt];
end

//===================== rd_pt,wr_pt updation==============//
always@(posedge clk)
begin 
	if (rst)
		begin
		wr_pt <= 0;
		rd_pt <= 0;
		end

		else begin 
		wr_pt <= (wr_en && !fifo_full)? wr_pt+1: wr_pt;
		rd_pt <= (rd_en && !fifo_empty) ? rd_pt+1 : rd_pt;
     end 
end

//====================== fifo counter ===============//
always@(posedge clk)
begin
	if(rst)
			fifo_counter <= 0;
else
begin	
		case({wr_en,rd_en})
		2'b00 : fifo_counter <= fifo_counter;
		2'b01 : fifo_counter <= ~fifo_empty?fifo_counter-1:fifo_counter;
		2'b10 : fifo_counter <= ~fifo_full ? fifo_counter+1 : fifo_counter;
		2'b11 : fifo_counter <= fifo_counter;
		endcase
		
end
end
endmodule
