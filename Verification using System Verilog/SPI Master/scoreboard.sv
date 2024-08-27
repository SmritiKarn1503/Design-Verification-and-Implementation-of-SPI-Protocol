
// scoreboard.sv
`include "transaction.sv"

class scoreboard;
    
    mailbox mon2scb;
    transaction tr_drv, tr_mon;
    int count;

    bit [7:0] received_data;
    int i;

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    task main();
        forever begin
            // Get the monitored data
            mon2scb.get(tr_mon);

            received_data <= {tr_mon.miso , received_data[7:1]};
            $display("received_data = %b", received_data);
   
                     if (received_data == tr_mon.data_out) begin
                         $display("[SCO] : DATA MATCHED");
                     end else begin
                         $display("[SCO] : DATA MISMATCHED");
            
                     end

                    count++;
         
        end
    endtask : main
endclass : scoreboard
