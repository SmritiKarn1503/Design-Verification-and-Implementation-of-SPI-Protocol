// driver.sv

`include "transaction.sv"

class driver;
    
    int count;
   
    virtual inf vif;
    mailbox gen2drv;
    transaction tr;

    function new(mailbox gen2drv, virtual inf vif);
        this.gen2drv = gen2drv;
        this.vif = vif;
    endfunction

    task main();
        forever begin
            gen2drv.get(tr);
            
            @(posedge vif.clk);
            vif.cs_in <= tr.cs_in;
            vif.data_in <= tr.data_in;

            repeat(8) begin
             @(posedge vif.clk);
            vif.miso <= tr.miso;
            end

            count++;            

            tr.display("DRIVER");
        end
    endtask : main
endclass : driver
