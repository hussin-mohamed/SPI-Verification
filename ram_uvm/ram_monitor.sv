package monitorr;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item::*;
    class ram_monitor extends uvm_monitor;
        `uvm_component_utils(ram_monitor)
        seq_item item;
        virtual ram_inter ram_test_vif;
        uvm_analysis_port #(seq_item) mon_ap;
        function new(string name = "ram_monitor",uvm_component parent = null);
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
            @(negedge ram_test_vif.clk);
            item.dout=ram_test_vif.dout;
            item.tx_valid=ram_test_vif.tx_valid;
            item.rst_n=ram_test_vif.rst_n;
            item.rx_valid=ram_test_vif.rx_valid;
            item.din=ram_test_vif.din; 
            mon_ap.write(item);
        end
    endtask //
    endclass //className extends superClass
endpackage