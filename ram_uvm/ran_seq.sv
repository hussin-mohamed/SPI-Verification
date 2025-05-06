package ran_sequence;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class ran_seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(ran_seq)
    seq_item item;
    function new(string name = "ran_seq");
        super.new(name);
    endfunction //new()
    task body();
        item = seq_item::type_id::create("item");
        start_item(item);
        assert (item.randomize());
        finish_item(item);
    endtask 
endclass //main_seq extends uvm_sequence
endpackage