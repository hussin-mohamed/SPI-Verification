package cfgg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class Spi_slave_confg extends uvm_object;
    `uvm_object_utils(Spi_slave_confg)
        virtual Spi_slave_inter Spi_slave_test_vif;
        uvm_active_passive_enum is_active;
        function new(string name = "Spi_slave_confg" );
        super.new(name);
        endfunction
endclass //className extends superClass
endpackage