package Spi_slave_test_pkg;
import env_pac::*;
import uvm_pkg::*;
import read_add_sequence::*;
import write_add_sequence::*;
import write_data_sequence::*;
import reset_sequence::*;
import read_data_sequence::*;
import randomized_inp_sequence::*;
import terminate_conn_sequence::*;
import start_conn_sequence::*;
import cfg::*;
`include "uvm_macros.svh"
class Spi_slave_test extends uvm_test;
    `uvm_component_utils(Spi_slave_test)
    Spi_slave_confg cfgg;
    Spi_slave_env env;
    reset_seq reset_seqq;
    randomized_inp_seq randomized_inp_seqq;
    read_add_seq read_add_seqq;
    write_add_seq write_add_seqq;
    write_data_seq write_data_seqq;
    read_data_seq read_data_seqq;
    terminate_conn_seq terminate_conn_seqq;
    start_conn_seq start_conn_seqq;
    function new(string name = "Spi_slave_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = Spi_slave_env::type_id::create("env",this);
        cfgg = Spi_slave_confg::type_id::create("cfgg",this);
        reset_seqq = reset_seq::type_id::create("reset_seq",this);
        randomized_inp_seqq = randomized_inp_seq::type_id::create("randomized_inp_seq",this);
        read_add_seqq = read_add_seq::type_id::create("read_add_seq",this);
        write_add_seqq = write_add_seq::type_id::create("write_add_seq",this);
        write_data_seqq = write_data_seq::type_id::create("write_data_seq",this);
        read_data_seqq = read_data_seq::type_id::create("read_data_seq",this);
        terminate_conn_seqq = terminate_conn_seq::type_id::create("terminate_conn_seq",this);
        start_conn_seqq = start_conn_seq::type_id::create("start_conn_seq",this);
        if(!uvm_config_db#(virtual Spi_slave_inter)::get(this,"","Spi_slave_test_vif",cfgg.Spi_slave_test_vif))
        `uvm_fatal("build_phase","wrong in build phase");
        cfgg.is_active=UVM_ACTIVE;
        uvm_config_db#(Spi_slave_confg)::set(null,"*","CFG",cfgg);
    endfunction 

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run_phase","run_phase started",UVM_MEDIUM)
        // start reset sequence
        `uvm_info("run_phase","reset asserted",UVM_MEDIUM)
        repeat(10)begin    
        reset_seqq.start(env.agt.sqr);
        end
        // start write address sequence
        `uvm_info("run_phase","write address sequence with known address started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(11) begin
            write_add_seqq.start(env.agt.sqr);
        end
        terminate_conn_seqq.start(env.agt.sqr);
        // start write data sequence
        `uvm_info("run_phase","write data sequence started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(11) begin
            write_data_seqq.start(env.agt.sqr);
        end
        terminate_conn_seqq.start(env.agt.sqr);
        // start read address sequence
        `uvm_info("run_phase","read address sequence with known address started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(11) begin
            read_add_seqq.start(env.agt.sqr);
        end
        terminate_conn_seqq.start(env.agt.sqr);
        // start read data sequence
        `uvm_info("run_phase","read data sequence started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(19) begin
            read_data_seqq.start(env.agt.sqr);
        end 
        terminate_conn_seqq.start(env.agt.sqr);
        // start random address
        repeat (1000)begin
            `uvm_info("run_phase","write address sequence with unknown address started",UVM_MEDIUM)
            start_conn_seqq.start(env.agt.sqr);
        repeat(11) begin
            write_data_seqq.start(env.agt.sqr);
        end
        terminate_conn_seqq.start(env.agt.sqr);
        // start write data sequence
        `uvm_info("run_phase","write data sequence started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(11) begin
            write_data_seqq.start(env.agt.sqr);
        end
        terminate_conn_seqq.start(env.agt.sqr);
        // start read address sequence
        `uvm_info("run_phase","read address sequence with unknown address started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(11) begin
            read_data_seqq.start(env.agt.sqr);
        end
        terminate_conn_seqq.start(env.agt.sqr);
        // start read data sequence
        `uvm_info("run_phase","read data sequence started",UVM_MEDIUM)
        start_conn_seqq.start(env.agt.sqr);
        repeat(19) begin
            read_data_seqq.start(env.agt.sqr);
        end 
        terminate_conn_seqq.start(env.agt.sqr);
        end
        // start random sequence
        `uvm_info("run_phase","random sequence started",UVM_MEDIUM)
        repeat(98720) begin
            randomized_inp_seqq.start(env.agt.sqr);
        end
        `uvm_info("run_phase","random sequence completed",UVM_MEDIUM)
        `uvm_info("run_phase", $sformatf("correct_count=%0d , wrong_count = %0d",env.sb.correct_count,env.sb.wrong_count),UVM_MEDIUM)
        phase.drop_objection(this);
    endtask
    

endclass 

endpackage