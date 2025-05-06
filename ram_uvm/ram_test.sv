package ram_test_pkg;
import env_pac::*;
import uvm_pkg::*;
import reset_sequence::*;
import ran_sequence::*;
import cfg::*;
`include "uvm_macros.svh"
class ram_test extends uvm_test;
    int  Testcases = 50000;
    `uvm_component_utils(ram_test)
    ram_confg cfgg;
    ram_env env;
    reset_seq reset_sequence;
    ran_seq ran_sequence;
    function new(string name = "ram_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = ram_env::type_id::create("env",this);
        cfgg = ram_confg::type_id::create("cfgg",this);
        reset_sequence = reset_seq::type_id::create("reset_sequence",this);
        ran_sequence = ran_seq::type_id::create("ran_sequence",this);
        if(!uvm_config_db#(virtual ram_inter)::get(this,"","ram_test_vif",cfgg.ram_test_vif))
        `uvm_fatal("build_phase","a333333333");
        cfgg.is_active=UVM_ACTIVE;
        uvm_config_db#(ram_confg)::set(null,"*","CFG",cfgg);
    endfunction 

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run_phase","run_phase started",UVM_MEDIUM)
        // start reset sequence
        `uvm_info("run_phase","reset asserted",UVM_MEDIUM)
        reset_sequence.start(env.agt.sqr);
        // start random sequence
        `uvm_info("run_phase","random sequence started",UVM_MEDIUM)
        repeat(Testcases) begin
            ran_sequence.start(env.agt.sqr);
        end
        `uvm_info("run_phase","random sequence finished",UVM_MEDIUM)
        `uvm_info("run_phase","reset asserted",UVM_MEDIUM)
         reset_sequence.start(env.agt.sqr);
        `uvm_info("run_phase", $sformatf("correct_count=%0d , wrong_count = %0d",env.sb.correct_count,env.sb.wrong_count),UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
    

endclass 

endpackage