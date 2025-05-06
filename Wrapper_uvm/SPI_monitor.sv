package spi_monitor;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item::*;
    class spi_monitor extends uvm_monitor;
        `uvm_component_utils(spi_monitor)
        seq_item item;
        virtual Spi_inter spi_test_vif;
        uvm_analysis_port #(seq_item) mon_ap;
        function new(string name = "spi_monitor",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            mon_ap=new("mon_ap",this);
        endfunction 
        task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            item = seq_item::type_id::create("item");
            @(negedge spi_test_vif.clk);
            item.SS_n = spi_test_vif.SS_n;
            item.rst_n = spi_test_vif.rst_n;
            item.MOSI = spi_test_vif.MOSI;
            item.MISO = spi_test_vif.MISO;
            mon_ap.write(item);
        end
    endtask //
    endclass //className extends superClass
endpackage