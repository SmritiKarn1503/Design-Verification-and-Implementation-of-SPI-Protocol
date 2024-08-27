// interface.sv

interface inf(input logic clk,input logic reset_n);

    logic cs_in;
    logic data_in;
    logic miso;
    logic sclk;
    logic mosi;
    logic cs;
    logic [7:0] data_out;
endinterface
