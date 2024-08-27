//transaction_m.sv

`ifndef GAURD_TRANSACTION
    `define GAURD_TRANSACTION

class transaction;
        rand bit data_in;
        bit reset_n;
        bit clk;
        bit cs_in;
        bit [7:0] dout_slave;
        bit [7:0] dout_master;
  
    function void display(string name);
        $display("====================================================");
        $display(" %s ", name);
        $display("data_in = %b , cs_in = %d , reset_n = %d", data_in, cs_in, reset_n);

        $display("dout_slave = %b , dout_master = %b", dout_slave, dout_master);
        $display("====================================================");
    endfunction
endclass

`endif