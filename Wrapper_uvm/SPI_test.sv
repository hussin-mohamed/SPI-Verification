package spi_test_pkg;
import env_pac::*;
import env_pack::*;
import env_packk::*;
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
import cfgg::*;
import cfggg::*;
`include "uvm_macros.svh"
class spi_test extends uvm_test;
    `uvm_component_utils(spi_test)
    spi_confg conf_spi;
    spi_env env;
    Spi_slave_confg conf_slave;
    ram_confg conf_ram;
    Spi_slave_env slave_env;
    ram_env ramm_env;
    reset_seq reset_seqq;
    randomized_inp_seq randomized_inp_seqq;
    read_add_seq read_add_seqq;
    write_add_seq write_add_seqq;
    write_data_seq write_data_seqq;
    read_data_seq read_data_seqq;
    terminate_conn_seq terminate_conn_seqq;
    start_conn_seq start_conn_seqq;
    function new(string name = "spi_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = spi_env::type_id::create("env",this);
        slave_env = Spi_slave_env::type_id::create("slave_env",this);
        ramm_env = ram_env::type_id::create("ramm_env",this);
        conf_spi = spi_confg::type_id::create("cfgg",this);
        conf_slave = Spi_slave_confg::type_id::create("conf_slave",this);
        conf_ram = ram_confg::type_id::create("conf_ram",this);
        reset_seqq = reset_seq::type_id::create("reset_seq",this);
        randomized_inp_seqq = randomized_inp_seq::type_id::create("randomized_inp_seq",this);
        read_add_seqq = read_add_seq::type_id::create("read_add_seq",this);
        write_add_seqq = write_add_seq::type_id::create("write_add_seq",this);
        write_data_seqq = write_data_seq::type_id::create("write_data_seq",this);
        read_data_seqq = read_data_seq::type_id::create("read_data_seq",this);
        terminate_conn_seqq = terminate_conn_seq::type_id::create("terminate_conn_seq",this);
        start_conn_seqq = start_conn_seq::type_id::create("start_conn_seq",this);
        if(!uvm_config_db#(virtual Spi_inter)::get(this,"","spi_test_vif",conf_spi.spi_test_vif))
        `uvm_fatal("build_phase","a333333333");
        if(!uvm_config_db#(virtual Spi_slave_inter)::get(this,"","Spi_slave_test_vif",conf_slave.Spi_slave_test_vif))
        `uvm_fatal("build_phase","wrong in build phase");
        if(!uvm_config_db#(virtual ram_inter)::get(this,"","ram_test_vif",conf_ram.ram_test_vif))
        `uvm_fatal("build_phase","a333333333");
        conf_spi.is_active=UVM_ACTIVE;
        conf_ram.is_active=UVM_PASSIVE;
        conf_slave.is_active=UVM_PASSIVE;
        uvm_config_db#(spi_confg)::set(null,"*","CFG",conf_spi);
        uvm_config_db#(Spi_slave_confg)::set(null,"*","CFG",conf_slave);
        uvm_config_db#(ram_confg)::set(null,"*","CFG",conf_ram);

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