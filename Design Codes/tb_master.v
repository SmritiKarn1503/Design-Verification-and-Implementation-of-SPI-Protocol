`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2024 19:00:14
// Design Name: 
// Module Name: tb_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_master();
    
reg clk;
reg cs_in;
reg data_in;
reg reset_n;
reg miso;
wire sclk;
wire mosi;
wire cs;
wire [7:0] data_out;

SPI_master m1(
               clk,
               cs_in,
               data_in,
               reset_n,
               miso,
               sclk,
               mosi,
               cs,
               data_out
               );
                
always #5 clk = ~clk;

initial begin
    clk = 'b0;
    reset_n = 'b0;
    #2 reset_n = 'b1;
    #10 cs_in = 'b0;
end

initial fork
    #140 data_in = 1'b0;
    #280 data_in = 1'b0;
    #420 data_in = 1'b1;
    #560 data_in = 1'b0;
    #700 data_in = 1'b0;
    #840 data_in = 1'b1;
    #980 data_in = 1'b1;
    #1120 data_in = 1'b1;
    #1260 data_in = 1'b0;
    #1400 data_in = 1'b1;
    #5000 $finish();
join  

initial fork
    #1520 miso = 0;
    #1660 miso = 1'b0;
    #1800 miso = 1'b0;
    #1940 miso = 1'b1;
    #2080 miso = 1'b0;
    #2120 miso = 1'b1;
    #2260 miso = 1'b0;
    #2400 miso = 1'b1;
    #2540 miso = 1'b0;
    #2680 miso = 1'b1;
    #2820 miso =1'b0;
    #2960 miso = 1'b1;
    #3100 miso =1'b0;
join

endmodule

