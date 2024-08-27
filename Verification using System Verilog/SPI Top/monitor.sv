`include "transaction.sv"

class monitor;

    virtual spi_if vif;
    mailbox mon2scb;
    
    
    function new(virtual spi_if vif, mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task main();
        
		transaction trn;
        trn = new();

        forever  begin
            repeat(9)
                @(posedge vif.clk)
                trn.reset_n = vif.reset_n;
                trn.data_in = vif.data_in;
                trn.cs_in = vif.cs_in;
                trn.dout_slave = vif.dout_slave;
                trn.dout_master = vif.dout_master;

                mon2scb.put(trn);
                trn.display("Monitor");
             end
    endtask


endclass