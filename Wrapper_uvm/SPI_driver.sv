package drive;
    import uvm_pkg::*;
    import cfg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class spi_driver extends uvm_driver#(seq_item);
    `uvm_component_utils(spi_driver)
    parameter testcases = 20000;
    seq_item item;
    virtual Spi_inter spi_test_vif;
        function new(string name="spi_driver",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction 
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                item = seq_item::type_id::create("item");
                seq_item_port.get_next_item(item);
                spi_test_vif.SS_n = item.SS_n;
                spi_test_vif.rst_n = item.rst_n;
                spi_test_vif.MOSI = item.MOSI;
                @(negedge spi_test_vif.clk);
                seq_item_port.item_done();
            end
        endtask //run_phase
    endclass //className extends superClass
endpackage