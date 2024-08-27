`timescale 1ns / 1ps

//README:
//---> count variable is to count the no. of bits of the frame.
//---> read_flag is the first bit of the data frame.
//---> read_flag = 0 for write into slave by mosi line.
//---> read_flag = 1 for read through slave, by sending data to master, on miso line.

module spi_slave(
                    input sclk, mosi,cs,i_reset_n,
                    output reg [7:0] dout,
                    output reg miso
                   );
integer count;             
reg  read_flag;

always @(posedge sclk,negedge i_reset_n) begin// edge negedge cs)/* posedge cs)*/ begin
    if(!i_reset_n)
        count <= 0;
    else if(!cs && (count == 8)) 
        count <= 0;
     else
        count <= count + 1;           
    end

//to sample read_flag
 
always @(posedge sclk,negedge i_reset_n) begin
   if(!i_reset_n)
        read_flag <= 1;
   else if(!cs && (count == 0)) 
        read_flag <= mosi;  
 end
 
//to write in slave

always @(posedge sclk) begin
   if(!cs && (read_flag==0) && (count > 0) && (count <= 8))
            dout <= {mosi,dout[7:1]};        
 end  

//to drive MISO

always @(posedge sclk,negedge i_reset_n) begin
    if(!i_reset_n)
        miso <= 1'b0;
    else if(!cs && read_flag && (count > 0) && (count <= 8))
        miso <= dout[count - 1]; //TODO
end

endmodule
