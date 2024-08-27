`include"transaction.sv"

class scoreboard;
    
    int count;
    bit [7:0] received_data;

    mailbox gen2drv;
    mailbox mon2scb;
    transaction trn_mon;

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
        // this.gen2drv = gen2drv;
    endfunction


    task main();

        
           forever begin
                // gen2drv.get(trn_drv);  // Get data from driver
                mon2scb.get(trn_mon);  // Get data from monitor

                received_data <= {trn_mon.mosi,received_data[7:1]};
                $display("received_data = %b", received_data);

                     if (received_data == trn_mon.dout) 
                     begin
                         $display("[SCO] : DATA MATCHED");
                     end 
                     else 
                     begin
                         $display("[SCO] : DATA MISMATCHED");
                     end

                count++;
            end
    endtask
endclass