package cfg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class spi_confg extends uvm_object;
    `uvm_object_utils(spi_confg)
        virtual Spi_inter spi_test_vif;
        uvm_active_passive_enum is_active;
        function new(string name = "spi_confg" );
        super.new(name);
        endfunction
endclass //className extends superClass
endpackage