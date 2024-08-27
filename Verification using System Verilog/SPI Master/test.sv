// test.sv
`include "environment.sv"

program test(inf i_inf);

    environment env;

    initial
        begin
            env = new(i_inf);
            env.gen.count = 100;
            env.run();
        end

endprogram
