//transaction.sv

`ifndef GAURD_TRANSACTION
    `define GAURD_TRANSACTION

class transaction;
        rand bit mosi;
        bit miso;
        bit i_reset_n;
        bit sclk;
        bit cs;
        bit [7:0] dout;
  
    function void display(string name);
        $display("====================================================");
        $display(" %s ", name);
        $display("sclk = %d , MOSI = %d , cs = %d , i_reset_n = %d", sclk, mosi, cs, i_reset_n);

        $display("MISO = %d , dout = %b", miso, dout);
        $display("====================================================");
    endfunction
endclass

`endif