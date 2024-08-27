`include "transaction.sv"

class driver;
    
    int count;
    transaction trn;
    virtual spi_if vif;
    mailbox gen2drv;

    function new(mailbox gen2drv, virtual spi_if vif);
        this.gen2drv = gen2drv;
        this.vif = vif;
    endfunction


    task reset();
        wait(!vif.i_reset_n);
        $display("Reset started..........");
        vif.cs <= 0;
        vif.mosi <= 0;        
    endtask


    task main();
    begin
        forever begin
        gen2drv.get(trn);
        @(posedge vif.sclk);
        vif.cs <= trn.cs;
        vif.mosi <= trn.mosi;
        // trn.miso = vif.miso;
        // trn.dout = vif.dout;

        count++;
        trn.display("Driver");
    end
    end
    endtask
endclass