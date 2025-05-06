package env_pac;
import uvm_pkg::*;
import Spi_slave_agtt::*;
import coverage_pkg::*;
import scoreborad_pck::*;
`include "uvm_macros.svh"

class Spi_slave_env extends uvm_env;
    `uvm_component_utils(Spi_slave_env)
    Spi_slave_agt agt;
    Spi_slave_scoreborad sb;
    Spi_slave_cover cov;
    function new(string name = "Spi_slave_env" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        agt = Spi_slave_agt::type_id::create("agt",this);
        sb = Spi_slave_scoreborad::type_id::create("sb",this);
        cov = Spi_slave_cover::type_id::create("cov",this);
    endfunction 
    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        agt.agt_ap.connect(sb.sb_export);
        agt.agt_ap.connect(cov.cov_export);
    endfunction 
endclass 
    
endpackage