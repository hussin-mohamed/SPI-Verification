package driverr;
    import uvm_pkg::*;
    import cfggg::*;
    import sequence_itemmm::*;
    `include "uvm_macros.svh"
    class ram_driver extends uvm_driver#(seq_itemmm);
    `uvm_component_utils(ram_driver)
    parameter testcases = 20000;
    seq_itemmm item;
    virtual ram_inter ram_test_vif;
        function new(string name="ram_driver",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction 
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                item = seq_itemmm::type_id::create("item");
                seq_item_port.get_next_item(item);
                ram_test_vif.din=item.din;
                ram_test_vif.rst_n=item.rst_n;
                ram_test_vif.rx_valid=item.rx_valid;
                @(negedge ram_test_vif.clk);
                seq_item_port.item_done();
            end
        endtask //run_phase
    endclass //className extends superClass
endpackage