// environment.sv

`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

    generator gen;
    driver driv;
    monitor mon;
    scoreboard scb;

    mailbox gen2drv;
    mailbox mon2scb;
    virtual inf vif;

    function new(virtual inf vif);
        this.vif = vif;
        gen2drv = new();
        mon2scb = new();
        gen = new(gen2drv);
        driv = new(gen2drv, vif);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
    endfunction

    task test();
        fork
            gen.main();
            driv.main();
            mon.main();
            scb.main();
        join_any
    endtask : test

    task start();
    	wait(gen.ended.triggered);
    	wait(driv.count == gen.count);
    	wait(scb.count == gen.count);
    endtask : start

    task run();
        test();
        start();
        #1000;
        $finish;
    endtask : run

endclass : environment
