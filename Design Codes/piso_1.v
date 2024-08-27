`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2024 10:59:20
// Design Name: 
// Module Name: piso_1
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


module piso_1(
                input [8:0] sw,
                //input en,
                input clk,
                input reset_n,
                output reg out
                );
reg [8:0] in_reg; reg [8:0] in_reg2; reg i_sclk; reg[3:0] count;

//assign in_wire = in_reg;
 
always@(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        in_reg <= 9'b0;
    end
    else 
        in_reg <= sw;
end

always@(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        i_sclk <= 1'b1;
    end
    else if({count[3],count[2],count[1],count[0]}==4'b1000)
        i_sclk <= ~i_sclk;
end

always @(posedge clk, negedge reset_n) begin
    if(!reset_n)
        count <= 4'b0;
    else
        count <= count + 1'b1;
end

always @(posedge i_sclk, negedge reset_n) begin
    if(!reset_n)
        out <= 1'b1;
    else
        out <= in_reg2[0];
        in_reg2 <= (in_reg >> 1); 
end
     
endmodule
