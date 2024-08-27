`include "transaction.sv"

class generator;
  int count;
  transaction trn;
  mailbox gen2drv;
  event ended;

  // Constructor
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task main();
    repeat(count)
      begin
        trn = new();
        trn.randomize();
        trn.display("Generator");
        gen2drv.put(trn);
      end

      ->ended;
      
  endtask

endclass