interface Spi_inter(clk);
    input clk;
    logic MOSI,SS_n,rst_n;
    logic MISO;
    modport DUT(
        input MOSI,SS_n,clk,rst_n,
        output MISO
    );
endinterface //interfacename