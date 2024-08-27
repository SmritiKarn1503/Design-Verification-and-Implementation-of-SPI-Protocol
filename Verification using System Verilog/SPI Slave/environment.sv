`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
    generator gen;
    driver drv;
    monitor mon;
    scoreboard scb;

    mailbox gen2drv;
    mailbox mon2scb;

    virtual spi_if vif;


    function new(virtual spi_if vif);
        this.vif = vif;

        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);
        drv = new(gen2drv, vif);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
    endfunction


    task test();
        fork
            gen.main();
            drv.main();
            mon.main();
            scb.main();
        join_any
    endtask


    task start();
        wait(gen.ended.triggered);
        wait(drv.count == gen.count);
        wait(scb.count == gen.count);
    endtask : start


    task run();
        pre_start();
        test();
        start();

        #100;
        $finish;
    endtask
    
endclass