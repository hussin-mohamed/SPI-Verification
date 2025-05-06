package coverage_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_item::*;
class ram_cover extends uvm_component;
`uvm_component_utils(ram_cover)
uvm_analysis_export #(seq_item) cov_export;
uvm_tlm_analysis_fifo #(seq_item) cov_fifo;
seq_item item;
covergroup g1 ;
    option.auto_bin_max = 0;
        rx: coverpoint item.rx_valid
        {
            bins rx_on = {1};
            bins rx_off = {0};
        }  
        rst: coverpoint item.rst_n
        {
            bins rst_deasserted = {1};
            bins rst_asserted = {0};
        }
        din: coverpoint item.din[9:8]
        {
            bins write_address = {2'b00};
            bins write_data = {2'b01};
            bins read_address = {2'b10};
            bins read_data = {2'b11};
        }
        rx_with_reset: cross rx,rst
        {
            bins rx_on_rst_deasserted = binsof(rx.rx_on) && binsof(rst.rst_deasserted);
            illegal_bins rx_on_rst_asserted = binsof(rx.rx_on) && binsof(rst.rst_asserted); 
            bins rx_off_rst_deasserted = binsof(rx.rx_off) && binsof(rst.rst_deasserted);
            bins rx_off_rst_asserted = binsof(rx.rx_off) && binsof(rst.rst_asserted);
        }
        rx_with_din: cross rx,din
        {
            bins rx_on_write_address = binsof(rx.rx_on) && binsof(din.write_address);
            bins rx_on_write_data = binsof(rx.rx_on) && binsof(din.write_data);
            bins rx_on_read_address = binsof(rx.rx_on) && binsof(din.read_address);
            bins rx_on_read_data = binsof(rx.rx_on) && binsof(din.read_data);
            bins rx_off_write_address = binsof(rx.rx_off) && binsof(din.write_address);
            bins rx_off_write_data = binsof(rx.rx_off) && binsof(din.write_data);
            bins rx_off_read_address = binsof(rx.rx_off) && binsof(din.read_address);
            bins rx_off_read_data = binsof(rx.rx_off) && binsof(din.read_data);
        }
        endgroup

   function new(string name = "ram_cover" , uvm_component parent = null);
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