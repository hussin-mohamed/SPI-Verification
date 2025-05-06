package coverage_pkgg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_itemm::*;
class Spi_slave_cover extends uvm_component;
`uvm_component_utils(Spi_slave_cover)
uvm_analysis_export #(seq_itemm) cov_export;
uvm_tlm_analysis_fifo #(seq_itemm) cov_fifo;
seq_itemm item;
parameter maxpos=3, maxneg=-4, zero=0 ;
covergroup g1 ;
        rst: coverpoint item.rst_n
        {
            bins rst_deasserted = {1};
            bins rst_asserted = {0};
        }
        ss_n: coverpoint item.SS_n
        {
            bins ss_n_deasserted = {1};
            bins ss_n_asserted = {0};
        }
        tx_valid: coverpoint item.tx_valid
        {
            bins tx_valid_deasserted = {1};
            bins tx_valid_asserted = {0};
        }
        packet: coverpoint item.packet[10:8]
        {
           bins write_address = {3'b000};
            bins write_data = {3'b001};
            bins read_address = {3'b110};
            bins read_data = {3'b111};
        }
        ss_n_with_reset: cross ss_n,rst
        {
            bins ss_n_on_rst_deasserted = binsof(ss_n.ss_n_deasserted) && binsof(rst.rst_deasserted);
            bins ss_n_on_rst_asserted = binsof(ss_n.ss_n_deasserted) && binsof(rst.rst_asserted); 
            bins ss_n_off_rst_deasserted = binsof(ss_n.ss_n_asserted) && binsof(rst.rst_deasserted);
            bins ss_n_off_rst_asserted = binsof(ss_n.ss_n_asserted) && binsof(rst.rst_asserted);
        }
        tx_valid_with_reset: cross tx_valid,rst
        {
            bins tx_valid_on_rst_deasserted = binsof(tx_valid.tx_valid_deasserted) && binsof(rst.rst_deasserted);
            illegal_bins tx_valid_on_rst_asserted = binsof(tx_valid.tx_valid_deasserted) && binsof(rst.rst_asserted); 
            bins tx_valid_off_rst_deasserted = binsof(tx_valid.tx_valid_asserted) && binsof(rst.rst_deasserted);
            bins tx_valid_off_rst_asserted = binsof(tx_valid.tx_valid_asserted) && binsof(rst.rst_asserted);
        }
        packet_with_reset: cross packet,rst
        {
            bins write_address_rst_deasserted = binsof(packet.write_address) && binsof(rst.rst_deasserted);
            bins write_data_rst_deasserted = binsof(packet.write_data) && binsof(rst.rst_deasserted);
            bins read_address_rst_deasserted = binsof(packet.read_address) && binsof(rst.rst_deasserted);
            bins read_data_rst_deasserted = binsof(packet.read_data) && binsof(rst.rst_deasserted);
            bins write_address_rst_asserted = binsof(packet.write_address) && binsof(rst.rst_asserted);
            illegal_bins write_data_rst_asserted = binsof(packet.write_data) && binsof(rst.rst_asserted);
            illegal_bins read_address_rst_asserted = binsof(packet.read_address) && binsof(rst.rst_asserted);
            illegal_bins read_data_rst_asserted = binsof(packet.read_data) && binsof(rst.rst_asserted);
        }
        packet_with_ssn: cross packet,ss_n
        {
            bins write_address_ssn_deasserted = binsof(packet.write_address) && binsof(ss_n.ss_n_deasserted);
            bins write_data_ssn_deasserted = binsof(packet.write_data) && binsof(ss_n.ss_n_deasserted);
            bins read_address_ssn_deasserted = binsof(packet.read_address) && binsof(ss_n.ss_n_deasserted);
            bins read_data_ssn_deasserted = binsof(packet.read_data) && binsof(ss_n.ss_n_deasserted);
            bins write_address_ssn_asserted = binsof(packet.write_address) && binsof(ss_n.ss_n_asserted);
            bins write_data_ssn_asserted = binsof(packet.write_data) && binsof(ss_n.ss_n_asserted);
            bins read_address_ssn_asserted = binsof(packet.read_address) && binsof(ss_n.ss_n_asserted);
            bins read_data_ssn_asserted = binsof(packet.read_data) && binsof(ss_n.ss_n_asserted);
        } 
        endgroup

   function new(string name = "Spi_slave_cover" , uvm_component parent = null);
        super.new(name,parent);
        g1=new();
    endfunction
    
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        cov_export=new("sb_export",this);
        cov_fifo=new("sb_fifo",this);
    endfunction 

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction 
     task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
        cov_fifo.get(item);
        g1.sample();
        end
    endtask
endclass 
    
endpackage