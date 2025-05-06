import Spi_slave_test_pkg::*;
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
    Spi_slave_inter Spi_slave_test_vif(clk);
    Spi_slave dut (Spi_slave_test_vif);
    initial begin
    uvm_config_db#(virtual Spi_slave_inter)::set(null,"*","Spi_slave_test_vif",Spi_slave_test_vif);
    run_test("Spi_slave_test");
    end

endmodule