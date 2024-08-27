`timescale 1ns / 1ps

`include "interface.sv"
`include "test.sv"
`include "spi_slave.sv"

module top_tb;

    bit sclk;
    bit i_reset_n;


    spi_if i_intf(sclk,i_reset_n); // Instantiating the SPI interface
    
    // Instantiating the SPI slave module
    slave2 DUT (
        .sclk(sclk), 
        .mosi(i_intf.mosi),
        .cs(i_intf.cs),
        .i_reset_n(i_reset_n),
        .dout(i_intf.dout),
        .miso(i_intf.miso)
    );


    test t1(i_intf); // Connecting the interface to the test program

    always #5 sclk = ~sclk; // Generate clock with a 10 ns period (100 MHz)


    // Initial block for generating the clock and reset signals
    initial begin
        sclk = 0;
        i_reset_n = 0;
        //i_intf.cs = 1; // Ensure chip select is inactive initially
        i_intf.cs = 0;
        #5 i_reset_n = 1;

       // #20 i_reset_n = 1; // Release reset after 5 ns
        
        
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
