package Spi_slave_monitor;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_itemm::*;
    class Spi_slave_monitor extends uvm_monitor;
        `uvm_component_utils(Spi_slave_monitor)
        seq_itemm item;
        virtual Spi_slave_inter Spi_slave_test_vif;
        uvm_analysis_port #(seq_itemm) mon_ap;
        function new(string name = "Spi_slave_monitor",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            mon_ap=new("mon_ap",this);
        endfunction 
        task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            item = seq_itemm::type_id::create("item");
            @(negedge Spi_slave_test_vif.clk);
            item.SS_n = Spi_slave_test_vif.SS_n;
            item.rst_n = Spi_slave_test_vif.rst_n;
            item.tx_valid = Spi_slave_test_vif.tx_valid;
            item.MOSI = Spi_slave_test_vif.MOSI;
            item.tx_data = Spi_slave_test_vif.tx_data;
            item.rx_data = Spi_slave_test_vif.rx_data;
            item.MISO = Spi_slave_test_vif.MISO;
            item.rx_valid = Spi_slave_test_vif.rx_valid;
            mon_ap.write(item);
        end
    endtask //
    endclass //className extends superClass
endpackage