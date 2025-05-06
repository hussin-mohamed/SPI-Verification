interface Spi_slave_inter(clk);
    input clk;
    logic MOSI,SS_n,clk,rst_n,tx_valid;
    logic [7:0] tx_data;
    logic [9:0] rx_data;
    logic MISO,rx_valid;
    modport dut (
    input MOSI,SS_n,clk,rst_n,tx_valid,tx_data,
    output rx_data,MISO,rx_valid
    );
endinterface //interfacename