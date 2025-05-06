package Spi_slave_agtt;
    import uvm_pkg::*;
    import driver::*;
    import seqr_pack::*;
    import Spi_slave_monitor::*;
    import cfgg::*;
    import sequence_itemm::*;
    `include "uvm_macros.svh"
    class Spi_slave_agt extends uvm_agent;
        `uvm_component_utils(Spi_slave_agt)
        Spi_slave_driver driver;
        Spi_slave_monitor monitor;
        Spi_slave_confg cfg;
        sqrr_class sqr;
        uvm_analysis_port #(seq_itemm) agt_ap;
        function new(string name="Spi_slave_agt", uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor = Spi_slave_monitor::type_id::create("mon",this);
        if(!uvm_config_db #(Spi_slave_confg) :: get(this,"","CFG",cfg))
        `uvm_fatal("build_phase","no");
        if(cfg.is_active==UVM_ACTIVE)
            begin
                driver = Spi_slave_driver::type_id::create("driver",this);
                sqr = sqrr_class::type_id::create("sqr",this);   
            end
        agt_ap = new("agt_ap",this);
        endfunction
        function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        monitor.Spi_slave_test_vif=cfg.Spi_slave_test_vif;
        if(cfg.is_active==UVM_ACTIVE)
            begin
                driver.Spi_slave_test_vif=cfg.Spi_slave_test_vif;
                driver.seq_item_port.connect(sqr.seq_item_export);    
            end

        monitor.mon_ap.connect(agt_ap);
    endfunction 
    endclass //className extends superClass
endpackage