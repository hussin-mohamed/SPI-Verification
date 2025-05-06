package env_pac;
import uvm_pkg::*;
import ram_agtt::*;
import coverage_pkg::*;
import scoreborad_pck::*;
`include "uvm_macros.svh"

class ram_env extends uvm_env;
    `uvm_component_utils(ram_env)
    ram_agt agt;
    ram_scoreborad sb;
    ram_cover cov;
    function new(string name = "ram_env" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        agt = ram_agt::type_id::create("agt",this);
        sb = ram_scoreborad::type_id::create("sb",this);
        cov = ram_cover::type_id::create("cov",this);
    endfunction 
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        agt.agt_ap.connect(sb.sb_export);
        agt.agt_ap.connect(cov.cov_export);
    endfunction 
endclass 
    
endpackage