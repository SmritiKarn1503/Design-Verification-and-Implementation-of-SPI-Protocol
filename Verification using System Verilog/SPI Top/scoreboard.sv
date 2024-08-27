`include"transaction.sv"

class scoreboard;
    int count;

    mailbox mon2scb;
    // mailbox gen2drv;
    transaction trn_mon, trn;

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
        // this.gen2drv = gen2drv;
    endfunction

    task main();
        forever begin
            // gen2drv.get(trn_drv);  // Get data from driver
            mon2scb.get(trn_mon);  // Get data from monitor

            $display("MON dout_master: %0d",trn_mon.dout_master);

            $display("MON dout_slave: %0d",trn_mon.dout_slave);
            
            //  if(trn_mon.dout_master == trn_mon.dout_slave)
            //      $display("[sco] :************************************************* ");
            //     $display("[sco] :************DATA MATCHED***************** ");      
            //     $display("[sco] :************************************************* ");
            // // else if(trn_drv.dout_slave == trn_mon.dout_slave)
            // //     $display("[sco] : DATA MATCHED FOR DOUT SLAVE");
            //  else
            //     $display("[sco] :************************************************* ");
            //     $display("[sco] :************DATA MISMATCHED***************** ");      
            //     $display("[sco] :************************************************* ");

            // trn.display("Scoreboard");  // Now it's safe to call display

            count++;
        end
    endtask
endclass