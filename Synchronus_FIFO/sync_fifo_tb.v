`timescale 1ns/1ps
module sync_fifo_tb();
parameter addr_width = 4;  	//width of address bits
parameter addr_loc = 1<<addr_width;	//no of address locations
parameter mem_width = 8; 		//size of each location

reg clk,rst,wr_en,rd_en;
reg [mem_width-1:0]data_in;

wire [mem_width-1:0]data_out ;
wire fifo_empty,fifo_full;
wire [addr_width:0] fifo_counter;

sync_fifo DUT (clk,rst,data_in,wr_en,rd_en,data_out,fifo_full,fifo_empty,fifo_counter);

initial
clk=0;

always #5 clk = ~clk;

initial 
begin 
#10 rst=1; wr_en=1; rd_en=0; data_in=8'hab;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'hab;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h34;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h35;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h36;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h37;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h38;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h39;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h40;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h41;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h42;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h43;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h44;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h46;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h25;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h45;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h55;
#10 rst=0; wr_en=0; rd_en=1; data_in=8'h65;
#10 rst=0; wr_en=1; rd_en=0; data_in=8'h42;
#10 rst=0; wr_en=1; rd_en=1; data_in=8'h46;
//#10 rst=0; wr_en=1; rd_en=1; data_in=8'h59;
//#10 rst=0; wr_en=1; rd_en=0; data_in=8'h47;

#300 $finish;
end

endmodule
