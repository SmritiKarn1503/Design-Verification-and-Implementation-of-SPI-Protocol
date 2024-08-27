// // tob_tb.sv
 `timescale 1ns / 1ps
`include "interface.sv"
`include "test.sv"
`include "spi_master.v"
module top_tb();

	bit clk;
	bit reset_n;

    inf i_inf(clk,reset_n);

    spi_master DUT(
        .clk(clk),
        .cs_in(i_inf.cs_in),
        .data_in(i_inf.data_in),
        .reset_n(reset_n),
        .miso(i_inf.miso),
        .sclk(i_inf.sclk),
        .mosi(i_inf.mosi),
        .cs(i_inf.cs),
        .data_out(i_inf.data_out)
    );

	test t1(i_inf);

    always #5 clk = ~clk; // 10ns period clock (100 MHz)

    // Reset sequence
    initial begin
        reset_n = 0;
        clk = 0;
       #20 reset_n = 1; // Deassert reset after 20ns
    end


    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(1, top_tb.DUT,i_inf);
    end

endmodule
