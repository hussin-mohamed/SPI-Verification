package cfg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class ram_confg extends uvm_object;
    `uvm_object_utils(ram_confg)
        virtual ram_inter ram_test_vif;
        uvm_active_passive_enum is_active;
        function new(string name = "ram_confg" );
        super.new(name);
        endfunction
endclass //className extends superClass
endpackage