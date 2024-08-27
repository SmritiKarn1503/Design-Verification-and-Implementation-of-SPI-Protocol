`include "environment.sv"

program test(spi_if i_intf);

    environment env;

        initial begin
            env = new(i_intf);

            env.gen.count = 100;
            
            env.run();
        end

endprogram