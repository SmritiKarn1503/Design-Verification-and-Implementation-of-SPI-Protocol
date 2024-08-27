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
        wait(!vif.reset_n);
        $display("Reset started..........");
        vif.cs_in <= 0;
        vif.data_in <= 0;        
    endtask


    task main();
        forever begin
        gen2drv.get(trn);

        repeat(8) begin
            
        @(posedge vif.clk);
        vif.cs_in <= trn.cs_in;
        vif.data_in <= trn.data_in;
        end

        count++;
        trn.display("Driver");
    end
    endtask
endclass