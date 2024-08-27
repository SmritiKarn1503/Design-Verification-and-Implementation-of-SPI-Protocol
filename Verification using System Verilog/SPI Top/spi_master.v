`timescale 1ns / 1ps


module spi_master(  input clk,
                    input cs_in,
                    input data_in,
                    input reset_n,
                    input miso,
                    output reg sclk,
                    output reg mosi,
                    output reg cs,
                    output reg [7:0] data_out
                    );

//reg [6:0] count;
reg [3:0] count;                            //for clock dividing
reg [3:0] count2;                           //for counting the bits of data frame
reg read_flag;
reg i_sclk;
 //read_flag=count2[0];  
                    
always @(posedge clk, negedge reset_n) begin                //for clock dividing
    if(!reset_n) begin
        count <= 'b0;//clk frequence divide
        //count2 <= 'b0;//read _flag_set//
     
    end
      else if({count[3],count[2],count[1],count[0]} == 4'b1000) begin
        count <= 'b0;
        //count2 <= count2 + 1'b1;
      end
    else begin
        count <= count + 1'b1;
        //count2 <= count2;
    end
end    

always @(posedge i_sclk, negedge reset_n) begin                
    if(!reset_n) begin
        //count <= 'b0;//clk frequence divide
        count2 <= 'b0;//read _flag_set//
     
    end
      else if({count2[3],count2[2],count2[1],count2[0]} == 4'b1000) 
        count2 <= 0;
      //else if({count[3],count[2],count[1],count[0]} == 4'b1000) begin
        //count <= 'b0;
        else
        count2 <= count2 + 1'b1;
//    else begin
//        //count <= count + 1'b1;
//        count2 <= count2;
//    end
end    

always @(posedge i_sclk, negedge reset_n) begin                //for capturing read and write bit
    if(!reset_n)
        read_flag <= 'b0;

      else if(count2 == 'd0)begin
        read_flag <= data_in;
        end
    else
        read_flag <= read_flag;
end            

//CLK DIV FOR FPGA COMPATIBILITY                  
always @(posedge clk, negedge reset_n) begin                
    if(!reset_n) begin
        sclk <= 'b1;
        i_sclk <= 'b1;
        cs <= 'b1;
    end 
//    else if(count[6] && count[5] && count[2] == 1) begin
      else if({count[3],count[2],count[1],count[0]} == 4'b1000) begin
        if(read_flag == 1'b0) begin
           cs <= cs_in;
           if(cs_in==0)begin
            sclk <= ~sclk;
            i_sclk <= ~i_sclk;
           end
           else begin
           sclk <= 'b1;
           i_sclk <= 'b1;
          end
        end 
        else begin
         cs <= cs_in;
         if(cs_in==0)begin
            //if(count2 == 'd7) begin
                //sclk <= ~sclk;
                //i_sclk <= ~i_sclk;
            //end
            //else begin
            sclk <= ~sclk;
            i_sclk <= ~i_sclk;
            //end
          end
          else begin
            sclk='b1;
            i_sclk <= 'b1;
          end 
        end
        end
     else begin
        sclk <= sclk;
        i_sclk <= i_sclk;
        cs <= cs;
    end    
end                            

always @(posedge i_sclk, negedge reset_n) begin        //MOSI Block                
    if(!reset_n) begin                                  //output buses are not reset
        mosi <= 'b0;
    end 
//    else if(count[6] && count[5] && count[2] == 1) begin
//      else if({count[3],count[2],count[1],count[0]} == 4'b1000) begin
      else begin
        if(read_flag == 1'b0) begin
           if(cs_in==0)begin
            mosi <= data_in;
           end
           else begin
           mosi <= mosi;
          end
        end 
        else begin
         if(cs_in==0)begin
//            if(count2 == 'd7) begin
//                data_out <= data_out;
//            end
//            else begin
                data_out <= {miso, data_out[7:1]};
            //end
          end
          else begin
            data_out <= data_out;
          end 
        end
        end
//     else begin
//        mosi <= mosi;
//        data_out <= data_out;
//    end    
end                            

endmodule
