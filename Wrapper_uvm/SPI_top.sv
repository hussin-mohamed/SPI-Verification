import spi_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top ();
    bit clk ;
    initial begin
        forever begin
            #10;
            clk=!clk;
        end
    end
    Spi_inter spi_test_vif(clk);
    ram_inter ram_test_vif(spi_test_vif.clk);
    ram ramm (ram_test_vif);
    Spi_slave_inter Spi_slave_test_vif(spi_test_vif.clk);
    Spi_slave spi (Spi_slave_test_vif);
    assign ram_test_vif.din=Spi_slave_test_vif.rx_data;
    assign Spi_slave_test_vif.tx_data=ram_test_vif.dout;
    assign ram_test_vif.rx_valid=Spi_slave_test_vif.rx_valid;
    assign Spi_slave_test_vif.tx_valid=ram_test_vif.tx_valid;
    assign Spi_slave_test_vif.MOSI=spi_test_vif.MOSI;
    assign spi_test_vif.MISO=Spi_slave_test_vif.MISO;
    assign Spi_slave_test_vif.rst_n=spi_test_vif.rst_n;
    assign Spi_slave_test_vif.SS_n=spi_test_vif.SS_n;
    assign ram_test_vif.rst_n=spi_test_vif.rst_n;
    initial begin
    uvm_config_db#(virtual Spi_inter)::set(null,"*","spi_test_vif",spi_test_vif);
    uvm_config_db#(virtual Spi_slave_inter)::set(null,"*","Spi_slave_test_vif",Spi_slave_test_vif);
    uvm_config_db#(virtual ram_inter)::set(null,"*","ram_test_vif",ram_test_vif);
    run_test("spi_test");
    end

endmodule