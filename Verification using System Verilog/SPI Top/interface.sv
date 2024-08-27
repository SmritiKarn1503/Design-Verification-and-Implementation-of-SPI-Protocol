interface spi_if(input logic clk,input logic reset_n);
    logic cs_in;
    logic data_in;
    logic [7:0] dout_slave;
    logic [7:0] dout_master;

endinterface