package read_add_sequence;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class read_add_seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(read_add_seq)
    seq_item item;
    function new(string name = "read_add_seq");
        super.new(name);
    endfunction //new()
    task body();
        item = seq_item::type_id::create("item");
        start_item(item);
        item.ss_n_asserted_reset_deasserted.constraint_mode(1);
        item.ss_n_deasserted_reset_asserted.constraint_mode(0);
        item.ss_n_asserted_reset_asserted.constraint_mode(0);
        item.ss_n_deasserted_reset_deasserted.constraint_mode(0);
        item.ss_n_randomized_reset_randomized.constraint_mode(0);
        assert(item.randomize());
        item.packet[7:0] = 8'b00000000; // first address
        item.packet_old=item.packet;
        finish_item(item);
    endtask 
endclass //main_seq extends uvm_sequence
endpackage