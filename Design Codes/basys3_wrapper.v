`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2024 00:57:46
// Design Name: 
// Module Name: basys3_wrapper
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


module basys3_wrapper(
            input  wire clk,
            //input wire btnR,
            input wire [10:0]sw,
             output wire [15:0] led
           
);
   wire piso_to_master;
   
    top WRAP(
               .clk(clk),
               .reset_n(~sw[10]),
               .cs_in(sw[9]),
               .data_in(piso_to_master),
               .dout_slave(led[7:0]),
               .dout_master(led[15:8])
           );  

    piso_1 p1(
                 .sw(sw[8:0]),
                //input en,
                .clk(clk),
                .reset_n(~sw[10]),
                .out(piso_to_master)
                );
 endmodule