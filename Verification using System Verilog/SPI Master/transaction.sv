// transaction.sv

`ifndef GUARD_TRANSACTION
    `define GUARD_TRANSACTION
class transaction;
    
    bit clk;
    bit cs_in;
    rand bit data_in;
    bit reset_n;
    rand bit miso;
    bit sclk;
    bit mosi;
    bit cs;
    bit [7:0] data_out;

    function void display(string name);
        $display("====================================================");
        $display(" %s ", name);
        $display("cs_in = %d , data_in = %d , reset_n = %d , miso = %d", cs_in, data_in, reset_n, miso);
        $display("sclk = %d , mosi = %d , cs = %d , data_out = %b", sclk, mosi, cs, data_out);
        $display("====================================================");
    endfunction : display

    constraint c1 { cs_in == 0; } // Ensure SPI slave is selected

endclass : transaction
`endif
