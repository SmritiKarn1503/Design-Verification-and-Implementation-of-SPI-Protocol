interface spi_if(input logic sclk,input logic i_reset_n);
    logic mosi;
    logic cs;
    logic miso;
    logic [7:0] dout;

endinterface