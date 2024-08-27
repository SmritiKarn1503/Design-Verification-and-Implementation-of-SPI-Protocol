// monitor.sv

`include "transaction.sv"

class monitor;
    
    virtual inf vif;
    mailbox mon2scb;

    function new(virtual inf vif, mailbox mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task main();
        transaction tr = new();
        forever begin
        	repeat(9)
            @(posedge vif.clk);
            tr.cs_in = vif.cs_in;
            tr.data_in = vif.data_in;
            tr.reset_n = vif.reset_n;
            tr.miso = vif.miso;
            tr.sclk = vif.sclk;
            tr.mosi = vif.mosi;
            tr.cs = vif.cs;
            tr.data_out = vif.data_out;
            mon2scb.put(tr);
            tr.display("MONITOR");
        end
    endtask : main
endclass : monitor
