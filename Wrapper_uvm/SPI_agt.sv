package spi_agtt;
    import uvm_pkg::*;
    import drive::*;
    import seqr_pac::*;
    import spi_monitor::*;
    import cfg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class spi_agt extends uvm_agent;
        `uvm_component_utils(spi_agt)
        spi_driver driver;
        spi_monitor monitor;
        spi_confg cfg;
        sqr_class sqr;
        uvm_analysis_port #(seq_item) agt_ap;
        function new(string name="spi_agt", uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor = spi_monitor::type_id::create("mon",this);
        if(!uvm_config_db #(spi_confg) :: get(this,"","CFG",cfg))
        `uvm_fatal("build_phase","no");
        if(cfg.is_active==UVM_ACTIVE)
            begin
                driver = spi_driver::type_id::create("driver",this);
                sqr = sqr_class::type_id::create("sqr",this);   
            end
        agt_ap = new("agt_ap",this);
        endfunction
        function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        monitor.spi_test_vif=cfg.spi_test_vif;
        monitor.mon_ap.connect(agt_ap);
        if(cfg.is_active==UVM_ACTIVE)
            begin
                driver.spi_test_vif=cfg.spi_test_vif;
                driver.seq_item_port.connect(sqr.seq_item_export);    
            end
    endfunction 
    endclass //className extends superClass
endpackage