`include "transaction.sv"

class monitor;

    virtual spi_if vif;
    mailbox mon2scb;
    
    
    function new(virtual spi_if vif, mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task main();
        forever begin
		transaction trn;
                trn = new();

                @(posedge vif.sclk)
                trn.i_reset_n = vif.i_reset_n;
                trn.mosi = vif.mosi;
                trn.cs = vif.cs;
                trn.miso = vif.miso;
                trn.dout = vif.dout;

                mon2scb.put(trn);
                trn.display("Monitor");
             end
    endtask
endclass