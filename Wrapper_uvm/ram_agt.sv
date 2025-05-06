package ram_agtt;
    import uvm_pkg::*;
    import driverr::*;
    import seqr_packk::*;
    import monitorr::*;
    import cfggg::*;
    import sequence_itemmm::*;
    `include "uvm_macros.svh"
    class ram_agt extends uvm_agent;
        `uvm_component_utils(ram_agt)
        ram_driver driver;
        ram_monitor monitor;
        ram_confg cfg;
        sqrrr_class sqr;
        uvm_analysis_port #(seq_itemmm) agt_ap;
        function new(string name="ram_agt", uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor = ram_monitor::type_id::create("monitor",this);
        if(!uvm_config_db #(ram_confg) :: get(this,"","CFG",cfg))
        `uvm_fatal("build_phase","no");
        if(cfg.is_active==UVM_ACTIVE)
            begin
                driver = ram_driver::type_id::create("driver",this);
                sqr = sqrrr_class::type_id::create("sqr",this);   
            end
        agt_ap = new("agt_ap",this);
        endfunction
        function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        monitor.ram_test_vif=cfg.ram_test_vif;
        monitor.mon_ap.connect(agt_ap);
        if(cfg.is_active==UVM_ACTIVE)
            begin
                driver.ram_test_vif=cfg.ram_test_vif;
                driver.seq_item_port.connect(sqr.seq_item_export);    
            end
    endfunction 
    endclass //className extends superClass
endpackage