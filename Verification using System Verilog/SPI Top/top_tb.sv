`timescale 1ns / 1ps

`include "interface.sv"
`include "test.sv"
`include "top.v"

module top_tb;

    bit clk;
    bit reset_n;


    spi_if i_intf(clk, reset_n); // Instantiating the SPI interface
    
    // Instantiating the SPI slave module
    top DUT (
        .clk(clk), 
        .data_in(i_intf.data_in),
        .cs_in(i_intf.cs_in),
        .reset_n(reset_n),
        .dout_master(i_intf.dout_master),
        .dout_slave(i_intf.dout_slave)

    );


    test t1(i_intf); // Connecting the interface to the test program

    always #5 clk = ~clk; // Generate clock with a 10 ns period (100 MHz)


    // Initial block for generating the clock and reset signals
    initial begin
        clk = 0;
        reset_n = 0;
        i_intf.cs_in = 1; // Ensure chip select is inactive initially
        #10 i_intf.cs_in = 0;

        #20 reset_n = 1; // Release reset after 5 ns
        
        
    end

    // Dumping the waveform for analysis
    initial begin
        $dumpfile("wave.vcd"); 
        $dumpvars(1, top_tb.DUT, i_intf); // Dumping all variables in the tbench_top module
    end

    // End simulation after a certain time (optional, but useful for stopping infinite simulation)
    // initial begin
    //     #1000; // Adjust the time as per your test duration
    //     $finish;
    // end

endmodule
